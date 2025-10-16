import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../child_record.dart';
import 'record_title.dart';
import '../../controllers/record_controller.dart';
import '../../controllers/selected_record_date_provider.dart';
import 'add_record_sheet.dart';

void showRecordSlotSheet({
  required BuildContext context,
  required WidgetRef ref,
  required int hour,
  required RecordType onlyType,
  required List<Record> inHour,
}) {
  final base = ref.read(selectedRecordDateProvider);
  final slot = DateTime(base.year, base.month, base.day, hour);

  Future<void> detailedAdd(RecordType t) async {
    final created = await showDialog<Record>(
      context: context,
      barrierDismissible: true,
      builder: (_) => Dialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: AddRecordSheet(
            type: t,
            initialDateTime: slot,
          ),
        ),
      ),
    );
    if (created != null) {
      try {
        await ref.read(recordControllerProvider.notifier).addRecord(created);
        if (!context.mounted) return;
        Navigator.of(context).maybePop();
      } on StateError catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message)),
        );
      } catch (e) {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('記録に失敗しました: $e')),
        );
      }
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (ctx) {
      final records = inHour.where((e) => e.type == onlyType).toList()
        ..sort((a, b) => a.at.compareTo(b.at));
      final actions = <RecordType>[onlyType];
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
                    Icon(_iconFor(onlyType)),
                    const SizedBox(width: 8),
                    Text(
                      onlyType.label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
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
                Text('合計: ${records.length}件'),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    controller: controller,
                    itemCount: records.length,
                    itemBuilder: (_, i) => RecordTitle(record: records[i]),
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

IconData _iconFor(RecordType t) => switch (t) {
      RecordType.formula => Icons.local_drink,
      RecordType.pump => Icons.local_drink_outlined,
      RecordType.breastRight || RecordType.breastLeft => Icons.child_care,
      RecordType.pee => Icons.water_drop,
      RecordType.poop => Icons.delete_outline,
      RecordType.other => Icons.more_horiz,
    };
