import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/types/child_icon.dart';
import '../../../../baby_food/domain/entities/custom_ingredient.dart';
import '../../../../baby_food/domain/value_objects/food_category.dart';
import 'add_ingredient_button.dart';
import 'ingredient_list_tiles.dart';
import 'ingredient_stat.dart';

class CategoryIngredientList extends ConsumerWidget {
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
  Widget build(BuildContext context, WidgetRef ref) {
    // プリセット食材を取得（非表示を除外）
    final visiblePresetIngredients = category.presetIngredients
        .where((name) => !hiddenIngredients.contains(name))
        .toList();
    // カスタム食材（非表示を除外）
    final visibleCustomIngredients = customIngredients
        .where((i) => !hiddenIngredients.contains(i.id))
        .toList();

    // リストの項目数:
    // プリセット食材 + カスタム食材セクションヘッダー（カスタム食材がある場合）
    // + カスタム食材 + 食材追加ボタン
    final hasCustomIngredients = visibleCustomIngredients.isNotEmpty;
    final totalItems = visiblePresetIngredients.length +
        (hasCustomIngredients ? 1 : 0) + // セクションヘッダー
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

        final offsetIndex = index - visiblePresetIngredients.length;

        // カスタム食材セクションヘッダー
        if (hasCustomIngredients && offsetIndex == 0) {
          return const SectionHeader(title: '追加した食材');
        }

        // カスタム食材
        final customIndex =
            hasCustomIngredients ? offsetIndex - 1 : offsetIndex;
        if (customIndex < visibleCustomIngredients.length) {
          final customIngredient = visibleCustomIngredients[customIndex];
          final stat = ingredientStats[customIngredient.id];
          return CustomIngredientListTile(
            householdId: householdId,
            ingredient: customIngredient,
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

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: Colors.grey.shade600,
        ),
      ),
    );
  }
}
