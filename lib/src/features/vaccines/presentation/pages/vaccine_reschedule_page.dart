import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/firebase/household_service.dart';
import '../../../children/application/selected_child_provider.dart';
import '../../application/vaccine_catalog_providers.dart';
import '../models/vaccine_info.dart';
import '../viewmodels/vaccine_detail_state.dart';
import '../viewmodels/vaccine_detail_view_model.dart';
import '../widgets/vaccine_header.dart';
import '../widgets/concurrent_vaccines_reschedule_dialog.dart';
import '../widgets/vaccine_error_dialog.dart';
import '../viewmodels/concurrent_vaccines_view_model.dart';
import '../../domain/errors/vaccination_persistence_exception.dart';

class VaccineReschedulePage extends ConsumerStatefulWidget {
  const VaccineReschedulePage({
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
  ConsumerState<VaccineReschedulePage> createState() =>
      _VaccineReschedulePageState();
}

class _VaccineReschedulePageState extends ConsumerState<VaccineReschedulePage> {
  DateTime? _selectedDate;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // 既存の予約日時をプリセット
    _selectedDate = widget.statusInfo.scheduledDate;
  }

  @override
  Widget build(BuildContext context) {
    final bool canSubmit = _selectedDate != null && !_isLoading;

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: const Text('日付を変更'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _VaccineInfoCard(
                    vaccine: widget.vaccine,
                    doseNumber: widget.doseNumber,
                    influenzaSeasonLabel: widget.influenzaSeasonLabel,
                    influenzaDoseOrder: widget.influenzaDoseOrder,
                  ),
                  const SizedBox(height: 24),
                  _DateSelectionCard(
                    selectedDate: _selectedDate,
                    onDateSelected: (date) {
                      setState(() {
                        _selectedDate = date;
                      });
                    },
                  ),
                  const SizedBox(height: 24),
                  _ConcurrentVaccinesCard(
                    vaccine: widget.vaccine,
                    doseNumber: widget.doseNumber,
                    statusInfo: widget.statusInfo,
                  ),
                ],
              ),
            ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: canSubmit ? () => _updateSchedule(context) : null,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                  : const Text('日付を変更'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateSchedule(BuildContext context) async {
    if (_selectedDate == null) return;

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
    final groupId = widget.statusInfo.reservationGroupId;
    bool applyToGroup = true;

    if (groupId != null) {
      // doseIdを取得するためにVaccinationRecordを取得
      final repository = ref.read(vaccinationRecordRepositoryProvider);
      final record = await repository.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: widget.vaccine.id,
      );
      final doseRecord = record?.getDoseByNumber(widget.doseNumber);

      if (doseRecord == null) {
        if (mounted && context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('接種記録が見つかりません'),
              backgroundColor: Colors.red,
            ),
          );
        }
        return;
      }

      if (!mounted || !context.mounted) return;

      final bool? userSelection = await showConcurrentVaccinesRescheduleDialog(
        context: context,
        householdId: householdId,
        childId: childId,
        reservationGroupId: groupId,
        currentVaccineId: widget.vaccine.id,
        currentDoseId: doseRecord.doseId,
      );

      if (userSelection == null) {
        return;
      }
      applyToGroup = userSelection;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final params = VaccineDetailParams(
        vaccineId: widget.vaccine.id,
        doseNumbers: [widget.doseNumber],
        householdId: householdId,
        childId: childId,
        childBirthday: null,
      );

      final viewModel =
          ref.read(vaccineDetailViewModelProvider(params).notifier);
      await viewModel.updateVaccineReservation(
        doseNumber: widget.doseNumber,
        scheduledDate: _selectedDate!,
        applyToGroup: applyToGroup,
        reservationGroupId: widget.statusInfo.reservationGroupId,
      );

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('日付を変更しました')),
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
            content: Text('日付変更に失敗しました: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
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

class _DateSelectionCard extends StatelessWidget {
  const _DateSelectionCard({
    required this.selectedDate,
    required this.onDateSelected,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

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
          Text(
            '新しい日付',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              alignment: Alignment.centerLeft,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () => _selectDate(context),
            child: Row(
              children: [
                Icon(Icons.event, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.year}年${selectedDate!.month}月${selectedDate!.day}日'
                        : '日付を選択してください',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: selectedDate != null
                          ? theme.colorScheme.onSurface
                          : Colors.grey.shade600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final initialDate = selectedDate ?? now;

    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: now.subtract(const Duration(days: 365 * 20)),
      maxTime: now.add(const Duration(days: 365 * 100)),
      onConfirm: (date) {
        onDateSelected(date);
      },
      currentTime: initialDate,
      locale: LocaleType.jp,
    );
  }
}

class _ConcurrentVaccinesCard extends ConsumerWidget {
  const _ConcurrentVaccinesCard({
    required this.vaccine,
    required this.doseNumber,
    required this.statusInfo,
  });

  final VaccineInfo vaccine;
  final int doseNumber;
  final DoseStatusInfo statusInfo;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final householdId = ref.read(currentHouseholdIdProvider).value;
    final childId = ref.read(selectedChildControllerProvider).value;

    // 予約グループIDがない場合は同時接種ワクチンなし
    final groupId = statusInfo.reservationGroupId;
    if (groupId == null || householdId == null || childId == null) {
      return _buildEmptyCard(theme);
    }

    final params = ConcurrentVaccinesParams(
      householdId: householdId,
      childId: childId,
      reservationGroupId: groupId,
      currentVaccineId: vaccine.id,
      currentDoseId: 'dose_$doseNumber', // doseNumberからdoseIdに変換
    );

    final state = ref.watch(concurrentVaccinesViewModelProvider(params));

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
          if (state.isLoading)
            const Center(child: CircularProgressIndicator())
          else if (state.error != null)
            Text(
              state.error!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.red.shade600,
              ),
            )
          else if (state.members.isEmpty)
            Text(
              '同時接種するワクチンはありません',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
            )
          else
            Column(
              children: state.members.map((member) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.vaccines_outlined,
                        color: AppColors.primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          '${member.vaccineName} ${member.doseNumber}回目',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard(ThemeData theme) {
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
          Text(
            '同時接種するワクチンはありません',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
    );
  }
}
