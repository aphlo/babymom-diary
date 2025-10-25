import 'package:flutter/material.dart';

import '../models/mom_diary_ui_model.dart';
import 'shared_table_components.dart';

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
    return TableHeader(
      children: const [
        TableHeaderCell(label: '日付', flex: 1, textAlign: TextAlign.left),
        TableHeaderCell(label: '', flex: 3),
      ],
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
    final rowColor = getWeekendRowColor(entry.date, theme);

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
                text: entry.dateLabel,
                flex: 1,
                style: dateStyle,
              ),
              TableDataCell(
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
