import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../../core/widgets/bottom_save_button.dart';
import '../models/vaccine_info.dart';
import '../../../menu/children/application/selected_child_provider.dart';
import '../viewmodels/vaccine_reservation_view_model.dart';
import '../widgets/concurrent_vaccines/concurrent_vaccines_selection_card.dart';
import '../widgets/reservation/date_selection_card.dart';
import '../widgets/shared/async_state_views.dart';
import '../widgets/shared/vaccine_error_dialog.dart';
import '../widgets/shared/vaccine_info_card.dart';

class VaccineReservationPage extends ConsumerStatefulWidget {
  const VaccineReservationPage({
    super.key,
    required this.vaccine,
    required this.doseNumber,
    this.influenzaSeasonLabel,
    this.influenzaDoseOrder,
  });

  final VaccineInfo vaccine;
  final int doseNumber;
  final String? influenzaSeasonLabel;
  final int? influenzaDoseOrder;

  @override
  ConsumerState<VaccineReservationPage> createState() =>
      _VaccineReservationPageState();
}

class _VaccineReservationPageState
    extends ConsumerState<VaccineReservationPage> {
  @override
  Widget build(BuildContext context) {
    final String doseLabel = _buildDoseLabel();

    final AsyncValue<String> householdAsync =
        ref.watch(currentHouseholdIdProvider);
    final AsyncValue<String?> selectedChildAsync =
        ref.watch(selectedChildControllerProvider);

    return householdAsync.when(
      data: (householdId) {
        return selectedChildAsync.when(
          data: (childId) {
            if (childId == null) {
              return Scaffold(
                backgroundColor: context.pageBackground,
                appBar: AppBar(
                  title: Text('${widget.vaccine.name} $doseLabel'),
                ),
                body: const NoChildSelectedView(),
              );
            }

            return _VaccineReservationContent(
              vaccine: widget.vaccine,
              doseNumber: widget.doseNumber,
              influenzaSeasonLabel: widget.influenzaSeasonLabel,
              influenzaDoseOrder: widget.influenzaDoseOrder,
              doseLabel: doseLabel,
            );
          },
          loading: () => Scaffold(
            backgroundColor: context.pageBackground,
            appBar: AppBar(
              title: Text('${widget.vaccine.name} $doseLabel'),
            ),
            body: const Center(child: CircularProgressIndicator()),
          ),
          error: (error, stackTrace) => Scaffold(
            backgroundColor: context.pageBackground,
            appBar: AppBar(
              title: Text('${widget.vaccine.name} $doseLabel'),
            ),
            body: const AsyncErrorView(message: '子ども情報の取得に失敗しました'),
          ),
        );
      },
      loading: () => Scaffold(
        backgroundColor: context.pageBackground,
        appBar: AppBar(
          title: Text('${widget.vaccine.name} $doseLabel'),
        ),
        body: const Center(child: CircularProgressIndicator()),
      ),
      error: (error, stackTrace) => Scaffold(
        backgroundColor: context.pageBackground,
        appBar: AppBar(
          title: Text('${widget.vaccine.name} $doseLabel'),
        ),
        body: const AsyncErrorView(message: 'ホーム情報の取得に失敗しました'),
      ),
    );
  }

  String _buildDoseLabel() {
    final bool isInfluenza = widget.vaccine.id.startsWith('influenza');
    if (isInfluenza && widget.influenzaDoseOrder != null) {
      final String seasonPart = (widget.influenzaSeasonLabel != null &&
              widget.influenzaSeasonLabel!.isNotEmpty &&
              widget.influenzaSeasonLabel != '未設定')
          ? '${widget.influenzaSeasonLabel!} '
          : '';
      return '$seasonPart${widget.influenzaDoseOrder!}回目';
    }
    return '${widget.doseNumber}回目';
  }
}

class _VaccineReservationContent extends ConsumerWidget {
  const _VaccineReservationContent({
    required this.vaccine,
    required this.doseNumber,
    required this.doseLabel,
    this.influenzaSeasonLabel,
    this.influenzaDoseOrder,
  });

  final VaccineInfo vaccine;
  final int doseNumber;
  final String doseLabel;
  final String? influenzaSeasonLabel;
  final int? influenzaDoseOrder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final params = VaccineReservationParams(
      vaccine: vaccine,
      doseNumber: doseNumber,
    );

    final viewModel =
        ref.watch(vaccineReservationViewModelProvider(params).notifier);
    final state = ref.watch(vaccineReservationViewModelProvider(params));
    final bool canSubmit = state.canSubmit && !state.isLoading;

    ref.listen(vaccineReservationViewModelProvider(params), (previous, next) {
      if (next.error != null) {
        if (next.isDuplicateError) {
          VaccineErrorDialog.show(
            context: context,
            title: '保存に失敗しました',
            message: next.error!,
          ).then((_) {
            viewModel.clearError();
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(next.error!),
              backgroundColor: Colors.red,
            ),
          );
          viewModel.clearError();
        }
      }
    });

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: Text('${vaccine.name} $doseLabel'),
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  VaccineInfoCard(
                    vaccine: vaccine,
                    doseNumber: doseNumber,
                    influenzaSeasonLabel: influenzaSeasonLabel,
                    influenzaDoseOrder: influenzaDoseOrder,
                  ),
                  const SizedBox(height: 24),
                  DateSelectionCard(
                    selectedDate: state.scheduledDate,
                    onDateSelected: viewModel.setScheduledDate,
                    recordType: state.recordType,
                    onRecordTypeChanged: viewModel.setRecordType,
                  ),
                  const SizedBox(height: 24),
                  ConcurrentVaccinesSelectionCard(
                    availableVaccines: state.availableVaccines,
                    selectedVaccines: state.selectedAdditionalVaccines,
                    isExpanded: state.isAccordionExpanded,
                    onToggleExpanded: viewModel.toggleAccordion,
                    onToggleVaccine: viewModel.toggleAdditionalVaccine,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: BottomSaveButton(
        onPressed:
            canSubmit ? () => _submitReservation(context, viewModel) : null,
        isLoading: state.isSubmitting,
      ),
    );
  }

  Future<void> _submitReservation(
    BuildContext context,
    VaccineReservationViewModel viewModel,
  ) async {
    final success = await viewModel.createReservation();
    if (success && context.mounted) {
      context.pop();
    }
  }
}
