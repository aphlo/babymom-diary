import 'package:flutter/material.dart';

import '../../../baby_food/domain/entities/baby_food_record.dart';
import '../../../feeding_table_settings/domain/entities/feeding_table_settings.dart';
import '../../child_record.dart';
import '../models/record_item_model.dart';
import 'dashed_table_border.dart';
import 'record_table_cell.dart';

/// 離乳食セルタップ時のコールバック
typedef BabyFoodSlotTapCallback = void Function(int hour);

class RecordTable extends StatefulWidget {
  const RecordTable({
    super.key,
    required this.records,
    required this.onSlotTap,
    required this.scrollStorageKey,
    required this.selectedDate,
    this.babyFoodRecords = const [],
    this.onBabyFoodSlotTap,
    this.settings = const FeedingTableSettings(),
  });

  final List<RecordItemModel> records;
  final RecordSlotTapCallback onSlotTap;
  final PageStorageKey<String> scrollStorageKey;
  final DateTime selectedDate;

  /// 離乳食記録（別コレクションから取得）
  final List<BabyFoodRecord> babyFoodRecords;

  /// 離乳食セルタップ時のコールバック
  final BabyFoodSlotTapCallback? onBabyFoodSlotTap;

  /// 授乳表の設定（表示カテゴリ・順序）
  final FeedingTableSettings settings;

  static const double headerRowHeight = 44.0;
  static const double bodyRowHeight = 32.0;

  static const _borderDashPattern = <double>[1.5, 2.5];

  /// 設定に基づいて動的にカラム幅を生成
  Map<int, TableColumnWidth> get columnWidths {
    final widths = <int, TableColumnWidth>{
      0: const FlexColumnWidth(0.7), // 時間列
    };
    for (var i = 0; i < settings.visibleCategories.length; i++) {
      widths[i + 1] = const FlexColumnWidth(1.0);
    }
    return widths;
  }

  @override
  State<RecordTable> createState() => _RecordTableState();
}

class _RecordTableState extends State<RecordTable> {
  final ScrollController _scrollController = ScrollController();
  bool _hasScrolled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentTime();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToCurrentTime() {
    if (_hasScrolled) return;
    if (!mounted) return;
    if (!_scrollController.hasClients) return;

    // PageStorageに「初期スクロール済み」フラグがあるかチェック
    final bucket = PageStorage.of(context);
    final scrolledKey = ValueKey('${widget.scrollStorageKey.value}_scrolled');
    final hasBeenScrolled = bucket.readState(context, identifier: scrolledKey);
    if (hasBeenScrolled == true) {
      // 既に初期スクロール済みの場合はスクロールしない
      _hasScrolled = true;
      return;
    }

    final now = DateTime.now();
    final selectedDate = widget.selectedDate;
    final today = DateTime.now();
    final isToday = selectedDate.year == today.year &&
        selectedDate.month == today.month &&
        selectedDate.day == today.day;

    if (!isToday) {
      // 今日でない場合も、フラグを設定して次回スクロールしないようにする
      bucket.writeState(context, true, identifier: scrolledKey);
      _hasScrolled = true;
      return;
    }

    // 現在時刻の行までスクロール
    final currentHour = now.hour;
    // 現在時刻の2時間前にスクロール（画面内に現在時刻が含まれるように）
    final targetHour = (currentHour - 2).clamp(0, 23);
    final targetOffset = targetHour * RecordTable.bodyRowHeight;

    _scrollController.jumpTo(targetOffset.clamp(
      0.0,
      _scrollController.position.maxScrollExtent,
    ));

    // PageStorageに「初期スクロール済み」フラグを保存
    bucket.writeState(context, true, identifier: scrolledKey);
    _hasScrolled = true;
  }

  /// 設定に基づいて動的にヘッダーを生成
  List<String> get _headers {
    return [
      '時間',
      ...widget.settings.visibleCategories.map((c) => c.label),
    ];
  }

