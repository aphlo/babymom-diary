import '../../domain/value_objects/baby_food_reaction.dart';

/// 食材の記録情報
class IngredientRecordInfo {
  const IngredientRecordInfo({
    required this.recordId,
    required this.recordedAt,
    this.amount,
    this.reaction,
    this.memo,
    required this.hasAllergy,
  });

  /// 記録のID（編集時に使用）
  final String recordId;
  final DateTime recordedAt;
  final String? amount;
  final BabyFoodReaction? reaction;
  final String? memo;
  final bool hasAllergy;
}
