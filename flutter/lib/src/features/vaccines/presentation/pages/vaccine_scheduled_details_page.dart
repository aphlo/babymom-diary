import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/semantic_colors.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../menu/children/application/selected_child_provider.dart';
import '../../application/vaccine_catalog_providers.dart';
import '../../domain/entities/dose_record.dart';
import '../../domain/errors/vaccination_persistence_exception.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../widgets/concurrent_vaccines/concurrent_vaccines_card.dart';
import '../widgets/concurrent_vaccines/concurrent_vaccines_confirmation_dialog.dart';
import '../widgets/concurrent_vaccines/concurrent_vaccines_delete_dialog.dart';
import '../widgets/concurrent_vaccines/concurrent_vaccines_revert_dialog.dart';
import '../widgets/reservation/scheduled_date_card.dart';
import '../widgets/shared/vaccine_error_dialog.dart';
import '../widgets/shared/vaccine_info_card.dart';

class VaccineScheduledDetailsPage extends ConsumerWidget {
  const VaccineScheduledDetailsPage({
    super.key,
    required this.vaccine,
    required this.doseNumber,
    required this.statusInfo,
    this.influenzaSeasonLabel,
    this.influenzaDoseOrder,
  });

  final VaccineInfo vaccine;
  final int doseNumber;
  final DoseStatusInfo statusInfo;
  final String? influenzaSeasonLabel;
  final int? influenzaDoseOrder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isInfluenza = vaccine.id.startsWith('influenza');

    String doseLabel;
    if (isInfluenza && influenzaDoseOrder != null) {
      final String seasonPart = (influenzaSeasonLabel != null &&
              influenzaSeasonLabel!.isNotEmpty &&
              influenzaSeasonLabel != '未設定')
          ? '${influenzaSeasonLabel!} '
          : '';
      doseLabel = '$seasonPart${influenzaDoseOrder!}回目';
    } else {
      doseLabel = '$doseNumber回目';
    }

    final AsyncValue<String> householdAsync =
        ref.watch(currentHouseholdIdProvider);
    final AsyncValue<String?> selectedChildAsync =
        ref.watch(selectedChildControllerProvider);

