import 'package:flutter/material.dart';
import '../../baby_log.dart';

class EntryTile extends StatelessWidget {
  const EntryTile({super.key, required this.entry});
  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final subtitle = switch (entry.type) {
      EntryType.formula => entry.amount != null
          ? 'ミルク ${entry.amount!.toStringAsFixed(0)} ml'
          : 'ミルク',
      EntryType.pump => entry.amount != null
          ? '搾乳 ${entry.amount!.toStringAsFixed(0)} ml'
          : '搾乳',
      EntryType.breastRight => entry.amount != null
          ? '母乳(右) ${entry.amount!.toStringAsFixed(0)} 分'
          : '母乳(右)',
      EntryType.breastLeft => entry.amount != null
          ? '母乳(左) ${entry.amount!.toStringAsFixed(0)} 分'
          : '母乳(左)',
      EntryType.pee => '尿',
      EntryType.poop => '便',
      EntryType.other => 'その他',
      EntryType.sleep => entry.amount != null ? '睡眠 ${entry.amount} h' : '睡眠',
    };

    return ListTile(
      leading: Icon(switch (entry.type) {
        EntryType.formula => Icons.local_drink,
        EntryType.pump => Icons.local_drink_outlined,
        EntryType.breastRight => Icons.child_care,
        EntryType.breastLeft => Icons.child_care,
        EntryType.pee => Icons.water_drop,
        EntryType.poop => Icons.delete_outline,
        EntryType.other => Icons.more_horiz,
        EntryType.sleep => Icons.bedtime,
      }),
      title: Text(subtitle),
      subtitle: Text(entry.at.toLocal().toString()),
      trailing: entry.note == null || entry.note!.isEmpty
          ? null
          : const Icon(Icons.sticky_note_2_outlined),
    );
  }
}
