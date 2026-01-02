import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/types/child_icon.dart';
import '../../../menu/children/application/child_context_provider.dart';
import '../../../menu/children/application/selected_child_provider.dart';
import '../../domain/value_objects/food_category.dart';
import '../models/baby_food_draft.dart';
import '../viewmodels/baby_food_sheet_state.dart';
import '../viewmodels/baby_food_sheet_view_model.dart';
import 'amount_input.dart';
import 'ingredient_selection.dart';
import 'step_indicator.dart';
import 'time_picker_tile.dart';

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

    // 選択中の子供が変更されたらシートを閉じる
    ref.listen<AsyncValue<String?>>(selectedChildControllerProvider,
        (previous, next) {
      final nextChildId = next.value;
      // 初期ロード時はスキップ（previous == null）
      // 実際に子供が切り替わった時のみ閉じる
      if (previous != null &&
          nextChildId != null &&
          nextChildId != widget.args.childId) {
        Navigator.of(context).pop();
      }
    });

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
          TimePickerTile(
            value: state.timeOfDay,
            onChanged: viewModel.setTimeOfDay,
          ),
          const Divider(height: 1),
          // ステップインジケーター
          StepIndicator(
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
                    childIcon: ref
                            .watch(childContextProvider)
                            .value
                            ?.selectedChildSummary
                            ?.icon ??
                        ChildIcon.bear,
                    onAmountChanged: viewModel.updateItemAmount,
                    onUnitChanged: viewModel.updateItemUnit,
                    onReactionChanged: viewModel.updateItemReaction,
                    onAllergyChanged: viewModel.updateItemAllergy,
                    onMemoChanged: viewModel.updateItemMemo,
                  ),
          ),
          // 選択中の食材サマリー（食材選択ステップのみ）
          if (state.isIngredientSelectionStep && state.selectedItems.isNotEmpty)
            _SelectedItemsSummary(summary: state.selectedItemsSummary),
          // ボトムボタン
          _BottomButtons(
            state: state,
            onPreviousStep: viewModel.previousStep,
            onNextStep: viewModel.nextStep,
            onSave: () => _handleSave(context),
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
      final viewModel = ref.read(_viewModelProvider.notifier);
      final success = await viewModel.delete();
      if (success && mounted) {
        navigator.pop(const _DeleteResult());
      }
    }
  }
}

/// 選択中の食材サマリー
class _SelectedItemsSummary extends StatelessWidget {
  const _SelectedItemsSummary({required this.summary});

  final String summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.pink.shade50,
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.pink, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '選択中: $summary',
              style: const TextStyle(fontSize: 14),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

/// ボトムボタン
class _BottomButtons extends StatelessWidget {
  const _BottomButtons({
    required this.state,
    required this.onPreviousStep,
    required this.onNextStep,
    required this.onSave,
  });

  final BabyFoodSheetState state;
  final VoidCallback onPreviousStep;
  final VoidCallback onNextStep;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (state.showBackButton) ...[
              OutlinedButton(
                onPressed: onPreviousStep,
                child: const Text('戻る'),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: state.isIngredientSelectionStep
                  ? FilledButton(
                      onPressed: state.canProceed ? onNextStep : null,
                      child: const Text('次へ'),
                    )
                  : FilledButton.icon(
                      onPressed: state.canSave ? onSave : null,
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
