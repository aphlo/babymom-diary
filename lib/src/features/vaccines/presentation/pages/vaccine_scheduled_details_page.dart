import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../children/application/selected_child_provider.dart';
import '../../domain/entities/dose_record.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_state.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../viewmodels/concurrent_vaccines_view_model.dart';
import '../widgets/vaccine_header.dart';
import '../widgets/concurrent_vaccines_confirmation_dialog.dart';
import '../widgets/concurrent_vaccines_delete_dialog.dart';
import '../widgets/concurrent_vaccines_revert_dialog.dart';

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
    final bool isInfluenza = vaccine.id == 'influenza';

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
      backgroundColor: AppColors.pageBackground,
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
                return const Center(child: Text('子供が選択されていません'));
              }

              return SingleChildScrollView(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ワクチン情報カード
                    _VaccineInfoCard(
                      vaccine: vaccine,
                      doseNumber: doseNumber,
                      influenzaSeasonLabel: influenzaSeasonLabel,
                      influenzaDoseOrder: influenzaDoseOrder,
                    ),
                    const SizedBox(height: 24),

                    // 予約日時カード
                    _ScheduledDateCard(statusInfo: statusInfo),
                    const SizedBox(height: 24),

                    // 同時接種ワクチンカード
                    _ConcurrentVaccinesCard(
                      householdId: householdId,
                      childId: childId,
                      vaccine: vaccine,
                      currentDoseNumber: doseNumber,
                      reservationGroupId: statusInfo.reservationGroupId,
                    ),
                  ],
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                const Center(child: Text('子供情報の取得に失敗しました')),
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
                  label: const Text('日程を変更する'),
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
                      backgroundColor: Colors.orange,
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
                      backgroundColor: Colors.green,
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

    // 同時接種ワクチンがある場合の確認ダイアログ
    final groupId = statusInfo.reservationGroupId;
    bool applyToGroup = true;

    if (groupId != null) {
      final bool? userSelection = await showConcurrentVaccinesDeleteDialog(
        context: context,
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
        currentVaccineId: vaccine.id,
        currentDoseNumber: doseNumber,
      );

      if (userSelection == null) {
        return;
      }
      applyToGroup = userSelection;
    }

    final params = VaccineDetailParams(
      vaccineId: vaccine.id,
      doseNumbers: [doseNumber],
      householdId: householdId,
      childId: childId,
      childBirthday: null,
    );

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
    // TODO: 日程変更画面への遷移を実装
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
      final bool? userSelection =
          await showConcurrentVaccinesConfirmationDialog(
        context: context,
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
        currentVaccineId: vaccine.id,
        currentDoseNumber: doseNumber,
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
      final bool? userSelection = await showConcurrentVaccinesRevertDialog(
        context: context,
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
        currentVaccineId: vaccine.id,
        currentDoseNumber: doseNumber,
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

class _VaccineInfoCard extends StatelessWidget {
  const _VaccineInfoCard({
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VaccineHeader(vaccine: vaccine),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.secondary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.vaccines,
                  color: AppColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  _buildDoseLabel(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _buildDoseLabel() {
    if (vaccine.id != 'influenza') {
      return '$doseNumber回目の接種';
    }
    final bool hasSeason = influenzaSeasonLabel != null &&
        influenzaSeasonLabel!.isNotEmpty &&
        influenzaSeasonLabel != '未設定';
    final String orderPart = ((influenzaDoseOrder ?? doseNumber)).toString();
    final String orderLabel = '$orderPart回目';
    if (hasSeason) {
      return '${influenzaSeasonLabel!}$orderLabelの接種';
    }
    return '$orderLabelの接種';
  }
}

class _ScheduledDateCard extends StatelessWidget {
  const _ScheduledDateCard({required this.statusInfo});

  final DoseStatusInfo statusInfo;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final DateTime? scheduledDate = statusInfo.scheduledDate;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.event_available,
                color: AppColors.reserved,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                '予約日時',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (scheduledDate != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.reserved.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: AppColors.reserved,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateFormatter.yyyyMMddE(scheduledDate),
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.reserved,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Text(
              '予約日時が設定されていません',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ConcurrentVaccinesCard extends ConsumerWidget {
  const _ConcurrentVaccinesCard({
    required this.householdId,
    required this.childId,
    required this.vaccine,
    required this.currentDoseNumber,
    this.reservationGroupId,
  });

  final String householdId;
  final String childId;
  final VaccineInfo vaccine;
  final int currentDoseNumber;
  final String? reservationGroupId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final bool hasGroup =
        reservationGroupId != null && reservationGroupId!.isNotEmpty;

    final ConcurrentVaccinesState? concurrentState = hasGroup
        ? ref.watch(
            concurrentVaccinesViewModelProvider(
              ConcurrentVaccinesParams(
                householdId: householdId,
                childId: childId,
                reservationGroupId: reservationGroupId!,
                currentVaccineId: vaccine.id,
                currentDoseNumber: currentDoseNumber,
              ),
            ),
          )
        : null;

    Widget buildContent() {
      if (!hasGroup) {
        return Text(
          '同時接種するワクチンはありません',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        );
      }

      if (concurrentState == null || concurrentState.isLoading) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (concurrentState.error != null) {
        return Text(
          concurrentState.error!,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.red,
          ),
        );
      }

      if (concurrentState.members.isEmpty) {
        return Text(
          '同時接種するワクチンはありません',
          style: theme.textTheme.bodyMedium?.copyWith(
            color: Colors.grey.shade600,
          ),
        );
      }

      final members = concurrentState.members;

      return Column(
        children: [
          for (var i = 0; i < members.length; i++)
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(
                bottom: i == members.length - 1 ? 0 : 12,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.vaccines,
                    color: AppColors.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      members[i].vaccineName,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    '${members[i].doseNumber}回目',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey.shade700,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      );
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x14000000),
            offset: Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.vaccines,
                color: AppColors.primary,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                '同時接種するワクチン',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          buildContent(),
        ],
      ),
    );
  }
}
