import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import '../../../../../core/theme/semantic_colors.dart';
import '../../../domain/value_objects/vaccine_record_type.dart';

/// 日付選択カード
///
/// 予約ページと日程変更ページで共通して使用される
class DateSelectionCard extends StatelessWidget {
  const DateSelectionCard({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
    this.title,
    this.recordType,
    this.onRecordTypeChanged,
  });

  final DateTime? selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  /// カードのタイトル（指定がない場合は表示しない）
  final String? title;

  /// 記録タイプ（予約/接種）- 指定時のみSegmentedButtonを表示
  final VaccineRecordType? recordType;
  final ValueChanged<VaccineRecordType>? onRecordTypeChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool showRecordTypeSelector =
        recordType != null && onRecordTypeChanged != null;

    return Container(
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
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
          ],
          if (showRecordTypeSelector) ...[
            SizedBox(
              width: double.infinity,
              child: SegmentedButton<VaccineRecordType>(
                segments: const [
                  ButtonSegment<VaccineRecordType>(
                    value: VaccineRecordType.scheduled,
                    label: Text('予約'),
                    icon: Icon(Icons.schedule, size: 18),
                  ),
                  ButtonSegment<VaccineRecordType>(
                    value: VaccineRecordType.completed,
                    label: Text('接種'),
                    icon: Icon(Icons.check_circle, size: 18),
                  ),
                ],
                selected: {recordType!},
                onSelectionChanged: (Set<VaccineRecordType> newSelection) {
                  onRecordTypeChanged!(newSelection.first);
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith<Color>(
                    (Set<WidgetState> states) {
                      if (states.contains(WidgetState.selected)) {
                        return context.primaryColor;
                      }
                      return Colors.transparent;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
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
                const Icon(Icons.event, size: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    selectedDate != null
                        ? '${selectedDate!.year}年${selectedDate!.month}月${selectedDate!.day}日'
                        : '日付を選択してください',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: selectedDate != null
                          ? theme.colorScheme.onSurface
                          : context.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (showRecordTypeSelector) const SizedBox(height: 16),
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
