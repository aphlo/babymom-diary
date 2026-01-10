import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../baby_food/domain/entities/custom_ingredient.dart';
import '../../../../baby_food/domain/value_objects/food_category.dart';
import 'add_ingredient_button.dart';
import 'custom_ingredient_tile.dart';
import 'preset_ingredient_tile.dart';
import 'section_header.dart';

/// 各カテゴリの食材リスト（タブ内容）
class CategoryIngredientList extends ConsumerWidget {
  const CategoryIngredientList({
    super.key,
    required this.householdId,
    required this.category,
    required this.customIngredients,
    required this.hiddenIngredients,
  });

  final String householdId;
  final FoodCategory category;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final presetIngredients = category.presetIngredients;
    // プリセット食材のフィルタリング
    final visiblePresetIngredients = presetIngredients
        .where((name) => !hiddenIngredients.contains(name))
        .toList();
    final hiddenPresetIngredients = presetIngredients
        .where((name) => hiddenIngredients.contains(name))
        .toList();
    // カスタム食材のフィルタリング（IDで非表示判定）
    final visibleCustomIngredients = customIngredients
        .where((i) => !hiddenIngredients.contains(i.id))
        .toList();
    final hiddenCustomIngredients = customIngredients
        .where((i) => hiddenIngredients.contains(i.id))
        .toList();

    final hasHiddenIngredients = hiddenPresetIngredients.isNotEmpty ||
        hiddenCustomIngredients.isNotEmpty;

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        // 食材追加ボタン
        AddIngredientButton(
          householdId: householdId,
          category: category,
        ),
        // 表示する食材セクション
        const SectionHeader(title: '表示する食材'),
        // 食材一覧（カスタム + プリセット）
        for (final ingredient in visibleCustomIngredients)
          CustomIngredientTile(
            householdId: householdId,
            ingredient: ingredient,
            isHidden: false,
          ),
        for (final ingredientName in visiblePresetIngredients)
          PresetIngredientTile(
            householdId: householdId,
            ingredientName: ingredientName,
            isHidden: false,
          ),
        // 非表示にした食材セクション
        if (hasHiddenIngredients) ...[
          const SectionHeader(
            title: '非表示の食材（タップで復元）',
          ),
          for (final ingredient in hiddenCustomIngredients)
            CustomIngredientTile(
              householdId: householdId,
              ingredient: ingredient,
              isHidden: true,
            ),
          for (final ingredientName in hiddenPresetIngredients)
            PresetIngredientTile(
              householdId: householdId,
              ingredientName: ingredientName,
              isHidden: true,
            ),
        ],
        const SizedBox(height: 32),
      ],
    );
  }
}
