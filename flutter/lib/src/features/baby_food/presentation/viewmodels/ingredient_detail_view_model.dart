import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/value_objects/food_category.dart';
import '../providers/baby_food_providers.dart';
import 'ingredient_detail_state.dart';

part 'ingredient_detail_view_model.g.dart';

/// ViewModelの引数
class IngredientDetailArgs {
  const IngredientDetailArgs({
    required this.householdId,
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
  });

  final String householdId;
  final String ingredientId;
  final String ingredientName;
  final FoodCategory category;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is IngredientDetailArgs &&
        other.householdId == householdId &&
        other.ingredientId == ingredientId;
  }

  @override
  int get hashCode => Object.hash(householdId, ingredientId);
}

@riverpod
class IngredientDetailViewModel extends _$IngredientDetailViewModel {
  late String _householdId;
  late String _ingredientId;

  @override
  IngredientDetailState build(IngredientDetailArgs args) {
    _householdId = args.householdId;
    _ingredientId = args.ingredientId;

    // customIngredientsProviderを監視してisCustomIngredientを動的に判定
    final customIngredientsAsync =
        ref.watch(customIngredientsProvider(_householdId));
    final isCustomIngredient =
        customIngredientsAsync.value?.any((c) => c.id == _ingredientId) ??
            false;

    return IngredientDetailState.initial(
      ingredientName: args.ingredientName,
      isCustomIngredient: isCustomIngredient,
    );
  }

  /// UIイベントをクリア
  void clearUiEvent() {
    state = state.copyWith(pendingUiEvent: null);
  }

  /// カスタム食材の名前を更新
  Future<void> updateIngredientName(String newName) async {
    if (newName == state.currentIngredientName) return;

    state = state.copyWith(isProcessing: true, pendingUiEvent: null);

    try {
      final useCase =
          ref.read(updateCustomIngredientUseCaseProvider(_householdId));
      await useCase.call(
        ingredientId: _ingredientId,
        newName: newName,
      );

      // 破棄済みなら状態更新しない
      if (!ref.mounted) return;

      state = state.copyWith(
        isProcessing: false,
        currentIngredientName: newName,
      );
    } catch (e) {
      // 破棄済みなら状態更新しない
      if (!ref.mounted) return;

      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const IngredientDetailUiEvent.showMessage(
          '名前の変更に失敗しました',
        ),
      );
    }
  }

  /// カスタム食材を削除
  Future<void> deleteIngredient() async {
    state = state.copyWith(isProcessing: true, pendingUiEvent: null);

    try {
      final useCase =
          ref.read(deleteCustomIngredientUseCaseProvider(_householdId));
      await useCase.call(ingredientId: _ingredientId);

      // 破棄済みなら状態更新しない
      if (!ref.mounted) return;

      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const IngredientDetailUiEvent.navigateBack(),
      );
    } catch (e) {
      // 破棄済みなら状態更新しない
      if (!ref.mounted) return;

      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const IngredientDetailUiEvent.showMessage(
          '削除に失敗しました',
        ),
      );
    }
  }
}
