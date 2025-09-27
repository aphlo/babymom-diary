import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../baby_log.dart';

class EntryTile extends StatelessWidget {
  const EntryTile({super.key, required this.entry});
  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final title = _buildTitle(entry);
    final hasNote = entry.note != null && entry.note!.trim().isNotEmpty;
    final timeText = DateFormat('HH:mm').format(entry.at.toLocal());
    final subtitleWidgets = <Widget>[
      Text(timeText),
    ];

    if (entry.type == EntryType.other && entry.tags.isNotEmpty) {
      subtitleWidgets.add(Text(entry.tags.join(' / ')));
    }

    if (hasNote) {
      subtitleWidgets.add(
        Text(
          entry.note!.trim(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return ListTile(
      leading: Icon(switch (entry.type) {
        EntryType.formula => Icons.local_drink,
        EntryType.pump => Icons.local_drink_outlined,
        EntryType.breastRight => Icons.child_care,
        EntryType.breastLeft => Icons.child_care,
        EntryType.pee => Icons.water_drop,
        EntryType.poop => Icons.delete_outline,
        EntryType.other => Icons.more_horiz,
      }),
      title: Text(title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: subtitleWidgets,
      ),
      isThreeLine: subtitleWidgets.length > 1,
      trailing: hasNote ? const Icon(Icons.sticky_note_2_outlined) : null,
    );
  }
}

String _buildTitle(Entry entry) {
  switch (entry.type) {
    case EntryType.formula:
      final amount = entry.amount;
      return amount != null ? 'ミルク ${amount.toStringAsFixed(0)} ml' : 'ミルク';
    case EntryType.pump:
      final amount = entry.amount;
      return amount != null ? '搾母乳 ${amount.toStringAsFixed(0)} ml' : '搾母乳';
    case EntryType.breastRight:
      final duration = _formatBreastDuration(entry);
      return duration.isEmpty ? '母乳(右)' : '母乳(右) $duration';
    case EntryType.breastLeft:
      final duration = _formatBreastDuration(entry);
      return duration.isEmpty ? '母乳(左)' : '母乳(左) $duration';
    case EntryType.pee:
      final label = entry.excretionVolume?.label;
      return label == null ? '尿' : '尿 ($label)';
    case EntryType.poop:
      final label = entry.excretionVolume?.label;
      return label == null ? '便' : '便 ($label)';
    case EntryType.other:
      return 'その他';
  }
}

String _formatBreastDuration(Entry entry) {
  final totalSeconds =
      entry.durationSeconds ?? ((entry.amount ?? 0) * 60).round();
  if (totalSeconds <= 0) {
    return '';
  }
  final minutes = totalSeconds ~/ 60;
  final seconds = totalSeconds % 60;
  final buffer = <String>[];
  if (minutes > 0) {
    buffer.add('$minutes分');
  }
  if (seconds > 0) {
    buffer.add('$seconds秒');
  }
  return buffer.join();
}
