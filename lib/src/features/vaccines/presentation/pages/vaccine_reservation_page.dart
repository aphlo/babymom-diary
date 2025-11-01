import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_colors.dart';
import '../models/vaccine_info.dart';
import '../../../children/application/selected_child_provider.dart';
import '../viewmodels/vaccine_reservation_view_model.dart';
import '../widgets/vaccine_header.dart';

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
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.vaccines,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '$doseNumber回目の接種',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
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
          InkWell(
            onTap: () => _selectDate(context),
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      selectedDate != null
                          ? '${selectedDate!.year}年${selectedDate!.month}月${selectedDate!.day}日'
                          : '日付を選択してください',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: selectedDate != null
                            ? theme.colorScheme.onSurface
                            : Colors.grey.shade600,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: Colors.blue.shade700,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '接種時期の目安: ${_getVaccinationPeriodText()}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.blue.shade700,
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

    final date = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365 * 2)),
    );

    if (date != null) {
      onDateSelected(date);
    }
  }

  String _getVaccinationPeriodText() {
    // TODO: ワクチンの接種時期情報を取得
    return '生後2ヶ月〜7ヶ月未満';
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

  final List availableVaccines;
  final List selectedVaccines;
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
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  Icon(
                    isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: theme.colorScheme.primary,
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
                  final vaccine = availableVaccines[index];
                  final isSelected = selectedVaccines
                      .any((v) => v.vaccineId == vaccine.vaccineId);
                  final nextDose = vaccine.nextAvailableDose ?? 1;

                  return CheckboxListTile(
                    value: isSelected,
                    onChanged: (_) => onToggleVaccine(vaccine.vaccineId),
                    title: Text(
                      '$vaccine.vaccineName $nextDose回目',
                      style: theme.textTheme.bodyLarge,
                    ),
                    subtitle: Text(
                      vaccine.requirement.name == 'mandatory' ? '定期接種' : '任意接種',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey.shade600,
                      ),
                    ),
                    controlAffinity: ListTileControlAffinity.trailing,
                  );
                },
              ),
          ],
        ],
      ),
    );
  }
}
