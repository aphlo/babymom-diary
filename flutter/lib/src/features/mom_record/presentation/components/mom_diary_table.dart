import 'package:flutter/material.dart';

import '../models/mom_diary_ui_model.dart';
import 'shared_table_components.dart';

class MomDiaryTable extends StatefulWidget {
  const MomDiaryTable({
    super.key,
    required this.entries,
    this.onEntryTap,
  });

  final List<MomDiaryEntryUiModel> entries;
  final ValueChanged<MomDiaryEntryUiModel>? onEntryTap;

  @override
  State<MomDiaryTable> createState() => _MomDiaryTableState();
}

class _MomDiaryTableState extends State<MomDiaryTable> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToToday();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToToday() {
    if (_hasScrolled) return;
    if (!mounted) return;
    if (!_scrollController.hasClients) return;
    if (widget.entries.isEmpty) return;

    // 月の識別子を作成（年月を使用）
    final firstEntry = widget.entries.first;
    final monthKey = ValueKey(
        'mom_diary_${firstEntry.date.year}_${firstEntry.date.month}_scrolled');

    // PageStorageに「初期スクロール済み」フラグがあるかチェック
    final bucket = PageStorage.of(context);
    final hasBeenScrolled = bucket.readState(context, identifier: monthKey);
    if (hasBeenScrolled == true) {
      // 既に初期スクロール済みの場合はスクロールしない
      _hasScrolled = true;
      return;
    }

    final today = DateTime.now();
    final todayIndex = widget.entries.indexWhere((entry) {
      final date = entry.date;
      return date.year == today.year &&
          date.month == today.month &&
          date.day == today.day;
    });

    if (todayIndex == -1) {
      // 今日のデータがない場合も、フラグを設定して次回スクロールしないようにする
      bucket.writeState(context, true, identifier: monthKey);
      _hasScrolled = true;
      return;
    }

    // 各行の高さを推定（パディング含めて約60px）
    const estimatedRowHeight = 60.0;
    final targetOffset = todayIndex * estimatedRowHeight;

    _scrollController.jumpTo(targetOffset.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    ));

    // PageStorageに「初期スクロール済み」フラグを保存
    bucket.writeState(context, true, identifier: monthKey);
    _hasScrolled = true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = theme.dividerColor.withValues(alpha: 0.6);

    // スクロール位置保存用のキーを作成
    final firstEntry = widget.entries.isNotEmpty ? widget.entries.first : null;
    final scrollKey = firstEntry != null
        ? PageStorageKey<String>(
            'mom_diary_${firstEntry.date.year}_${firstEntry.date.month}')
        : null;

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
                key: scrollKey,
                controller: _scrollController,
                padding: EdgeInsets.zero,
                itemCount: widget.entries.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, thickness: 0.8, color: borderColor),
                itemBuilder: (context, index) {
                  final entry = widget.entries[index];
                  return _TableRow(
                    entry: entry,
                    onTap: widget.onEntryTap != null
                        ? () => widget.onEntryTap!(entry)
                        : null,
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
