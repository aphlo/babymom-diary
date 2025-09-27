import 'package:flutter/material.dart';

import '../../baby_log.dart';
import 'dashed_table_border.dart';
import 'log_table_cell.dart';

class LogTable extends StatelessWidget {
  const LogTable({
    super.key,
    required this.entries,
    required this.onSlotTap,
  });

  final List<Entry> entries;
  final LogSlotTapCallback onSlotTap;

  static const double headerRowHeight = 44.0;
  static const double bodyRowHeight = 32.0;

  static const _headers = <String>[
    '時間',
    '授乳\n(右)',
    '授乳\n(左)',
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
    final breastRightEntries =
        entries.where((e) => e.type == EntryType.breastRight).toList();
    final breastLeftEntries =
        entries.where((e) => e.type == EntryType.breastLeft).toList();
    final totalBreastRightSeconds = sumDurationSeconds(breastRightEntries);
    final totalBreastLeftSeconds = sumDurationSeconds(breastLeftEntries);
    final totalFormulaMl = _sumAmount(entries, EntryType.formula);
    final totalPumpMl = _sumAmount(entries, EntryType.pump);
    final totalPeeCount = entries.where((e) => e.type == EntryType.pee).length;
    final totalPoopCount =
        entries.where((e) => e.type == EntryType.poop).length;

    final totalsRow = _TotalsRow(
      borderSide: borderSide,
      values: [
        formatMinutesOrCount(
            totalBreastRightSeconds, breastRightEntries.length),
        formatMinutesOrCount(totalBreastLeftSeconds, breastLeftEntries.length),
        totalFormulaMl.toStringAsFixed(0),
        totalPumpMl.toStringAsFixed(0),
        '$totalPeeCount',
        '$totalPoopCount',
        '',
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
                          child: Text(
                            header,
                            softWrap: false,
                            overflow: TextOverflow.fade,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
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
                                  LogTableCell(
                                    entries: entries,
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

const _slotTypes = <EntryType>[
  EntryType.breastRight,
  EntryType.breastLeft,
  EntryType.formula,
  EntryType.pump,
  EntryType.pee,
  EntryType.poop,
  EntryType.other,
];

class _TotalsRow extends StatelessWidget {
  const _TotalsRow({
    required this.borderSide,
    required this.values,
  });

  final BorderSide borderSide;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Table(
        columnWidths: LogTable._columnWidths,
        border: DashedTableBorder(
          top: borderSide,
          left: borderSide,
          right: borderSide,
          bottom: borderSide,
          verticalInside: borderSide,
          dashPattern: LogTable._borderDashPattern,
        ),
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          TableRow(
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
            ),
            children: [
              const SizedBox(
                height: LogTable.bodyRowHeight,
                child: Center(
                  child: Text(
                    '合計',
                    style: TextStyle(fontWeight: FontWeight.bold),
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

class _TotalValueCell extends StatelessWidget {
  const _TotalValueCell({required this.value});

  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: LogTable.bodyRowHeight,
      child: Center(
        child: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

double _sumAmount(List<Entry> entries, EntryType type) {
  return entries
      .where((e) => e.type == type)
      .fold<double>(0, (sum, e) => sum + (e.amount ?? 0));
}
