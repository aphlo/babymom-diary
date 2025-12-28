import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/features/baby_food/domain/value_objects/food_category.dart';

part 'ingredient_settings_view_model.freezed.dart';
part 'ingredient_settings_view_model.g.dart';

@freezed
sealed class IngredientSettingsState with _$IngredientSettingsState {
  const factory IngredientSettingsState({
    FoodCategory? expandedCategory,
  }) = _IngredientSettingsState;

  factory IngredientSettingsState.initial() =>
      const IngredientSettingsState(expandedCategory: null);
}

@riverpod
class IngredientSettingsViewModel extends _$IngredientSettingsViewModel {
  @override
  IngredientSettingsState build(String householdId) {
    return IngredientSettingsState.initial();
  }

  void toggleCategory(FoodCategory category) {
    if (state.expandedCategory == category) {
      state = state.copyWith(expandedCategory: null);
    } else {
      state = state.copyWith(expandedCategory: category);
    }
  }
}
