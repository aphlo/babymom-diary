import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/amount_unit.dart';
import '../value_objects/baby_food_reaction.dart';
import '../value_objects/food_category.dart';

part 'baby_food_item.freezed.dart';

/// 離乳食で食べた食材アイテム
@freezed
sealed class BabyFoodItem with _$BabyFoodItem {
  const BabyFoodItem._();

  const factory BabyFoodItem({
    /// 食材のID（プリセット食材の場合は食材名、カスタム食材の場合はUUID）
    required String ingredientId,

    /// 食材名
    required String ingredientName,

    /// 食材カテゴリ
    required FoodCategory category,

    /// 食べた量（任意）
    double? amount,

    /// 量の単位（任意）
    AmountUnit? unit,

    /// 子供の反応（任意）
    BabyFoodReaction? reaction,

    /// アレルギー反応があったか（任意）
    bool? hasAllergy,

    /// メモ（任意、最大100文字）
    String? memo,
  }) = _BabyFoodItem;

  /// 量が記録されているかどうか
  bool get hasAmount => amount != null && unit != null;

  /// 量の表示文字列（例: "大さじ1", "30g"）
  String? get amountDisplay {
    if (!hasAmount) return null;
    final formattedAmount = amount == amount!.truncate()
        ? amount!.truncate().toString()
        : amount.toString();
    // 大さじ・小さじは単位を先に表示（例: "大さじ1"）
    // ml・gは数値を先に表示（例: "30ml"）
    return switch (unit!) {
      AmountUnit.tablespoon ||
      AmountUnit.teaspoon =>
        '${unit!.shortLabel}$formattedAmount',
      AmountUnit.ml || AmountUnit.gram => '$formattedAmount${unit!.shortLabel}',
    };
  }
}
