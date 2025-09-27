import 'package:flutter/material.dart';

import '../../baby_log.dart';
import 'other_tags_preview.dart';

typedef LogSlotTapCallback = void Function(
  BuildContext context,
  int hour,
  EntryType? type,
  List<Entry> inHour,
);

class LogTableCell extends StatelessWidget {
  const LogTableCell({
    super.key,
    required this.entries,
    required this.hour,
    required this.type,
    required this.onTap,
    required this.rowHeight,
  });

  final List<Entry> entries;
  final int hour;
  final EntryType? type;
  final LogSlotTapCallback onTap;
  final double rowHeight;

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
          height: rowHeight,
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
          final seconds = sumDurationSeconds(filtered);
          text = formatMinutesOrCount(seconds, filtered.length);
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
        height: rowHeight,
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

String formatMinutesOrCount(int seconds, int fallbackCount) {
  if (seconds == 0) {
    return '$fallbackCount';
  }
  return _formatMinutesWithoutUnit(seconds);
}

int sumDurationSeconds(Iterable<Entry> entries) {
  var total = 0;
  for (final entry in entries) {
    final seconds = entry.durationSeconds ?? ((entry.amount ?? 0) * 60).round();
    total += seconds;
  }
  return total;
}

String _formatMinutesWithoutUnit(int seconds) {
  if (seconds <= 0) {
    return '0';
  }
  if (seconds % 60 == 0) {
    return '${seconds ~/ 60}';
  }
  return (seconds / 60).toStringAsFixed(1);
}
