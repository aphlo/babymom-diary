import 'package:flutter/material.dart';

import '../../child_record.dart';
import 'dashed_table_border.dart';
import 'record_table_cell.dart';

class RecordTable extends StatelessWidget {
  const RecordTable({
    super.key,
    required this.records,
    required this.onSlotTap,
    required this.scrollStorageKey,
  });

  final List<Record> records;
  final RecordSlotTapCallback onSlotTap;
  final PageStorageKey<String> scrollStorageKey;

  static const double headerRowHeight = 44.0;
  static const double bodyRowHeight = 32.0;

  static const _headers = <String>[
    '時間',
    '授乳\n(左)',
    '授乳\n(右)',
    'ミルク',
    '搾母乳',
    '尿',
    '便',
    'その他'
  ];

  static const _columnWidths = <int, TableColumnWidth>{
    0: FlexColumnWidth(0.8),
    1: FlexColumnWidth(1.0),
    2: FlexColumnWidth(1.0),
    3: FlexColumnWidth(1.0),
    4: FlexColumnWidth(1.0),
    5: FlexColumnWidth(1.0),
    6: FlexColumnWidth(1.0),
    7: FlexColumnWidth(2.0),
  };

  static const _borderDashPattern = <double>[1.5, 2.5];

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Colors.grey.shade400);
    final breastRightRecords =
        records.where((e) => e.type == RecordType.breastRight).toList();
    final breastLeftRecords =
        records.where((e) => e.type == RecordType.breastLeft).toList();
    final totalBreastRightCount = breastRightRecords.length;
    final totalBreastLeftCount = breastLeftRecords.length;
    final totalFormulaMl = _sumAmount(records, RecordType.formula);
    final totalPumpMl = _sumAmount(records, RecordType.pump);
    final totalPeeCount = records.where((e) => e.type == RecordType.pee).length;
    final totalPoopCount =
        records.where((e) => e.type == RecordType.poop).length;

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
      ],
    );

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Table(
            columnWidths: _columnWidths,
            border: DashedTableBorder(
              top: borderSide,
              left: borderSide,
              right: borderSide,
              bottom: borderSide,
              verticalInside: borderSide,
              dashPattern: _borderDashPattern,
            ),
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey.shade100),
                children: [
                  for (final header in _headers)
                    SizedBox(
                      height: headerRowHeight,
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
                  padding: const EdgeInsets.only(bottom: bodyRowHeight),
                  child: SingleChildScrollView(
                    key: scrollStorageKey,
                    child: SizedBox(
                      width: double.infinity,
                      child: Table(
                        columnWidths: _columnWidths,
                        border: DashedTableBorder(
                          top: BorderSide.none,
                          left: borderSide,
                          right: borderSide,
                          bottom: BorderSide.none,
                          horizontalInside: borderSide,
                          verticalInside: borderSide,
                          dashPattern: _borderDashPattern,
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
                                  height: bodyRowHeight,
                                  child: Center(child: Text('$hour')),
                                ),
                                for (final type in _slotTypes)
                                  RecordTableCell(
                                    records: records,
                                    hour: hour,
                                    type: type,
                                    onTap: onSlotTap,
                                    rowHeight: bodyRowHeight,
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

double _sumAmount(List<Record> records, RecordType type) {
  return records
      .where((e) => e.type == type)
      .fold<double>(0, (sum, e) => sum + (e.amount ?? 0));
}
