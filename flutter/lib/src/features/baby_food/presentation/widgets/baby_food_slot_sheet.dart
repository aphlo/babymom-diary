import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/baby_food_record.dart';
import '../../domain/entities/custom_ingredient.dart';
import '../../domain/value_objects/baby_food_reaction.dart';
import '../models/baby_food_draft.dart';
import '../providers/baby_food_providers.dart';
import '../viewmodels/baby_food_sheet_view_model.dart';
import 'baby_food_sheet.dart';

/// 離乳食スロット（時間帯）の記録一覧を表示するbottom sheet
void showBabyFoodSlotSheet({
  required BuildContext context,
  required WidgetRef ref,
  required String householdId,
  required String childId,
  required DateTime selectedDate,
  required int hour,
  required List<BabyFoodRecord> recordsInHour,
  required List<CustomIngredient> customIngredients,
}) {
  Future<void> openBabyFoodEditor(BabyFoodDraft initialDraft) async {
    await Navigator.of(context).maybePop();
    if (!context.mounted) return;

    final args = BabyFoodSheetArgs(
      householdId: householdId,
      childId: childId,
      initialDraft: initialDraft,
      customIngredients: customIngredients,
    );

    await showBabyFoodSheet(
      context: context,
      args: args,
      selectedDate: selectedDate,
    );
  }

  Future<void> addNewRecord() async {
    // 現在時刻を使用（分単位まで）
    final now = DateTime.now();
    final recordedAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      now.hour,
      now.minute,
    );
    final draft = BabyFoodDraft.newRecord(recordedAt: recordedAt);
    await openBabyFoodEditor(draft);
  }

  Future<void> editRecord(BabyFoodRecord record) async {
    final draft = BabyFoodDraft.fromRecord(record);
    await openBabyFoodEditor(draft);
  }

  Future<void> confirmDelete(BabyFoodRecord record) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) => AlertDialog(
        title: const Text('記録を削除'),
        content: const Text('この離乳食の記録を削除してもよろしいですか？'),
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
    if (shouldDelete != true) return;

    final deleteUseCase =
        ref.read(deleteBabyFoodRecordUseCaseProvider(householdId));
    await deleteUseCase.call(childId: childId, recordId: record.id);
    if (context.mounted) {
      Navigator.of(context).maybePop();
    }
  }

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white,
    builder: (ctx) {
      final records = recordsInHour.toList()
        ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
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
                    Image.asset(
                      'assets/icons/child_record/babyfood_black.png',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '離乳食',
                      style: TextStyle(
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
                  child: hasRecord
                      ? ListView.builder(
                          controller: controller,
                          itemCount: records.length,
                          itemBuilder: (_, i) {
                            final record = records[i];
                            return _BabyFoodRecordTile(
                              record: record,
                              onEdit: () => editRecord(record),
                              onDelete: () => confirmDelete(record),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            '${hour.toString().padLeft(2, '0')}:00 の記録はありません',
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
                    onPressed: addNewRecord,
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

/// 離乳食記録の1件を表示するタイル
class _BabyFoodRecordTile extends StatelessWidget {
  const _BabyFoodRecordTile({
    required this.record,
    required this.onEdit,
    required this.onDelete,
  });

  final BabyFoodRecord record;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final time = TimeOfDay.fromDateTime(record.recordedAt);
    final timeStr = time.format(context);
    final itemsSummary = record.items.map((item) {
      final name = item.ingredientName;
      final amount = item.amountDisplay;
      return amount != null ? '$name ($amount)' : name;
    }).join(', ');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              timeStr,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
        title: Text(
          itemsSummary,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 14),
        ),
        subtitle: record.items.isNotEmpty
            ? _ReactionSummary(items: record.items)
            : null,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') {
              onEdit();
            } else if (value == 'delete') {
              onDelete();
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(
              value: 'edit',
              child: Row(
                children: [
                  Icon(Icons.edit, size: 20),
                  SizedBox(width: 8),
                  Text('編集'),
                ],
              ),
            ),
            const PopupMenuItem(
              value: 'delete',
              child: Row(
                children: [
                  Icon(Icons.delete, size: 20, color: Colors.red),
                  SizedBox(width: 8),
                  Text('削除', style: TextStyle(color: Colors.red)),
                ],
              ),
            ),
          ],
        ),
        onTap: onEdit,
      ),
    );
  }
}

/// 反応のサマリーを表示
class _ReactionSummary extends StatelessWidget {
  const _ReactionSummary({required this.items});

  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    final reactions = items
        .map((item) => item.reaction as BabyFoodReaction?)
        .where((r) => r != null)
        .toList();

    if (reactions.isEmpty) return const SizedBox.shrink();

    final goodCount = reactions.where((r) => r == BabyFoodReaction.good).length;
    final normalCount =
        reactions.where((r) => r == BabyFoodReaction.normal).length;
    final badCount = reactions.where((r) => r == BabyFoodReaction.bad).length;

    return Row(
      children: [
        if (goodCount > 0) ...[
          Icon(Icons.sentiment_very_satisfied,
              size: 16, color: Colors.green.shade600),
          const SizedBox(width: 2),
          Text('$goodCount', style: TextStyle(color: Colors.green.shade600)),
          const SizedBox(width: 8),
        ],
        if (normalCount > 0) ...[
          Icon(Icons.sentiment_neutral,
              size: 16, color: Colors.orange.shade600),
          const SizedBox(width: 2),
          Text('$normalCount', style: TextStyle(color: Colors.orange.shade600)),
          const SizedBox(width: 8),
        ],
        if (badCount > 0) ...[
          Icon(Icons.sentiment_very_dissatisfied,
              size: 16, color: Colors.red.shade600),
          const SizedBox(width: 2),
          Text('$badCount', style: TextStyle(color: Colors.red.shade600)),
        ],
      ],
    );
  }
}
