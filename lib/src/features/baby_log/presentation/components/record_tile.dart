import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../baby_log.dart';

class RecordTile extends StatelessWidget {
  const RecordTile({super.key, required this.record});
  final Record record;

  @override
  Widget build(BuildContext context) {
    final title = _buildTitle(record);
    final hasNote = record.note != null && record.note!.trim().isNotEmpty;
    final timeText = DateFormat('HH:mm').format(record.at.toLocal());
    final subtitleWidgets = <Widget>[
      Text(timeText),
    ];

    if (record.type == RecordType.other && record.tags.isNotEmpty) {
      subtitleWidgets.add(Text(record.tags.join(' / ')));
    }

    if (hasNote) {
      subtitleWidgets.add(
        Text(
          record.note!.trim(),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      );
    }

    return ListTile(
      leading: Icon(switch (record.type) {
        RecordType.formula => Icons.local_drink,
        RecordType.pump => Icons.local_drink_outlined,
        RecordType.breastRight => Icons.child_care,
        RecordType.breastLeft => Icons.child_care,
        RecordType.pee => Icons.water_drop,
        RecordType.poop => Icons.delete_outline,
        RecordType.other => Icons.more_horiz,
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

String _buildTitle(Record record) {
  switch (record.type) {
    case RecordType.formula:
      final amount = record.amount;
      return amount != null ? 'ミルク ${amount.toStringAsFixed(0)} ml' : 'ミルク';
    case RecordType.pump:
      final amount = record.amount;
      return amount != null ? '搾母乳 ${amount.toStringAsFixed(0)} ml' : '搾母乳';
    case RecordType.breastRight:
      final duration = _formatBreastDuration(record);
      return duration.isEmpty ? '母乳(右)' : '母乳(右) $duration';
    case RecordType.breastLeft:
      final duration = _formatBreastDuration(record);
      return duration.isEmpty ? '母乳(左)' : '母乳(左) $duration';
    case RecordType.pee:
      final label = record.excretionVolume?.label;
      return label == null ? '尿' : '尿 ($label)';
    case RecordType.poop:
      final label = record.excretionVolume?.label;
      return label == null ? '便' : '便 ($label)';
    case RecordType.other:
      return 'その他';
  }
}

String _formatBreastDuration(Record record) {
  final totalSeconds =
      record.durationSeconds ?? ((record.amount ?? 0) * 60).round();
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
