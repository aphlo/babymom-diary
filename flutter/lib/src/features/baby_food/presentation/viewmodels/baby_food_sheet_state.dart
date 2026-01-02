import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/custom_ingredient.dart';
import '../../domain/value_objects/food_category.dart';
import '../models/baby_food_draft.dart';

part 'baby_food_sheet_state.freezed.dart';

/// 離乳食記録シートの状態
@freezed
sealed class BabyFoodSheetState with _$BabyFoodSheetState {
  const BabyFoodSheetState._();

  const factory BabyFoodSheetState({
    /// 現在のステップ（0: 食材選択, 1: 量入力）
    required int currentStep,

    /// 記録時刻
    required TimeOfDay timeOfDay,

    /// 選択中の食材リスト
    required List<BabyFoodItemDraft> selectedItems,

    /// 展開中のカテゴリ（null: 全て閉じている）
    FoodCategory? expandedCategory,

    /// カスタム食材リスト
    required List<CustomIngredient> customIngredients,

    /// メモ
    String? note,

    /// 処理中かどうか
    @Default(false) bool isProcessing,

    /// エラーメッセージ
    String? errorMessage,

    /// 新規作成かどうか
    required bool isNew,

    /// 既存レコードのID（編集時のみ）
    String? existingId,

    /// 食材選択ステップをスキップしたかどうか
    @Default(false) bool skippedIngredientSelection,
  }) = _BabyFoodSheetState;

  factory BabyFoodSheetState.initial({
    required BabyFoodDraft draft,
    required List<CustomIngredient> customIngredients,
    int initialStep = 0,
    bool skippedIngredientSelection = false,
  }) {
    return BabyFoodSheetState(
      currentStep: initialStep,
      timeOfDay: draft.timeOfDay,
      selectedItems: List.from(draft.items),
      expandedCategory: null,
      customIngredients: customIngredients,
      note: draft.note,
      isProcessing: false,
      errorMessage: null,
      isNew: draft.isNew,
      existingId: draft.existingId,
      skippedIngredientSelection: skippedIngredientSelection,
    );
  }

  /// 食材選択ステップかどうか
  bool get isIngredientSelectionStep => currentStep == 0;

  /// 量入力ステップかどうか
  bool get isAmountInputStep => currentStep == 1;

  /// 戻るボタンを表示するかどうか
  /// 量入力ステップで、かつ食材選択をスキップしていない場合のみ表示
  bool get showBackButton => isAmountInputStep && !skippedIngredientSelection;

  /// 次へボタンが有効かどうか
  bool get canProceed => selectedItems.isNotEmpty;

  /// 保存ボタンが有効かどうか
  bool get canSave => selectedItems.isNotEmpty && !isProcessing;

  /// 指定カテゴリのカスタム食材を取得
  List<CustomIngredient> getCustomIngredientsForCategory(
      FoodCategory category) {
    return customIngredients.where((i) => i.category == category).toList();
  }

  /// 指定食材が選択されているかどうか
  bool isIngredientSelected(String ingredientId) {
    return selectedItems.any((item) => item.ingredientId == ingredientId);
  }

  /// 選択中の食材名サマリー
  String get selectedItemsSummary {
    if (selectedItems.isEmpty) return '食材を選択してください';
    if (selectedItems.length <= 3) {
      return selectedItems.map((item) => item.ingredientName).join(', ');
    }
    final first3 =
        selectedItems.take(3).map((item) => item.ingredientName).join(', ');
    return '$first3 他${selectedItems.length - 3}件';
  }
}
