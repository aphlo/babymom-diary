import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_formatter.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../children/application/selected_child_provider.dart';
import '../../application/vaccine_catalog_providers.dart';
import '../../domain/entities/dose_record.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_state.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../viewmodels/concurrent_vaccines_view_model.dart';
import '../widgets/vaccine_header.dart';
import '../widgets/concurrent_vaccines_confirmation_dialog.dart';
import '../widgets/concurrent_vaccines_delete_dialog.dart';
import '../widgets/concurrent_vaccines_revert_dialog.dart';
import '../widgets/vaccine_error_dialog.dart';
import '../../domain/errors/vaccination_persistence_exception.dart';

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
                    _VaccineInfoCard(
                      vaccine: vaccine,
                      doseNumber: doseNumber,
                      influenzaSeasonLabel: influenzaSeasonLabel,
                      influenzaDoseOrder: influenzaDoseOrder,
                    ),
                    const SizedBox(height: 24),

                    // 予約日時カード
                    _ScheduledDateCard(scheduledDate: currentScheduledDate),
                    const SizedBox(height: 24),

                    // 同時接種ワクチンカード
                    _ConcurrentVaccinesCard(
                      householdId: householdId,
                      childId: childId,
                      vaccine: vaccine,
                      currentDoseNumber: doseNumber,
                      reservationGroupId: currentReservationGroupId,
                      ref: ref,
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
  const _ScheduledDateCard({required this.scheduledDate});

  final DateTime? scheduledDate;

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
          Row(
            children: [
              Icon(
                Icons.event_available,
                color: AppColors.reserved,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                '日付',
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
                          DateFormatter.yyyyMMddE(scheduledDate!),
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
    required this.ref,
  });

  final String householdId;
  final String childId;
  final VaccineInfo vaccine;
  final int currentDoseNumber;
  final String? reservationGroupId;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef buildRef) {
    final theme = Theme.of(context);
    final bool hasGroup =
        reservationGroupId != null && reservationGroupId!.isNotEmpty;

    if (!hasGroup) {
      return _buildCard(theme, _buildEmptyContent(theme));
    }

    // Fetch VaccinationRecord to get actual doseId
    final repository = ref.read(vaccinationRecordRepositoryProvider);
    return FutureBuilder(
      future: repository.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: vaccine.id,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _buildCard(
            theme,
            const Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }

        final record = snapshot.data;
        final doseRecord = record?.getDoseByNumber(currentDoseNumber);

        if (doseRecord == null) {
          return _buildCard(theme, _buildEmptyContent(theme));
        }

        final concurrentState = ref.watch(
          concurrentVaccinesViewModelProvider(
            ConcurrentVaccinesParams(
              householdId: householdId,
              childId: childId,
              reservationGroupId: reservationGroupId!,
              currentVaccineId: vaccine.id,
              currentDoseId: doseRecord.doseId, // Use actual UUID
            ),
          ),
        );

        Widget content;

        if (concurrentState.isLoading) {
          content = const Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: CircularProgressIndicator(),
            ),
          );
        } else if (concurrentState.error != null) {
          content = Text(
            concurrentState.error!,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.red,
            ),
          );
        } else if (concurrentState.members.isEmpty) {
          content = _buildEmptyContent(theme);
        } else {
          final members = concurrentState.members;
          content = Column(
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

        return _buildCard(theme, content);
      },
    );
  }

  Widget _buildCard(ThemeData theme, Widget content) {
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
          content,
        ],
      ),
    );
  }

  Widget _buildEmptyContent(ThemeData theme) {
    return Text(
      '同時接種するワクチンはありません',
      style: theme.textTheme.bodyMedium?.copyWith(
        color: Colors.grey.shade600,
      ),
    );
  }
}
