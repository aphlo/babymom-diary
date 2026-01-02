import 'package:flutter/material.dart';

import '../../../../../core/types/child_icon.dart';
import '../../../../baby_food/domain/entities/custom_ingredient.dart';
import '../../../../baby_food/domain/value_objects/food_category.dart';
import 'add_ingredient_button.dart';
import 'ingredient_list_tiles.dart';
import 'ingredient_stat.dart';

class CategoryIngredientList extends StatelessWidget {
  const CategoryIngredientList({
    super.key,
    required this.householdId,
    required this.category,
    required this.ingredientStats,
    required this.customIngredients,
    required this.hiddenIngredients,
    required this.childIcon,
  });

  final String householdId;
  final FoodCategory category;
  final Map<String, IngredientStat> ingredientStats;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;
  final ChildIcon childIcon;

  @override
  Widget build(BuildContext context) {
    // プリセット食材を取得（非表示を除外）
    final visiblePresetIngredients = category.presetIngredients
        .where((name) => !hiddenIngredients.contains(name))
        .toList();
    // カスタム食材（非表示を除外）
    final visibleCustomIngredients = customIngredients
        .where((i) => !hiddenIngredients.contains(i.id))
        .toList();

    // プリセット食材 + カスタム食材 + 食材追加ボタン
    final totalItems = visiblePresetIngredients.length +
        visibleCustomIngredients.length +
        1; // 食材追加ボタン

    return ListView.builder(
      padding: EdgeInsets.zero, // 1行目の高さズレ防止
      itemCount: totalItems,
      itemBuilder: (context, index) {
        // プリセット食材
        if (index < visiblePresetIngredients.length) {
          final ingredientName = visiblePresetIngredients[index];
          final stat = ingredientStats[ingredientName];
          return IngredientListTile(
            ingredientId: ingredientName,
            ingredientName: ingredientName,
            category: category,
            hasEaten: stat?.hasEaten ?? false,
            reaction: stat?.latestReaction,
            hasAllergy: stat?.hasAllergy ?? false,
            childIcon: childIcon,
          );
        }

        final customIndex = index - visiblePresetIngredients.length;

        // カスタム食材（プリセット食材と同じUIで表示）
        if (customIndex < visibleCustomIngredients.length) {
          final customIngredient = visibleCustomIngredients[customIndex];
          final stat = ingredientStats[customIngredient.id];
          return IngredientListTile(
            ingredientId: customIngredient.id,
            ingredientName: customIngredient.name,
            category: category,
            hasEaten: stat?.hasEaten ?? false,
            reaction: stat?.latestReaction,
            hasAllergy: stat?.hasAllergy ?? false,
            childIcon: childIcon,
          );
        }

        // 食材追加ボタン
        return AddIngredientButton(
          householdId: householdId,
          category: category,
        );
      },
    );
  }
}
