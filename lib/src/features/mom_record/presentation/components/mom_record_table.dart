import 'package:flutter/material.dart';

import '../models/mom_record_ui_model.dart';
import 'shared_table_components.dart';

class MomRecordTable extends StatefulWidget {
  const MomRecordTable({
    super.key,
    required this.records,
    this.onRecordTap,
  });

  final List<MomDailyRecordUiModel> records;
  final ValueChanged<MomDailyRecordUiModel>? onRecordTap;

  @override
  State<MomRecordTable> createState() => _MomRecordTableState();
}

class _MomRecordTableState extends State<MomRecordTable> {
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
    if (widget.records.isEmpty) return;

    // 月の識別子を作成（年月を使用）
    final firstRecord = widget.records.first;
    final monthKey = ValueKey(
        'mom_record_${firstRecord.date.year}_${firstRecord.date.month}_scrolled');

    // PageStorageに「初期スクロール済み」フラグがあるかチェック
    final bucket = PageStorage.of(context);
    final hasBeenScrolled = bucket.readState(context, identifier: monthKey);
    if (hasBeenScrolled == true) {
      // 既に初期スクロール済みの場合はスクロールしない
      _hasScrolled = true;
      return;
    }

    final today = DateTime.now();
    final todayIndex = widget.records.indexWhere((record) {
      final date = record.date;
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
    final borderColor = theme.dividerColor.withOpacity(0.6);

    // スクロール位置保存用のキーを作成
    final firstRecord = widget.records.isNotEmpty ? widget.records.first : null;
    final scrollKey = firstRecord != null
        ? PageStorageKey<String>(
            'mom_record_${firstRecord.date.year}_${firstRecord.date.month}')
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
                itemCount: widget.records.length,
                separatorBuilder: (_, __) =>
                    Divider(height: 1, thickness: 0.8, color: borderColor),
                itemBuilder: (context, index) {
                  final record = widget.records[index];
                  return _TableRow(
                    record: record,
                    onTap: widget.onRecordTap != null
                        ? () => widget.onRecordTap!(record)
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
