import 'package:flutter/material.dart';
import '../../baby_log.dart';

class EntryTile extends StatelessWidget {
  const EntryTile({super.key, required this.entry});
  final Entry entry;

  @override
  Widget build(BuildContext context) {
    final subtitle = switch (entry.type) {
      EntryType.feeding => entry.amount != null ? 'Feeding ${entry.amount!.toStringAsFixed(0)} ml' : 'Feeding',
      EntryType.sleep => entry.amount != null ? 'Sleep ${entry.amount} h' : 'Sleep',
      EntryType.diaper => 'Diaper',
    };

    return ListTile(
      leading: Icon(switch (entry.type) {
        EntryType.feeding => Icons.local_drink,
        EntryType.diaper => Icons.baby_changing_station,
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