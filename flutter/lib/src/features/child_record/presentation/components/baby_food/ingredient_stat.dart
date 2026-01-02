import '../../../../baby_food/domain/value_objects/baby_food_reaction.dart';
import '../../../../baby_food/domain/value_objects/food_category.dart';

/// 食材の統計情報
class IngredientStat {
  const IngredientStat({
    required this.ingredientId,
    required this.ingredientName,
    required this.category,
    required this.hasEaten,
    required this.latestReaction,
    required this.eatCount,
    required this.hasAllergy,
  });

  final String ingredientId;
  final String ingredientName;
  final FoodCategory category;
  final bool hasEaten;
  final BabyFoodReaction? latestReaction;
  final int eatCount;
  final bool hasAllergy;
}
