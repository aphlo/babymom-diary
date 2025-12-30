import '../../domain/value_objects/baby_food_reaction.dart';

/// 食材の記録情報
class IngredientRecordInfo {
  const IngredientRecordInfo({
    required this.recordedAt,
    this.amount,
    this.reaction,
    this.memo,
    required this.hasAllergy,
  });

  final DateTime recordedAt;
  final String? amount;
  final BabyFoodReaction? reaction;
  final String? memo;
  final bool hasAllergy;
}