  /// カテゴリごとの合計値を取得
  _TotalValue _getTotalValue(FeedingTableCategory category) {
    switch (category) {
      case FeedingTableCategory.nursing:
        final count = widget.records
                .where((e) => e.type == RecordType.breastRight)
                .length +
            widget.records.where((e) => e.type == RecordType.breastLeft).length;
        return _TotalValue(value: '$count', unit: '回');
      case FeedingTableCategory.formula:
        final ml = _sumAmount(widget.records, RecordType.formula);
        return _TotalValue(value: ml.toStringAsFixed(0), unit: 'ml');
      case FeedingTableCategory.pump:
        final ml = _sumAmount(widget.records, RecordType.pump);
        return _TotalValue(value: ml.toStringAsFixed(0), unit: 'ml');
      case FeedingTableCategory.babyFood:
        return _TotalValue(
            value: '${widget.babyFoodRecords.length}', unit: '回');
      case FeedingTableCategory.pee:
        final count =
            widget.records.where((e) => e.type == RecordType.pee).length;
        return _TotalValue(value: '$count', unit: '回');
      case FeedingTableCategory.poop:
        final count =
            widget.records.where((e) => e.type == RecordType.poop).length;
        return _TotalValue(value: '$count', unit: '回');
      case FeedingTableCategory.temperature:
        return const _TotalValue(value: '', unit: '');
      case FeedingTableCategory.other:
        return const _TotalValue(value: '', unit: '');
    }
  }

