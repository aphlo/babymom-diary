import 'package:flutter/material.dart';

import '../models/mom_diary_ui_model.dart';

class MomDiaryTable extends StatelessWidget {
  const MomDiaryTable({
    super.key,
    required this.entries,
    this.onEntryTap,
  });

  final List<MomDiaryEntryUiModel> entries;
  final ValueChanged<MomDiaryEntryUiModel>? onEntryTap;

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
                itemCount: entries.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, thickness: 0.8, color: borderColor),
                itemBuilder: (context, index) {
                  final entry = entries[index];
                  return _TableRow(
                    entry: entry,
                    onTap: onEntryTap != null ? () => onEntryTap!(entry) : null,
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
          _HeaderCell(label: '日記', flex: 3),
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
      child: Text(label, style: style),
    );
  }
}

class _TableRow extends StatelessWidget {
  const _TableRow({required this.entry, this.onTap});

  final MomDiaryEntryUiModel entry;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStyle = theme.textTheme.bodyMedium;
    final contentStyle = theme.textTheme.bodySmall;
    final weekday = entry.date.weekday;
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
                text: entry.dateLabel,
                flex: 1,
                style: dateStyle,
              ),
              _DataCell(
                text: entry.content ?? '',
                flex: 3,
                style: contentStyle,
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
  });

  final String text;
  final int flex;
  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Text(
        text,
        style: style,
        softWrap: true,
      ),
    );
  }
}
