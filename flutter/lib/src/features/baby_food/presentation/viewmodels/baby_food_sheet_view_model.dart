import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/custom_ingredient.dart';
import '../../domain/value_objects/amount_unit.dart';
import '../../domain/value_objects/baby_food_reaction.dart';
import '../../domain/value_objects/food_category.dart';
import '../models/baby_food_draft.dart';
import '../providers/baby_food_providers.dart';
import 'baby_food_sheet_state.dart';

part 'baby_food_sheet_view_model.g.dart';

/// ViewModel引数
class BabyFoodSheetArgs {
  const BabyFoodSheetArgs({
    required this.householdId,
    required this.childId,
    required this.initialDraft,
    required this.customIngredients,
    required this.hiddenIngredients,
    this.skipIngredientSelection = false,
  });

  final String householdId;
  final String childId;
  final BabyFoodDraft initialDraft;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;

  /// 食材選択ステップをスキップして量入力ステップから開始するか
  final bool skipIngredientSelection;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is BabyFoodSheetArgs &&
        other.householdId == householdId &&
        other.childId == childId &&
        other.initialDraft.existingId == initialDraft.existingId &&
        other.skipIngredientSelection == skipIngredientSelection;
  }

  @override
  int get hashCode => Object.hash(
      householdId, childId, initialDraft.existingId, skipIngredientSelection);
}

@riverpod
class BabyFoodSheetViewModel extends _$BabyFoodSheetViewModel {
  late String _householdId;
  late String _childId;

  @override
  BabyFoodSheetState build(BabyFoodSheetArgs args) {
    _householdId = args.householdId;
    _childId = args.childId;
    return BabyFoodSheetState.initial(
      draft: args.initialDraft,
      customIngredients: args.customIngredients,
      hiddenIngredients: args.hiddenIngredients,
      initialStep: args.skipIngredientSelection ? 1 : 0,
      skippedIngredientSelection: args.skipIngredientSelection,
    );
  }

  /// 時刻を変更
  void setTimeOfDay(TimeOfDay time) {
    state = state.copyWith(timeOfDay: time);
  }

  /// カテゴリの展開/折りたたみを切り替え
  void toggleCategory(FoodCategory category) {
    if (state.expandedCategory == category) {
      state = state.copyWith(expandedCategory: null);
    } else {
      state = state.copyWith(expandedCategory: category);
    }
  }

  /// 食材を選択/解除
  void toggleIngredient({
    required String ingredientId,
    required String ingredientName,
    required FoodCategory category,
    required bool isCustom,
  }) {
    final currentItems = List<BabyFoodItemDraft>.from(state.selectedItems);
    final existingIndex =
        currentItems.indexWhere((item) => item.ingredientId == ingredientId);

    if (existingIndex >= 0) {
      // 既に選択されている場合は解除
      currentItems.removeAt(existingIndex);
    } else {
      // 選択されていない場合は追加
      final newItem = isCustom
          ? BabyFoodItemDraft.fromCustom(
              id: ingredientId,
              name: ingredientName,
              category: category,
            )
          : BabyFoodItemDraft.fromPreset(
              ingredientName: ingredientName,
              category: category,
            );
      currentItems.add(newItem);
    }

    state = state.copyWith(selectedItems: currentItems);
  }

