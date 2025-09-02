import 'package:flutter/material.dart';
import '../../baby_log.dart';

class EntryTile extends StatelessWidget {
  const EntryTile({super.key, required this.entry});
  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final subtitle = switch (entry.type) {
      EntryType.feeding => entry.amount != null ? '授乳 ${entry.amount!.toStringAsFixed(0)} ml' : '授乳',
      EntryType.sleep => entry.amount != null ? '睡眠 ${entry.amount} h' : '睡眠',
    };

    return ListTile(
      leading: Icon(switch (entry.type) {
        EntryType.feeding => Icons.local_drink,
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