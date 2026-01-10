import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/food_category.dart';

part 'custom_ingredient.freezed.dart';

/// ユーザーが追加したカスタム食材
@freezed
sealed class CustomIngredient with _$CustomIngredient {
  const CustomIngredient._();

  const factory CustomIngredient({
    /// カスタム食材のID（UUID）
    required String id,

    /// 食材名
    required String name,

    /// 所属カテゴリ
    required FoodCategory category,

    /// 作成日時
    required DateTime createdAt,
  }) = _CustomIngredient;
}
