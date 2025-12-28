import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/widgets/milu_infinite_time_picker.dart';
import '../../domain/value_objects/food_category.dart';
import '../models/baby_food_draft.dart';
import '../providers/baby_food_providers.dart';
import '../viewmodels/baby_food_sheet_state.dart';
import '../viewmodels/baby_food_sheet_view_model.dart';
import 'amount_input.dart';
import 'ingredient_selection.dart';

/// 離乳食記録シート
class BabyFoodSheet extends ConsumerStatefulWidget {
  const BabyFoodSheet({
    super.key,
    required this.args,
    required this.selectedDate,
  });

  final BabyFoodSheetArgs args;
  final DateTime selectedDate;

  @override
  ConsumerState<BabyFoodSheet> createState() => _BabyFoodSheetState();
}

class _BabyFoodSheetState extends ConsumerState<BabyFoodSheet> {
  BabyFoodSheetViewModelProvider get _viewModelProvider =>
      babyFoodSheetViewModelProvider(widget.args);

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(_viewModelProvider);
    final viewModel = ref.read(_viewModelProvider.notifier);
    final hiddenIngredientsAsync =
        ref.watch(hiddenIngredientsProvider(widget.args.householdId));
    final hiddenIngredients = hiddenIngredientsAsync.when(
      data: (data) => data,
      loading: () => <String>{},
      error: (_, __) => <String>{},
    );

    // エラーメッセージの表示
    ref.listen<BabyFoodSheetState>(_viewModelProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage != previous?.errorMessage) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
        viewModel.clearError();
      }
    });

    final isNew = state.isNew;
    final title = isNew ? '離乳食を記録' : '離乳食を編集';
    final stepTitle = state.isIngredientSelectionStep ? '食材を選択' : '食べた量を記録';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(title),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          if (!state.isNew)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: () => _showDeleteConfirmation(context),
            ),
        ],
      ),
      body: Column(
        children: [
          // 時刻選択
          _TimePickerTile(
            value: state.timeOfDay,
            onChanged: viewModel.setTimeOfDay,
          ),
          const Divider(height: 1),
          // ステップインジケーター
          _StepIndicator(
            currentStep: state.currentStep,
            stepTitle: stepTitle,
          ),
          // メインコンテンツ
          Expanded(
            child: state.isIngredientSelectionStep
                ? IngredientSelection(
                    expandedCategory: state.expandedCategory,
                    selectedIngredientIds: state.selectedItems
                        .map((item) => item.ingredientId)
                        .toSet(),
                    customIngredients: state.customIngredients,
                    hiddenIngredients: hiddenIngredients,
                    onCategoryTap: viewModel.toggleCategory,
                    onIngredientToggle: ({
                      required String ingredientId,
                      required String ingredientName,
                      required FoodCategory category,
                      required bool isCustom,
                    }) {
                      viewModel.toggleIngredient(
                        ingredientId: ingredientId,
                        ingredientName: ingredientName,
                        category: category,
                        isCustom: isCustom,
                      );
                    },
                  )
                : AmountInput(
                    items: state.selectedItems,
                    onAmountChanged: viewModel.updateItemAmount,
                    onUnitChanged: viewModel.updateItemUnit,
                    onReactionChanged: viewModel.updateItemReaction,
                    onAllergyChanged: viewModel.updateItemAllergy,
                    onMemoChanged: viewModel.updateItemMemo,
                  ),
          ),
          // 選択中の食材サマリー（食材選択ステップのみ）
          if (state.isIngredientSelectionStep && state.selectedItems.isNotEmpty)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.pink.shade50,
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.pink, size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '選択中: ${state.selectedItemsSummary}',
                      style: const TextStyle(fontSize: 14),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          // ボトムボタン
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  if (state.isAmountInputStep) ...[
                    OutlinedButton(
                      onPressed: viewModel.previousStep,
                      child: const Text('戻る'),
                    ),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: state.isIngredientSelectionStep
                        ? FilledButton(
                            onPressed:
                                state.canProceed ? viewModel.nextStep : null,
                            child: const Text('次へ'),
                          )
                        : FilledButton.icon(
                            onPressed: state.canSave
                                ? () => _handleSave(context)
                                : null,
                            icon: state.isProcessing
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.save),
                            label: const Text('保存'),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _handleSave(BuildContext context) async {
    final navigator = Navigator.of(context);
    final viewModel = ref.read(_viewModelProvider.notifier);
    final result = await viewModel.save(widget.selectedDate);
    if (result != null && mounted) {
      navigator.pop(result);
    }
  }

  Future<void> _showDeleteConfirmation(BuildContext context) async {
    final navigator = Navigator.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('記録を削除'),
        content: const Text('この離乳食の記録を削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      // 削除を示す特別な結果を返す
      navigator.pop(const _DeleteResult());
    }
  }
}

class _TimePickerTile extends StatelessWidget {
  const _TimePickerTile({
    required this.value,
    required this.onChanged,
  });

  final TimeOfDay value;
  final ValueChanged<TimeOfDay> onChanged;

  @override
  Widget build(BuildContext context) {
    final formatted = value.format(context);
    return ListTile(
      leading: const Icon(Icons.access_time),
      title: const Text('記録時間'),
      trailing: FilledButton.tonalIcon(
        onPressed: () async {
          final picked = await showMiluInfiniteTimePicker(
            context,
            initialTime: value,
          );
          if (picked != null) {
            onChanged(picked);
          }
        },
        icon: const Icon(Icons.edit, size: 18),
        label: Text(formatted),
      ),
    );
  }
}

class _StepIndicator extends StatelessWidget {
  const _StepIndicator({
    required this.currentStep,
    required this.stepTitle,
  });

  final int currentStep;
  final String stepTitle;

  @override
  Widget build(BuildContext context) {
    final isIngredientStep = currentStep == 0;
    final isAmountStep = currentStep == 1;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.grey.shade100,
      child: Row(
        children: [
          Text(
            stepTitle,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const Spacer(),
          if (isIngredientStep)
            GestureDetector(
              onTap: () => _showIngredientHelpDialog(context),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.help_outline,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '記録したい食材がない場合は',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          if (isAmountStep)
            Text(
              '反応や量の入力は任意です',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
              ),
            ),
        ],
      ),
    );
  }

  void _showIngredientHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('食材の追加について'),
        content: const Text(
          'メニュー画面から離乳食の食材を追加してください。\n\n'
          '追加した食材は、すべての記録で選択できるようになります。',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('閉じる'),
          ),
        ],
      ),
    );
  }
}

/// 削除結果を示すクラス
class _DeleteResult {
  const _DeleteResult();
}

/// 離乳食シートを表示するヘルパー関数
Future<BabyFoodDraft?> showBabyFoodSheet({
  required BuildContext context,
  required BabyFoodSheetArgs args,
  required DateTime selectedDate,
}) async {
  final result = await Navigator.of(context).push<Object>(
    MaterialPageRoute(
      builder: (_) => BabyFoodSheet(
        args: args,
        selectedDate: selectedDate,
      ),
      fullscreenDialog: true,
    ),
  );

  if (result is _DeleteResult) {
    // 削除が選択された場合はnullを返す（呼び出し元で削除処理を行う）
    return null;
  }

  return result as BabyFoodDraft?;
}
