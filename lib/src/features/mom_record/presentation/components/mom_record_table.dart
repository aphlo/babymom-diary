import 'package:flutter/material.dart';

import '../models/mom_record_ui_model.dart';

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
    final headerColor =
        theme.colorScheme.surfaceContainerHighest.withOpacity(0.6);

    return Container(
      color: headerColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: const [
          _HeaderCell(label: '日付', flex: 1),
          _HeaderCell(label: '体温', flex: 1),
          _HeaderCell(label: '悪露', flex: 2),
          _HeaderCell(label: '胸', flex: 2),
          _HeaderCell(label: 'メモ', flex: 2),
        ],
      ),
    );
  }
}

class _HeaderCell extends StatelessWidget {
  const _HeaderCell({required this.label, required this.flex});

  final String label;
  final int flex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.labelLarge?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
    );
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: style,
        textAlign: TextAlign.center,
      ),
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
    final weekday = record.date.weekday;
    final isWeekend =
        weekday == DateTime.saturday || weekday == DateTime.sunday;
    final rowColor = isWeekend
        ? theme.colorScheme.primary.withOpacity(0.04)
        : theme.colorScheme.surface;

    return Material(
      color: rowColor,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _DataCell(
                text: record.dateLabel,
                flex: 1,
                style: dateStyle,
              ),
              _DataCell(
                text: record.temperatureLabel ?? '',
                flex: 1,
                style: cellStyle,
              ),
              _DataCell(
                text: record.lochiaSummary ?? '',
                flex: 2,
                style: cellStyle,
                padding: const EdgeInsets.only(left: 8),
              ),
              _DataCell(
                text: record.breastSummary ?? '',
                flex: 2,
                style: cellStyle,
              ),
              _DataCell(
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

class _DataCell extends StatelessWidget {
  const _DataCell({
    required this.text,
    required this.flex,
    this.style,
    this.padding,
  });

  final String text;
  final int flex;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          text,
          style: style,
          softWrap: true,
        ),
      ),
    );
  }
}
