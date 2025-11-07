import 'package:flutter/material.dart';

import '../../child_record.dart';
import '../models/record_item_model.dart';
import 'dashed_table_border.dart';
import 'record_table_cell.dart';

class RecordTable extends StatefulWidget {
  const RecordTable({
    super.key,
    required this.records,
    required this.onSlotTap,
    required this.scrollStorageKey,
    required this.selectedDate,
  });

  final List<RecordItemModel> records;
  final RecordSlotTapCallback onSlotTap;
  final PageStorageKey<String> scrollStorageKey;
  final DateTime selectedDate;

  static const double headerRowHeight = 44.0;
  static const double bodyRowHeight = 32.0;

  static const _columnWidths = <int, TableColumnWidth>{
    0: FlexColumnWidth(0.7),
    1: FlexColumnWidth(1.0),
    2: FlexColumnWidth(1.0),
    3: FlexColumnWidth(1.0),
    4: FlexColumnWidth(1.0),
    5: FlexColumnWidth(1.0),
    6: FlexColumnWidth(1.0),
    7: FlexColumnWidth(1.0),
    8: FlexColumnWidth(2.0),
  };

  static const _borderDashPattern = <double>[1.5, 2.5];

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

  static const _headers = <String>[
    '時間',
    '授乳\n(左)',
    '授乳\n(右)',
    'ミルク',
    '搾母乳',
    '尿',
    '便',
    '体温',
    'その他'
  ];

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Colors.grey.shade400);
    final breastRightRecords =
        widget.records.where((e) => e.type == RecordType.breastRight).toList();
    final breastLeftRecords =
        widget.records.where((e) => e.type == RecordType.breastLeft).toList();
    final totalBreastRightCount = breastRightRecords.length;
    final totalBreastLeftCount = breastLeftRecords.length;
    final totalFormulaMl = _sumAmount(widget.records, RecordType.formula);
    final totalPumpMl = _sumAmount(widget.records, RecordType.pump);
    final totalPeeCount =
        widget.records.where((e) => e.type == RecordType.pee).length;
    final totalPoopCount =
        widget.records.where((e) => e.type == RecordType.poop).length;

    final totalsRow = _TotalsRow(
      borderSide: borderSide,
      values: [
        _TotalValue(
          value: '$totalBreastLeftCount',
          unit: '回',
        ),
        _TotalValue(
          value: '$totalBreastRightCount',
          unit: '回',
        ),
        _TotalValue(
          value: totalFormulaMl.toStringAsFixed(0),
          unit: 'ml',
        ),
        _TotalValue(
          value: totalPumpMl.toStringAsFixed(0),
          unit: 'ml',
        ),
        _TotalValue(
          value: '$totalPeeCount',
          unit: '回',
        ),
        _TotalValue(
          value: '$totalPoopCount',
          unit: '回',
        ),
        const _TotalValue(value: '', unit: ''),
        const _TotalValue(value: '', unit: ''),
      ],
    );

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Table(
            columnWidths: RecordTable._columnWidths,
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
                        columnWidths: RecordTable._columnWidths,
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
                                SizedBox(
                                  height: RecordTable.bodyRowHeight,
                                  child: Center(child: Text('$hour')),
                                ),
                                for (final type in _slotTypes)
                                  RecordTableCell(
                                    records: widget.records,
                                    hour: hour,
                                    type: type,
                                    onTap: widget.onSlotTap,
                                    rowHeight: RecordTable.bodyRowHeight,
                                  ),
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

const _slotTypes = <RecordType>[
  RecordType.breastLeft,
  RecordType.breastRight,
  RecordType.formula,
  RecordType.pump,
  RecordType.pee,
  RecordType.poop,
  RecordType.temperature,
  RecordType.other,
];

class _TotalsRow extends StatelessWidget {
  const _TotalsRow({
    required this.borderSide,
    required this.values,
  });

  final BorderSide borderSide;
  final List<_TotalValue> values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Table(
        columnWidths: RecordTable._columnWidths,
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
