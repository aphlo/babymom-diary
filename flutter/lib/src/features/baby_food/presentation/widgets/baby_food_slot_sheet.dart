import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../menu/children/application/selected_child_provider.dart';
import '../../domain/entities/baby_food_record.dart';
import '../../domain/entities/custom_ingredient.dart';
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
  required Set<String> hiddenIngredients,
}) {
  Future<void> openBabyFoodEditor(BabyFoodDraft initialDraft) async {
    await Navigator.of(context).maybePop();
    if (!context.mounted) return;

    final args = BabyFoodSheetArgs(
      householdId: householdId,
      childId: childId,
      initialDraft: initialDraft,
      customIngredients: customIngredients,
      hiddenIngredients: hiddenIngredients,
    );

    await showBabyFoodSheet(
      context: context,
      args: args,
      selectedDate: selectedDate,
    );
  }

  Future<void> addNewRecord() async {
    final now = DateTime.now();
    final isCurrentHour = selectedDate.year == now.year &&
        selectedDate.month == now.month &&
        selectedDate.day == now.day &&
        hour == now.hour;

    // 現在時刻の時間帯をタップした場合のみ現在時刻を使用
    // それ以外はタップした時間帯の0分を使用
    final recordedAt = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
      isCurrentHour ? now.hour : hour,
      isCurrentHour ? now.minute : 0,
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
    builder: (ctx) {
      final records = recordsInHour.toList()
        ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
      final hasRecord = records.isNotEmpty;
      return _BabyFoodSlotSheetContent(
        childId: childId,
        hour: hour,
        records: records,
        hasRecord: hasRecord,
        onAddNewRecord: addNewRecord,
        onEditRecord: editRecord,
        onDeleteRecord: confirmDelete,
        parentContext: context,
      );
    },
  );
}

/// 離乳食スロットシートのコンテンツ（子供切り替え時に閉じる機能付き）
class _BabyFoodSlotSheetContent extends ConsumerWidget {
  const _BabyFoodSlotSheetContent({
    required this.childId,
    required this.hour,
    required this.records,
    required this.hasRecord,
    required this.onAddNewRecord,
    required this.onEditRecord,
    required this.onDeleteRecord,
    required this.parentContext,
  });

  final String childId;
  final int hour;
  final List<BabyFoodRecord> records;
  final bool hasRecord;
  final VoidCallback onAddNewRecord;
  final void Function(BabyFoodRecord) onEditRecord;
  final void Function(BabyFoodRecord) onDeleteRecord;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 選択中の子供が変更されたらシートを閉じる
    ref.listen<AsyncValue<String?>>(selectedChildControllerProvider,
        (previous, next) {
      final nextChildId = next.value;
      // 初期ロード時はスキップ（previous == null）
      // 実際に子供が切り替わった時のみ閉じる
      if (previous != null && nextChildId != null && nextChildId != childId) {
        Navigator.of(context).pop();
      }
    });

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
                    onPressed: () => Navigator.of(parentContext).maybePop(),
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
                            onEdit: () => onEditRecord(record),
                            onDelete: () => onDeleteRecord(record),
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
                  onPressed: onAddNewRecord,
                  icon: const Icon(Icons.add),
                  label: const Text('記録を追加'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
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
    final theme = Theme.of(context);
    final time = TimeOfDay.fromDateTime(record.recordedAt);
    final timeStr = time.format(context);
    final timeTextStyle = theme.textTheme.bodySmall
            ?.copyWith(color: theme.colorScheme.onSurfaceVariant) ??
        const TextStyle(fontSize: 12, color: Colors.black54);
    final itemsSummary = record.items.map((item) {
      final name = item.ingredientName;
      final amount = item.amountDisplay;
      return amount != null ? '$name ($amount)' : name;
    }).join(', ');

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 時刻（上揃え）
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text(
              timeStr,
              style: timeTextStyle,
            ),
          ),
          const SizedBox(width: 12),
          // 食材一覧（改行して全て表示）
          Expanded(
            child: Text(
              itemsSummary,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const SizedBox(width: 8),
          // 編集・削除ボタン
          IconButton(
            onPressed: onEdit,
            tooltip: '編集',
            icon: const Icon(Icons.edit_outlined),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
          IconButton(
            onPressed: onDelete,
            tooltip: '削除',
            icon: const Icon(Icons.delete_outline),
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
    );
  }
}
