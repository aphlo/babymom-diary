import 'package:flutter/material.dart';

import '../../domain/entities/custom_ingredient.dart';
import '../../domain/value_objects/food_category.dart';

/// 食材選択ウィジェット
class IngredientSelection extends StatelessWidget {
  const IngredientSelection({
    super.key,
    required this.expandedCategory,
    required this.selectedIngredientIds,
    required this.customIngredients,
    required this.hiddenIngredients,
    required this.onCategoryTap,
    required this.onIngredientToggle,
  });

  final FoodCategory? expandedCategory;
  final Set<String> selectedIngredientIds;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;
  final void Function(FoodCategory category) onCategoryTap;
  final void Function({
    required String ingredientId,
    required String ingredientName,
    required FoodCategory category,
    required bool isCustom,
  }) onIngredientToggle;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        for (final category in FoodCategory.values) ...[
          _CategoryTile(
            category: category,
            isExpanded: expandedCategory == category,
            selectedCount: _getSelectedCountForCategory(category),
            onTap: () => onCategoryTap(category),
          ),
          if (expandedCategory == category)
            _IngredientList(
              category: category,
              selectedIngredientIds: selectedIngredientIds,
              customIngredients: _getCustomIngredientsForCategory(category),
              hiddenIngredients: hiddenIngredients,
              onIngredientToggle: onIngredientToggle,
            ),
          const SizedBox(height: 8),
        ],
      ],
    );
  }

  int _getSelectedCountForCategory(FoodCategory category) {
    // プリセット食材のカウント（非表示を除く）
    int count = category.presetIngredients
        .where((name) =>
            !hiddenIngredients.contains(name) &&
            selectedIngredientIds.contains(name))
        .length;

    // カスタム食材のカウント
    count += customIngredients
        .where((i) =>
            i.category == category && selectedIngredientIds.contains(i.id))
        .length;

    return count;
  }

  List<CustomIngredient> _getCustomIngredientsForCategory(
      FoodCategory category) {
    return customIngredients.where((i) => i.category == category).toList();
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.isExpanded,
    required this.selectedCount,
    required this.onTap,
  });

  final FoodCategory category;
  final bool isExpanded;
  final int selectedCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      color: isExpanded ? Colors.pink.shade50 : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  category.label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              if (selectedCount > 0) ...[
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$selectedCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Icon(
                isExpanded ? Icons.expand_less : Icons.expand_more,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IngredientList extends StatelessWidget {
  const _IngredientList({
    required this.category,
    required this.selectedIngredientIds,
    required this.customIngredients,
    required this.hiddenIngredients,
    required this.onIngredientToggle,
  });

  final FoodCategory category;
  final Set<String> selectedIngredientIds;
  final List<CustomIngredient> customIngredients;
  final Set<String> hiddenIngredients;
  final void Function({
    required String ingredientId,
    required String ingredientName,
    required FoodCategory category,
    required bool isCustom,
  }) onIngredientToggle;

  @override
  Widget build(BuildContext context) {
    // 非表示食材を除外
    final presetIngredients = category.presetIngredients
        .where((name) => !hiddenIngredients.contains(name))
        .toList();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              // プリセット食材
              for (final ingredientName in presetIngredients)
                _IngredientChip(
                  ingredientId: ingredientName,
                  ingredientName: ingredientName,
                  isSelected: selectedIngredientIds.contains(ingredientName),
                  isCustom: false,
                  onTap: () => onIngredientToggle(
                    ingredientId: ingredientName,
                    ingredientName: ingredientName,
                    category: category,
                    isCustom: false,
                  ),
                ),
              // カスタム食材
              for (final ingredient in customIngredients)
                _IngredientChip(
                  ingredientId: ingredient.id,
                  ingredientName: ingredient.name,
                  isSelected: selectedIngredientIds.contains(ingredient.id),
                  isCustom: true,
                  onTap: () => onIngredientToggle(
                    ingredientId: ingredient.id,
                    ingredientName: ingredient.name,
                    category: category,
                    isCustom: true,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IngredientChip extends StatelessWidget {
  const _IngredientChip({
    required this.ingredientId,
    required this.ingredientName,
    required this.isSelected,
    required this.isCustom,
    required this.onTap,
  });

  final String ingredientId;
  final String ingredientName;
  final bool isSelected;
  final bool isCustom;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(ingredientName),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: Colors.white,
      selectedColor: Colors.pink.shade100,
      checkmarkColor: Colors.pink.shade700,
      side: BorderSide(color: Colors.grey.shade400),
    );
  }
}