  /// カテゴリに対応するセルを生成
  Widget _buildCellForCategory(FeedingTableCategory category, int hour) {
    switch (category) {
      case FeedingTableCategory.nursing:
        return RecordTableCell(
          records: widget.records,
          hour: hour,
          types: const [RecordType.breastLeft, RecordType.breastRight],
          onTap: widget.onSlotTap,
          rowHeight: RecordTable.bodyRowHeight,
        );
      case FeedingTableCategory.formula:
        return RecordTableCell(
          records: widget.records,
          hour: hour,
          types: const [RecordType.formula],
          onTap: widget.onSlotTap,
          rowHeight: RecordTable.bodyRowHeight,
        );
      case FeedingTableCategory.pump:
        return RecordTableCell(
          records: widget.records,
          hour: hour,
          types: const [RecordType.pump],
          onTap: widget.onSlotTap,
          rowHeight: RecordTable.bodyRowHeight,
        );
      case FeedingTableCategory.babyFood:
        return _BabyFoodTableCell(
          babyFoodRecords: widget.babyFoodRecords,
          hour: hour,
          onTap: widget.onBabyFoodSlotTap,
          rowHeight: RecordTable.bodyRowHeight,
        );
      case FeedingTableCategory.pee:
        return RecordTableCell(
          records: widget.records,
          hour: hour,
          types: const [RecordType.pee],
          onTap: widget.onSlotTap,
          rowHeight: RecordTable.bodyRowHeight,
        );
      case FeedingTableCategory.poop:
        return RecordTableCell(
          records: widget.records,
          hour: hour,
          types: const [RecordType.poop],
          onTap: widget.onSlotTap,
          rowHeight: RecordTable.bodyRowHeight,
        );
      case FeedingTableCategory.temperature:
        return RecordTableCell(
          records: widget.records,
          hour: hour,
          types: const [RecordType.temperature],
          onTap: widget.onSlotTap,
          rowHeight: RecordTable.bodyRowHeight,
        );
      case FeedingTableCategory.other:
        return RecordTableCell(
          records: widget.records,
          hour: hour,
          types: const [RecordType.other],
          onTap: widget.onSlotTap,
          rowHeight: RecordTable.bodyRowHeight,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Colors.grey.shade400);

    final totalsRow = _TotalsRow(
      borderSide: borderSide,
      columnWidths: widget.columnWidths,
      values: widget.settings.visibleCategories
          .map((c) => _getTotalValue(c))
          .toList(),
    );

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Table(
            columnWidths: widget.columnWidths,
            border: DashedTableBorder(
              top: borderSide,
              left: borderSide,
              right: borderSide,
              bottom: borderSide,
              verticalInside: borderSide,
              dashPattern: RecordTable._borderDashPattern,
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey.shade100),
                children: [
                  for (final header in _headers)
                    SizedBox(
                      height: RecordTable.headerRowHeight,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            alignment: Alignment.center,
                            child: Text(
                              header,
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Positioned.fill(
                child: Padding(
                  padding:
                      const EdgeInsets.only(bottom: RecordTable.bodyRowHeight),
                  child: SingleChildScrollView(
                    controller: _scrollController,
                    key: widget.scrollStorageKey,
                    child: SizedBox(
                      width: double.infinity,
                      child: Table(
                        columnWidths: widget.columnWidths,
                        border: DashedTableBorder(
                          top: BorderSide.none,
                          left: borderSide,
                          right: borderSide,
                          bottom: BorderSide.none,
                          horizontalInside: borderSide,
                          verticalInside: borderSide,
                          dashPattern: RecordTable._borderDashPattern,
                        ),
                        defaultVerticalAlignment:
                            TableCellVerticalAlignment.middle,
                        children: [
                          for (var hour = 0; hour < 24; hour++)
                            TableRow(
                              decoration: BoxDecoration(
                                color: hour.isEven
                                    ? Colors.white
                                    : Colors.pink.shade50,
                              ),
                              children: [
                                // 時間列
                                SizedBox(
                                  height: RecordTable.bodyRowHeight,
                                  child: Center(child: Text('$hour')),
                                ),
                                // 設定に基づいて動的に列を生成
                                for (final category
                                    in widget.settings.visibleCategories)
                                  _buildCellForCategory(category, hour),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: totalsRow,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TotalsRow extends StatelessWidget {
  const _TotalsRow({
    required this.borderSide,
    required this.values,
    required this.columnWidths,
  });

  final BorderSide borderSide;
  final List<_TotalValue> values;
  final Map<int, TableColumnWidth> columnWidths;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Table(
        columnWidths: columnWidths,
        border: DashedTableBorder(
          top: borderSide,
          left: borderSide,
          right: borderSide,
          bottom: borderSide,
          verticalInside: borderSide,
          dashPattern: RecordTable._borderDashPattern,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            children: [
              const SizedBox(
                height: RecordTable.bodyRowHeight,
                child: Center(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                    child: Text(
                      '合計',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              for (final value in values) _TotalValueCell(value: value),
            ],
          ),
        ],
      ),
    );
  }
}

class _TotalValue {
  const _TotalValue({required this.value, required this.unit});

  final String value;
  final String unit;
}

class _TotalValueCell extends StatelessWidget {
  const _TotalValueCell({required this.value});

  final _TotalValue value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: RecordTable.bodyRowHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Stack(
          children: [
            if (value.value.isNotEmpty)
              Center(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  child: Text(
                    value.value,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            if (value.unit.isNotEmpty)
              Positioned(
                bottom: 2,
                right: 0,
                child: Text(
                  value.unit,
                  style: const TextStyle(
                    fontSize: 10,
                    color: Colors.black54,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

double _sumAmount(List<RecordItemModel> records, RecordType type) {
  return records
      .where((e) => e.type == type)
      .fold<double>(0, (sum, e) => sum + (e.amount ?? 0));
}

/// 離乳食用のテーブルセル
class _BabyFoodTableCell extends StatelessWidget {
  const _BabyFoodTableCell({
    required this.babyFoodRecords,
    required this.hour,
    required this.onTap,
    required this.rowHeight,
  });

  final List<BabyFoodRecord> babyFoodRecords;
  final int hour;
  final BabyFoodSlotTapCallback? onTap;
  final double rowHeight;

  @override
  Widget build(BuildContext context) {
    // 指定時間帯の離乳食記録を取得
    final recordsInHour = babyFoodRecords.where((record) {
      return record.recordedAt.hour == hour;
    }).toList();

    final hasRecords = recordsInHour.isNotEmpty;

    return GestureDetector(
      onTap: onTap != null ? () => onTap!(hour) : null,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: rowHeight,
        child: Center(
          child: hasRecords
              ? Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: Colors.yellow.shade700,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${recordsInHour.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