  /// 次のステップへ
  void nextStep() {
    if (state.currentStep < 1 && state.canProceed) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  /// 前のステップへ
  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  /// 食材の量を更新
  void updateItemAmount(String ingredientId, double? amount) {
    final currentItems = List<BabyFoodItemDraft>.from(state.selectedItems);
    final index =
        currentItems.indexWhere((item) => item.ingredientId == ingredientId);

    if (index >= 0) {
      currentItems[index] = currentItems[index].copyWith(amount: amount);
      state = state.copyWith(selectedItems: currentItems);
    }
  }

  /// 食材の単位を更新
  void updateItemUnit(String ingredientId, AmountUnit unit) {
    final currentItems = List<BabyFoodItemDraft>.from(state.selectedItems);
    final index =
        currentItems.indexWhere((item) => item.ingredientId == ingredientId);

    if (index >= 0) {
      currentItems[index] = currentItems[index].copyWith(unit: unit);
      state = state.copyWith(selectedItems: currentItems);
    }
  }

  /// 食材の反応を更新
  void updateItemReaction(String ingredientId, BabyFoodReaction? reaction) {
    final currentItems = List<BabyFoodItemDraft>.from(state.selectedItems);
    final index =
        currentItems.indexWhere((item) => item.ingredientId == ingredientId);

    if (index >= 0) {
      currentItems[index] = currentItems[index].copyWith(reaction: reaction);
      state = state.copyWith(selectedItems: currentItems);
    }
  }

  /// 食材のアレルギー有無を更新
  void updateItemAllergy(String ingredientId, bool? hasAllergy) {
    final currentItems = List<BabyFoodItemDraft>.from(state.selectedItems);
    final index =
        currentItems.indexWhere((item) => item.ingredientId == ingredientId);

    if (index >= 0) {
      currentItems[index] =
          currentItems[index].copyWith(hasAllergy: hasAllergy);
      state = state.copyWith(selectedItems: currentItems);
    }
  }

  /// 食材のメモを更新
  void updateItemMemo(String ingredientId, String? memo) {
    final currentItems = List<BabyFoodItemDraft>.from(state.selectedItems);
    final index =
        currentItems.indexWhere((item) => item.ingredientId == ingredientId);

    if (index >= 0) {
      currentItems[index] = currentItems[index].copyWith(memo: memo);
      state = state.copyWith(selectedItems: currentItems);
    }
  }

  /// メモを更新（レコード全体のメモ）
  void updateNote(String? note) {
    state = state.copyWith(note: note?.isEmpty == true ? null : note);
  }

  /// カスタム食材を追加
  Future<void> addCustomIngredient({
    required String name,
    required FoodCategory category,
  }) async {
    final useCase = ref.read(addCustomIngredientUseCaseProvider(_householdId));
    try {
      final ingredient = await useCase.call(name: name, category: category);

      // カスタム食材リストを更新
      final updatedCustomIngredients =
          List<CustomIngredient>.from(state.customIngredients)..add(ingredient);
      state = state.copyWith(customIngredients: updatedCustomIngredients);

      // 新しく追加した食材を自動選択
      toggleIngredient(
        ingredientId: ingredient.id,
        ingredientName: ingredient.name,
        category: ingredient.category,
        isCustom: true,
      );
    } catch (e) {
      state = state.copyWith(errorMessage: 'カスタム食材の追加に失敗しました');
    }
  }

  /// 保存処理
  Future<BabyFoodDraft?> save(DateTime baseDate) async {
    if (!state.canSave) return null;

    state = state.copyWith(isProcessing: true, errorMessage: null);

    try {
      // 時刻を含む記録日時を作成
      final recordedAt = DateTime(
        baseDate.year,
        baseDate.month,
        baseDate.day,
        state.timeOfDay.hour,
        state.timeOfDay.minute,
      );

      final draft = BabyFoodDraft(
        existingId: state.existingId,
        recordedAt: recordedAt,
        items: state.selectedItems,
        note: state.note,
      );

      // ドメインエンティティに変換してユースケースを呼び出し
      final items = draft.toItems();

      if (state.isNew) {
        final addUseCase =
            ref.read(addBabyFoodRecordUseCaseProvider(_householdId));
        await addUseCase.call(
          childId: _childId,
          recordedAt: recordedAt,
          items: items,
          note: state.note,
        );
      } else {
        final updateUseCase =
            ref.read(updateBabyFoodRecordUseCaseProvider(_householdId));
        // 既存レコードを取得して更新
        // Note: 実際の実装では既存レコードをキャッシュしておくか、
        // 別の方法で更新処理を行う
        final repository =
            ref.read(babyFoodRecordRepositoryProvider(_householdId));
        final existingRecords =
            await repository.getRecordsForDay(_childId, baseDate);
        final existingRecord =
            existingRecords.where((r) => r.id == state.existingId).firstOrNull;

        if (existingRecord != null) {
          await updateUseCase.call(
            childId: _childId,
            existingRecord: existingRecord,
            recordedAt: recordedAt,
            items: items,
            note: state.note,
          );
        }
      }

      state = state.copyWith(isProcessing: false);
      return draft;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: '保存に失敗しました: $e',
      );
      return null;
    }
  }

  /// エラーメッセージをクリア
  void clearError() {
    state = state.copyWith(errorMessage: null);
  }

  /// 削除処理
  Future<bool> delete() async {
    final recordId = state.existingId;
    if (recordId == null) return false;

    state = state.copyWith(isProcessing: true, errorMessage: null);

    try {
      final deleteUseCase =
          ref.read(deleteBabyFoodRecordUseCaseProvider(_householdId));
      await deleteUseCase.call(childId: _childId, recordId: recordId);
      state = state.copyWith(isProcessing: false);
      return true;
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: '削除に失敗しました: $e',
      );
      return false;
    }
  }
}
