import 'package:flutter/material.dart';

import '../models/mom_record_ui_model.dart';
import 'shared_table_components.dart';

class MomRecordTable extends StatelessWidget {
  const MomRecordTable({
    super.key,
    required this.records,
    this.onRecordTap,
  });

  final List<MomDailyRecordUiModel> records;
  final ValueChanged<MomDailyRecordUiModel>? onRecordTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.dividerColor.withOpacity(0.6);

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        color: theme.colorScheme.surface,
      ),
      child: ClipRRect(
        child: Column(
          children: [
            _TableHeader(theme: theme),
            const Divider(height: 1, thickness: 1),
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: records.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, thickness: 0.8, color: borderColor),
                itemBuilder: (context, index) {
                  final record = records[index];
                  return _TableRow(
                    record: record,
                    onTap:
                        onRecordTap != null ? () => onRecordTap!(record) : null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TableHeader extends StatelessWidget {
  const _TableHeader({required this.theme});

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return TableHeader(
      children: const [
        TableHeaderCell(label: '日付', flex: 1, textAlign: TextAlign.left),
        TableHeaderCell(label: '体温', flex: 1),
        TableHeaderCell(label: '悪露', flex: 2),
        TableHeaderCell(label: '胸', flex: 2),
        TableHeaderCell(label: 'メモ', flex: 2),
      ],
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({required this.record, this.onTap});

  final MomDailyRecordUiModel record;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStyle = theme.textTheme.bodyMedium;
    final cellStyle = theme.textTheme.bodySmall;
    final rowColor = getWeekendRowColor(record.date, theme);

    return Material(
      color: rowColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TableDataCell(
                text: record.dateLabel,
                flex: 1,
                style: dateStyle,
              ),
              TableDataCell(
                text: record.temperatureLabel ?? '',
                flex: 1,
                style: cellStyle,
              ),
              TableDataCell(
                text: record.lochiaSummary ?? '',
                flex: 2,
                style: cellStyle,
                padding: const EdgeInsets.only(left: 8),
              ),
              TableDataCell(
                text: record.breastSummary ?? '',
                flex: 2,
                style: cellStyle,
              ),
              TableDataCell(
                text: record.memo ?? '',
                flex: 2,
                style: cellStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
