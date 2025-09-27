import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../baby_log.dart';
import '../components/entry_tile.dart';
import '../controllers/log_controller.dart';
import '../controllers/selected_log_date_provider.dart';
import 'add_entry_sheet.dart';

void showLogSlotSheet({
  required BuildContext context,
  required WidgetRef ref,
  required int hour,
  EntryType? onlyType,
  required List<Entry> inHour,
}) {
  final base = ref.read(selectedLogDateProvider);
  final slot = DateTime(base.year, base.month, base.day, hour);

  Future<void> detailedAdd(EntryType t) async {
    final created = await showDialog<Entry>(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: AddEntrySheet(
            type: t,
            initialDateTime: slot,
          ),
        ),
      ),
    );
    if (created != null) {
      await ref.read(logControllerProvider.notifier).add(created);
      if (context.mounted) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('記録しました')));
        Navigator.of(context).maybePop();
      }
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      final entries = onlyType == null
          ? inHour
          : inHour.where((e) => e.type == onlyType).toList();
      final actions = onlyType == null
          ? <EntryType>[
              EntryType.breastRight,
              EntryType.breastLeft,
              EntryType.formula,
              EntryType.pump,
              EntryType.pee,
              EntryType.poop,
              EntryType.other,
            ]
          : <EntryType>[onlyType];
      return DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.6,
        minChildSize: 0.4,
        maxChildSize: 0.9,
        builder: (_, controller) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${hour.toString().padLeft(2, '0')}:00 の記録',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.of(context).maybePop(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('合計: ${entries.length}件'),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: entries.length,
                    itemBuilder: (_, i) => EntryTile(entry: entries[i]),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final t in actions)
                      OutlinedButton.icon(
                        onPressed: () => detailedAdd(t),
                        icon: Icon(_iconFor(t)),
                        label: const Text('記録を追加'),
                      ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      );
    },
  );
}

IconData _iconFor(EntryType t) => switch (t) {
      EntryType.formula => Icons.local_drink,
      EntryType.pump => Icons.local_drink_outlined,
      EntryType.breastRight || EntryType.breastLeft => Icons.child_care,
      EntryType.pee => Icons.water_drop,
      EntryType.poop => Icons.delete_outline,
      EntryType.other => Icons.more_horiz,
    };
