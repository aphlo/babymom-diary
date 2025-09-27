import 'package:flutter/material.dart';

import '../../baby_log.dart';
import 'other_tags_preview.dart';

typedef LogSlotTapCallback = void Function(
  BuildContext context,
  int hour,
  EntryType? type,
  List<Entry> inHour,
);

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

  @override
  Widget build(BuildContext context) {
    final borderSide = BorderSide(color: Colors.grey.shade400);
    final breastRightEntries =
        entries.where((e) => e.type == EntryType.breastRight).toList();
    final breastLeftEntries =
        entries.where((e) => e.type == EntryType.breastLeft).toList();
    final totalBreastRightSeconds = _sumDurationSeconds(breastRightEntries);
    final totalBreastLeftSeconds = _sumDurationSeconds(breastLeftEntries);
    final totalFormulaMl = _sumAmount(entries, EntryType.formula);
    final totalPumpMl = _sumAmount(entries, EntryType.pump);
    final totalPeeCount = entries.where((e) => e.type == EntryType.pee).length;
    final totalPoopCount =
        entries.where((e) => e.type == EntryType.poop).length;

    final totalsRow = _TotalsRow(
      borderSide: borderSide,
      values: [
        _formatDurationOrCount(
            totalBreastRightSeconds, breastRightEntries.length),
        _formatDurationOrCount(
            totalBreastLeftSeconds, breastLeftEntries.length),
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
            border: TableBorder(
              top: borderSide,
              left: borderSide,
              right: borderSide,
              bottom: borderSide,
              verticalInside: borderSide,
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
                        border: TableBorder(
                          top: BorderSide.none,
                          left: borderSide,
                          right: borderSide,
                          bottom: BorderSide.none,
                          horizontalInside: borderSide,
                          verticalInside: borderSide,
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

class LogTableCell extends StatelessWidget {
  const LogTableCell({
    super.key,
    required this.entries,
    required this.hour,
    required this.type,
    required this.onTap,
  });

  final List<Entry> entries;
  final int hour;
  final EntryType? type;
  final LogSlotTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    final inHour = entries.where((e) => e.at.hour == hour).toList();
    final filtered =
        type == null ? inHour : inHour.where((e) => e.type == type).toList();

    if (type == EntryType.other) {
      final tags = filtered
          .expand((entry) => entry.tags)
          .map((tag) => tag.trim())
          .where((tag) => tag.isNotEmpty)
          .toList(growable: false);
      final fallbackText = filtered.isEmpty ? '' : '${filtered.length}';

      return InkWell(
        onTap: () => onTap(context, hour, type, inHour),
        child: SizedBox(
          height: LogTable.bodyRowHeight,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: tags.isEmpty
                ? (fallbackText.isEmpty
                    ? const SizedBox.shrink()
                    : Center(
                        child: Text(
                          fallbackText,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ))
                : OtherTagsPreview(tags: tags),
          ),
        ),
      );
    }

    var text = '';
    if (filtered.isNotEmpty) {
      switch (type) {
        case EntryType.formula:
        case EntryType.pump:
          final sum = filtered.fold<double>(0, (p, e) => p + (e.amount ?? 0));
          text = sum == 0 ? '${filtered.length}' : sum.toStringAsFixed(0);
          break;
        case EntryType.breastLeft || EntryType.breastRight:
          final seconds = _sumDurationSeconds(filtered);
          text = seconds == 0
              ? '${filtered.length}'
              : _formatDurationShort(seconds);
          break;
        case EntryType.pee || EntryType.poop:
        case EntryType.other:
        case null:
          text = '${filtered.length}';
          break;
      }
    }

    return InkWell(
      onTap: () => onTap(context, hour, type, inHour),
      child: SizedBox(
        height: LogTable.bodyRowHeight,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
    );
  }
}

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
        border: TableBorder(
          top: borderSide,
          left: borderSide,
          right: borderSide,
          bottom: borderSide,
          verticalInside: borderSide,
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

int _sumDurationSeconds(Iterable<Entry> entries) {
  var total = 0;
  for (final entry in entries) {
    final seconds = entry.durationSeconds ?? ((entry.amount ?? 0) * 60).round();
    total += seconds;
  }
  return total;
}

String _formatDurationOrCount(int seconds, int fallbackCount) {
  if (seconds == 0) {
    return '$fallbackCount';
  }
  return _formatDurationShort(seconds);
}

String _formatDurationShort(int seconds) {
  if (seconds <= 0) {
    return '0分';
  }
  final minutes = seconds ~/ 60;
  final remainingSeconds = seconds % 60;
  if (remainingSeconds == 0) {
    return '$minutes分';
  }
  if (minutes == 0) {
    return '$remainingSeconds秒';
  }
  return '$minutes分$remainingSeconds秒';
}
