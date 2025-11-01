import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../../../core/theme/app_colors.dart';
import '../models/vaccine_info.dart';
import '../../../children/application/selected_child_provider.dart';
import '../viewmodels/vaccine_reservation_view_model.dart';
import '../widgets/vaccine_header.dart';
import '../widgets/vaccine_type_badge.dart';
import '../styles/vaccine_type_styles.dart';
import '../../domain/entities/vaccination_record.dart';
import '../../domain/value_objects/vaccine_category.dart' as vo;
import '../../domain/value_objects/vaccine_requirement.dart';

class VaccineReservationPage extends ConsumerStatefulWidget {
  const VaccineReservationPage({
    super.key,
    required this.vaccine,
    required this.doseNumber,
  });

  final VaccineInfo vaccine;
  final int doseNumber;

  @override
  ConsumerState<VaccineReservationPage> createState() =>
      _VaccineReservationPageState();
}

class _VaccineReservationPageState
    extends ConsumerState<VaccineReservationPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final params = VaccineReservationParams(
      vaccine: widget.vaccine,
      doseNumber: widget.doseNumber,
    );

    final viewModel =
        ref.watch(vaccineReservationViewModelProvider(params).notifier);
    final state = ref.watch(vaccineReservationViewModelProvider(params));

    // エラー表示
    ref.listen(vaccineReservationViewModelProvider(params), (previous, next) {
      if (next.error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.red,
          ),
        );
        viewModel.clearError();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(
        title: const Text('ワクチン接種予約'),
        actions: [
          if (state.canSubmit)
            TextButton(
              onPressed: state.isSubmitting
                  ? null
                  : () => _submitReservation(context, viewModel),
              child: state.isSubmitting
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('予約'),
            ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _VaccineInfoCard(
                    vaccine: widget.vaccine,
                    doseNumber: widget.doseNumber,
                  ),
                  const SizedBox(height: 24),
                  _DateSelectionCard(
                    selectedDate: state.scheduledDate,
                    onDateSelected: viewModel.setScheduledDate,
                    vaccine: widget.vaccine,
                    doseNumber: widget.doseNumber,
                  ),
                  const SizedBox(height: 24),
                  _ConcurrentVaccinesCard(
                    availableVaccines: state.availableVaccines,
                    selectedVaccines: state.selectedAdditionalVaccines,
                    isExpanded: state.isAccordionExpanded,
                    onToggleExpanded: viewModel.toggleAccordion,
                    onToggleVaccine: viewModel.toggleAdditionalVaccine,
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> _submitReservation(
    BuildContext context,
    VaccineReservationViewModel viewModel,
  ) async {
    final selectedChildId = ref.read(selectedChildControllerProvider).value;
    if (selectedChildId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('子供が選択されていません'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final success = await viewModel.createReservation(selectedChildId);
    if (success && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('予約が完了しました'),
          backgroundColor: Colors.green,
        ),
      );
      context.pop();
    }
  }
}

class _VaccineInfoCard extends StatelessWidget {
  const _VaccineInfoCard({
    required this.vaccine,
    required this.doseNumber,
  });

  final VaccineInfo vaccine;
  final int doseNumber;

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
                  '$doseNumber回目の接種',
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
}

class _DateSelectionCard extends StatelessWidget {
  const _DateSelectionCard({
    required this.selectedDate,
    required this.onDateSelected,
    required this.vaccine,
    required this.doseNumber,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;
  final VaccineInfo vaccine;
  final int doseNumber;

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
            '予約日時',
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
          const SizedBox(height: 16),
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
      minTime: now,
      maxTime: now.add(const Duration(days: 365 * 2)),
      onConfirm: (date) {
        onDateSelected(date);
      },
      currentTime: initialDate,
      locale: LocaleType.jp,
    );
  }
}

class _ConcurrentVaccinesCard extends StatelessWidget {
  const _ConcurrentVaccinesCard({
    required this.availableVaccines,
    required this.selectedVaccines,
    required this.isExpanded,
    required this.onToggleExpanded,
    required this.onToggleVaccine,
  });

  final List<VaccinationRecord> availableVaccines;
  final List<VaccinationRecord> selectedVaccines;
  final bool isExpanded;
  final VoidCallback onToggleExpanded;
  final ValueChanged<String> onToggleVaccine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
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
        children: [
          InkWell(
            onTap: onToggleExpanded,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '同時接種するワクチン',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        if (selectedVaccines.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            '${selectedVaccines.length}個のワクチンを選択中',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1),
            if (availableVaccines.isEmpty)
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  '同時接種可能なワクチンがありません',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade600,
                  ),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: availableVaccines.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final VaccinationRecord vaccine = availableVaccines[index];
                  final bool isSelected = selectedVaccines
                      .any((v) => v.vaccineId == vaccine.vaccineId);
                  final int nextDose = vaccine.nextAvailableDose ?? 1;

                  return CheckboxListTile(
                    value: isSelected,
                    onChanged: (_) => onToggleVaccine(vaccine.vaccineId),
                    title: Text(
                      '${vaccine.vaccineName} $nextDose回目',
                      style: theme.textTheme.bodyLarge,
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          _RequirementBadge(
                            requirement: vaccine.requirement,
                          ),
                          const SizedBox(width: 8),
                          _VaccineTypeBadge(
                            category: vaccine.category,
                          ),
                        ],
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                  );
                },
              ),
          ],
        ],
      ),
    );
  }
}

// バッジクラスの定義
class _RequirementBadge extends StatelessWidget {
  const _RequirementBadge({required this.requirement});

  final VaccineRequirement requirement;

  @override
  Widget build(BuildContext context) {
    final presentation = _RequirementPresentation.fromRequirement(requirement);
    final textStyle = Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: presentation.foregroundColor,
            ) ??
        TextStyle(
          fontWeight: FontWeight.w700,
          color: presentation.foregroundColor,
          fontSize: 12,
        );

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: presentation.backgroundColor,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(presentation.label, style: textStyle),
    );
  }
}

class _VaccineTypeBadge extends StatelessWidget {
  const _VaccineTypeBadge({required this.category});

  final vo.VaccineCategory category;

  @override
  Widget build(BuildContext context) {
    final typeStyles = vaccineTypeStylesFromValueObject(category);

    return VaccineTypeBadge(
      label: typeStyles.label,
      backgroundColor: typeStyles.backgroundColor,
      foregroundColor: typeStyles.foregroundColor,
      borderColor: typeStyles.borderColor,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      fontSize: 12,
      fontWeight: FontWeight.w700,
      borderWidth: 0,
    );
  }
}

class _RequirementPresentation {
  const _RequirementPresentation({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;

  static _RequirementPresentation fromRequirement(
      VaccineRequirement requirement) {
    switch (requirement) {
      case VaccineRequirement.mandatory:
        return const _RequirementPresentation(
          label: '定期接種',
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        );
      case VaccineRequirement.optional:
        return const _RequirementPresentation(
          label: '任意接種',
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
        );
    }
  }
}