    return Scaffold(
      backgroundColor: context.pageBackground,
      appBar: AppBar(
        title: Text('${vaccine.name} $doseLabel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _deleteReservation(context, ref),
          ),
        ],
      ),
      body: householdAsync.when(
        data: (householdId) {
          return selectedChildAsync.when(
            data: (childId) {
              if (childId == null) {
                return const Center(child: Text('子どもが選択されていません'));
              }

              // Watch ViewModel to get live state updates
              final params = VaccineDetailParams(
                vaccineId: vaccine.id,
                doseNumbers: [doseNumber],
                householdId: householdId,
                childId: childId,
                childBirthday: null,
              );
              final detailState =
                  ref.watch(vaccineDetailViewModelProvider(params));
              final currentDoseStatus = detailState.doseStatuses[doseNumber];

              // Get current scheduled date from ViewModel state (live data)
              final DateTime? currentScheduledDate =
                  currentDoseStatus?.scheduledDate;
              final String? currentReservationGroupId =
                  currentDoseStatus?.reservationGroupId;

              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ワクチン情報カード
                    VaccineInfoCard(
                      vaccine: vaccine,
                      doseNumber: doseNumber,
                      influenzaSeasonLabel: influenzaSeasonLabel,
                      influenzaDoseOrder: influenzaDoseOrder,
                    ),
                    const SizedBox(height: 24),

                    // 予約日時カード
                    ScheduledDateCard(scheduledDate: currentScheduledDate),
                    const SizedBox(height: 24),

                    // 同時接種ワクチンカード
                    ConcurrentVaccinesCard(
                      vaccine: vaccine,
                      doseNumber: doseNumber,
                      reservationGroupId: currentReservationGroupId,
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                const Center(child: Text('子ども情報の取得に失敗しました')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) =>
            const Center(child: Text('ホーム情報の取得に失敗しました')),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: () => _navigateToReschedule(context),
                  icon: const Icon(Icons.edit_calendar),
                  label: const Text('日付を変更する'),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (statusInfo.status == DoseStatus.completed) ...[
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => _markAsScheduled(context, ref),
                    icon: const Icon(Icons.undo),
                    label: const Text('未接種に戻す'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: context.revertButtonBackground,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ] else ...[
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton.icon(
                    onPressed: () => _markAsCompleted(context, ref),
                    icon: const Icon(Icons.check_circle),
                    label: const Text('接種済みにする'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: context.completedButtonBackground,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _deleteReservation(BuildContext context, WidgetRef ref) async {
    final householdId = ref.read(currentHouseholdIdProvider).value;
    final childId = ref.read(selectedChildControllerProvider).value;

    if (householdId == null || childId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('必要な情報が不足しています'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final params = VaccineDetailParams(
      vaccineId: vaccine.id,
      doseNumbers: [doseNumber],
      householdId: householdId,
      childId: childId,
      childBirthday: null,
    );

    // 同時接種ワクチンがある場合の確認ダイアログ
    final groupId = statusInfo.reservationGroupId;
    bool applyToGroup = true;

    if (groupId != null) {
      // doseIdを取得するためにVaccinationRecordを取得
      final repository = ref.read(vaccinationRecordRepositoryProvider);
      final record = await repository.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: vaccine.id,
      );
      final doseRecord = record?.getDoseByNumber(doseNumber);

      if (doseRecord == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('接種記録が見つかりません'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      if (!context.mounted) return;

      final bool? userSelection = await showConcurrentVaccinesDeleteDialog(
        context: context,
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
        currentVaccineId: vaccine.id,
        currentDoseId: doseRecord.doseId,
      );

      if (userSelection == null) {
        return;
      }
      applyToGroup = userSelection;
    }

    try {
      final viewModel =
          ref.read(vaccineDetailViewModelProvider(params).notifier);
      await viewModel.deleteVaccineReservation(
        doseNumber: doseNumber,
        applyToGroup: applyToGroup,
        reservationGroupId: groupId,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('予約を削除しました')),
        );
        context.pop();
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('予約の削除に失敗しました: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _navigateToReschedule(BuildContext context) {
    // TODO: 日付変更画面への遷移を実装
    context.push('/vaccines/reschedule', extra: {
      'vaccine': vaccine,
      'doseNumber': doseNumber,
      'statusInfo': statusInfo,
      'influenzaSeasonLabel': influenzaSeasonLabel,
      'influenzaDoseOrder': influenzaDoseOrder,
    });
  }

  void _markAsCompleted(BuildContext context, WidgetRef ref) async {
    final householdId = ref.read(currentHouseholdIdProvider).value;
    final childId = ref.read(selectedChildControllerProvider).value;

    if (householdId == null || childId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('必要な情報が不足しています'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final params = VaccineDetailParams(
      vaccineId: vaccine.id,
      doseNumbers: [doseNumber],
      householdId: householdId,
      childId: childId,
      childBirthday: null,
    );

    final groupId = statusInfo.reservationGroupId;
    bool applyToGroup = true;

    if (groupId != null) {
      // doseIdを取得するためにVaccinationRecordを取得
      final repository = ref.read(vaccinationRecordRepositoryProvider);
      final record = await repository.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: vaccine.id,
      );
      final doseRecord = record?.getDoseByNumber(doseNumber);

      if (doseRecord == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('接種記録が見つかりません'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      if (!context.mounted) return;

      final bool? userSelection =
          await showConcurrentVaccinesConfirmationDialog(
        context: context,
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
        currentVaccineId: vaccine.id,
        currentDoseId: doseRecord.doseId,
      );

      if (userSelection == null) {
        return;
      }
      applyToGroup = userSelection;
    }

    try {
      final viewModel =
          ref.read(vaccineDetailViewModelProvider(params).notifier);
      await viewModel.markDoseAsCompleted(
        doseNumber: doseNumber,
        applyToGroup: applyToGroup,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('接種済みに変更しました')),
        );
        context.pop();
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('接種済みへの変更に失敗しました: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  void _markAsScheduled(BuildContext context, WidgetRef ref) async {
    final householdId = ref.read(currentHouseholdIdProvider).value;
    final childId = ref.read(selectedChildControllerProvider).value;

    if (householdId == null || childId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('必要な情報が不足しています'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final params = VaccineDetailParams(
      vaccineId: vaccine.id,
      doseNumbers: [doseNumber],
      householdId: householdId,
      childId: childId,
      childBirthday: null,
    );

    final groupId = statusInfo.reservationGroupId;
    bool applyToGroup = true;

    if (groupId != null) {
      // doseIdを取得するためにVaccinationRecordを取得
      final repository = ref.read(vaccinationRecordRepositoryProvider);
      final record = await repository.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: vaccine.id,
      );
      final doseRecord = record?.getDoseByNumber(doseNumber);

      if (doseRecord == null) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('接種記録が見つかりません'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      if (!context.mounted) return;

      final bool? userSelection = await showConcurrentVaccinesRevertDialog(
        context: context,
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
        currentVaccineId: vaccine.id,
        currentDoseId: doseRecord.doseId,
      );

      if (userSelection == null) {
        return;
      }
      applyToGroup = userSelection;
    }

    try {
      final viewModel =
          ref.read(vaccineDetailViewModelProvider(params).notifier);
      await viewModel.markDoseAsScheduled(
        doseNumber: doseNumber,
        scheduledDate: statusInfo.scheduledDate ?? DateTime.now(),
        applyToGroup: applyToGroup,
        reservationGroupId: groupId,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('未接種に戻しました')),
        );
        context.pop();
      }
    } on DuplicateScheduleDateException catch (e) {
      if (context.mounted) {
        await VaccineErrorDialog.show(
          context: context,
          title: '予約を変更できません',
          message: e.message,
        );
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('未接種への変更に失敗しました: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }
}
