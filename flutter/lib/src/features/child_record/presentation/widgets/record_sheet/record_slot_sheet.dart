import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../child_record.dart';
import '../../models/record_item_model.dart';
import 'record_title.dart';
import '../../viewmodels/record_view_model.dart';
import '../../viewmodels/record_state.dart';

void showRecordSlotSheet({
  required BuildContext context,
  required WidgetRef ref,
  required RecordSlotRequest request,
}) {
  final notifier = ref.read(recordViewModelProvider.notifier);
  final slot = DateTime(
    request.date.year,
    request.date.month,
    request.date.day,
    request.hour,
  );

  Future<void> detailedAdd(RecordType t) async {
    await Navigator.of(context).maybePop();
    if (!context.mounted) {
      return;
    }
    notifier.openCreateRecord(
      type: t,
      initialDateTime: slot,
    );
  }

  Future<void> detailedEdit(RecordItemModel record) async {
    await Navigator.of(context).maybePop();
    if (!context.mounted) {
      return;
    }
    notifier.openEditRecord(record);
  }

  Future<void> confirmDelete(RecordItemModel record) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => AlertDialog(
        title: const Text('記録を削除'),
        content: const Text('この記録を削除してもよろしいですか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (shouldDelete != true) {
      return;
    }
    await notifier.deleteRecord(record.id);
    if (context.mounted) {
      Navigator.of(context).maybePop();
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (ctx) {
      final records = request.records.toList()
        ..sort((a, b) => a.at.compareTo(b.at));
      final hasRecord = records.isNotEmpty;
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
                      _emojiFor(request.type),
                      style: const TextStyle(fontSize: 24),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      (request.type == RecordType.breastLeft ||
                              request.type == RecordType.breastRight)
                          ? '授乳'
                          : request.type.label,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${request.hour.toString().padLeft(2, '0')}:00 の記録',
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
                  child: hasRecord
                      ? ListView.builder(
                          controller: controller,
                          itemCount: records.length,
                          itemBuilder: (_, i) {
                            final record = records[i];
                            return RecordTitle(
                              record: record,
                              onEdit: () => detailedEdit(record),
                              onDelete: () => confirmDelete(record),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            '${request.hour.toString().padLeft(2, '0')}:00 の記録はありません',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black54),
                          ),
                        ),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => detailedAdd(request.type),
                    icon: const Icon(Icons.add),
                    label: const Text('記録を追加'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

String _emojiFor(RecordType t) => switch (t) {
      RecordType.formula => '🍼',
      RecordType.pump => '🥛',
      RecordType.breastRight || RecordType.breastLeft => '🤱',
      RecordType.pee => '💧',
      RecordType.poop => '💩',
      RecordType.temperature => '🌡️',
      RecordType.other => '📝',
    };
