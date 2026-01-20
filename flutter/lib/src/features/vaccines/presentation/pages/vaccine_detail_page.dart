import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/core/theme/semantic_colors.dart';

import '../../../menu/children/application/selected_child_provider.dart';
import '../../domain/entities/dose_record.dart';
import '../controllers/vaccine_detail_interactions.dart';
import '../models/vaccine_detail_callbacks.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../widgets/reservation/influenza_dose_reservation_board.dart';
import '../widgets/reservation/scheduled_dose_bottom_sheet.dart';
import '../widgets/reservation/vaccine_dose_reservation_board.dart';
import '../widgets/shared/async_state_views.dart';
import '../widgets/shared/vaccine_header.dart';
import '../widgets/shared/vaccine_notes_section.dart';

class VaccineDetailPage extends ConsumerWidget {
  const VaccineDetailPage({
    super.key,
    required this.vaccine,
    this.childBirthday,
  });

  final VaccineInfo vaccine;
  final DateTime? childBirthday;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<int> doseNumbers = _extractDoseNumbers(vaccine);

    final AsyncValue<String> householdAsync =
        ref.watch(currentHouseholdIdProvider);
    final AsyncValue<String?> selectedChildAsync =
        ref.watch(selectedChildControllerProvider);

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(title: Text(vaccine.name)),
      body: householdAsync.when(
        data: (householdId) {
          return selectedChildAsync.when(
            data: (childId) {
              if (childId == null) {
                return const NoChildSelectedView();
              }

              final params = VaccineDetailParams(
                vaccineId: vaccine.id,
                doseNumbers: List<int>.unmodifiable(doseNumbers),
                householdId: householdId,
                childId: childId,
                childBirthday: childBirthday,
              );

              final VaccineDetailState detailState =
                  ref.watch(vaccineDetailViewModelProvider(params));
              final viewModel =
                  ref.watch(vaccineDetailViewModelProvider(params).notifier);
              final interactions = VaccineDetailInteractions(
                viewModel: viewModel,
                detailState: detailState,
                householdId: householdId,
                childId: childId,
                ref: ref,
              );

              return _VaccineDetailContent(
                vaccine: vaccine,
                state: detailState,
                onReservationTap: _navigateToReservation,
                onScheduledDoseTap:
                    (context, vaccine, doseNumber, statusInfo) =>
                        _showScheduledDoseBottomSheet(
                  context,
                  vaccine,
                  doseNumber,
                  statusInfo,
                  interactions,
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                const AsyncErrorView(message: '子ども情報の取得に失敗しました'),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const AsyncErrorView(message: 'ホーム情報の取得に失敗しました'),
      ),
    );
  }

  List<int> _extractDoseNumbers(VaccineInfo vaccine) {
    final Set<int> result = <int>{};
    vaccine.doseSchedules.values.forEach(result.addAll);
    final List<int> sorted = result.toList()..sort();
    return sorted;
  }

  void _navigateToReservation(
    BuildContext context,
    VaccineInfo vaccine,
    int doseNumber,
  ) {
    context.push('/vaccines/reservation', extra: {
      'vaccine': vaccine,
      'doseNumber': doseNumber,
    });
  }

  void _showScheduledDoseBottomSheet(
    BuildContext context,
    VaccineInfo vaccine,
    int doseNumber,
    DoseStatusInfo statusInfo,
    VaccineDetailInteractions interactions,
  ) {
    // 接種済みの場合は直接詳細ページに遷移
    if (statusInfo.status == DoseStatus.completed) {
      _navigateToVaccineDetails(context, vaccine, doseNumber, statusInfo);
      return;
    }

    // 予約済みの場合はボトムシートを表示
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return ScheduledDoseBottomSheet(
          vaccine: vaccine,
          doseNumber: doseNumber,
          statusInfo: statusInfo,
          onMarkAsCompleted: () {
            Navigator.of(context).pop();
            interactions.markDoseAsCompleted(context, vaccine, doseNumber);
          },
          onShowDetails: () {
            Navigator.of(context).pop();
            _navigateToVaccineDetails(context, vaccine, doseNumber, statusInfo);
          },
        );
      },
    );
  }

  void _navigateToVaccineDetails(
    BuildContext context,
    VaccineInfo vaccine,
    int doseNumber,
    DoseStatusInfo statusInfo,
  ) {
    context.push('/vaccines/scheduled-details', extra: {
      'vaccine': vaccine,
      'doseNumber': doseNumber,
      'statusInfo': statusInfo,
    });
  }
}

class _VaccineDetailContent extends StatelessWidget {
  const _VaccineDetailContent({
    required this.vaccine,
    required this.state,
    required this.onReservationTap,
    required this.onScheduledDoseTap,
  });

  final VaccineInfo vaccine;
  final VaccineDetailState state;
  final VaccineReservationTap? onReservationTap;
  final ScheduledDoseTap? onScheduledDoseTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool isInfluenza = vaccine.id.startsWith('influenza');

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.cardBackground,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: context.cardShadow,
              offset: const Offset(0, 8),
              blurRadius: 20,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VaccineHeader(vaccine: vaccine),
            if (state.isLoading) ...[
              const SizedBox(height: 16),
              const LinearProgressIndicator(minHeight: 3),
            ],
            const SizedBox(height: 24),
            if (state.error != null) ...[
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: context.errorContainerBackground,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  state.error!,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: context.errorText,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            if (state.doseNumbers.isEmpty)
              Text(
                '接種回数の情報が見つかりませんでした',
                style: theme.textTheme.bodyMedium,
              )
            else if (isInfluenza)
              InfluenzaDoseReservationBoard(
                doseNumbers: state.doseNumbers,
                doseStatuses: state.doseStatuses,
                activeDoseNumber: state.activeDoseNumber,
                pendingDoseNumber: state.pendingDoseNumber,
                vaccine: vaccine,
                onReservationTap: onReservationTap,
                onScheduledDoseTap: onScheduledDoseTap,
              )
            else
              VaccineDoseReservationBoard(
                doseNumbers: state.doseNumbers,
                doseStatuses: state.doseStatuses,
                activeDoseNumber: state.activeDoseNumber,
                pendingDoseNumber: state.pendingDoseNumber,
                recommendationText: state.recommendation?.message,
                vaccine: vaccine,
                onReservationTap: onReservationTap,
                onScheduledDoseTap: onScheduledDoseTap,
              ),
            if (vaccine.notes.isNotEmpty) ...[
              const SizedBox(height: 24),
              VaccineNotesSection(notes: vaccine.notes),
            ],
          ],
        ),
      ),
    );
  }
}
