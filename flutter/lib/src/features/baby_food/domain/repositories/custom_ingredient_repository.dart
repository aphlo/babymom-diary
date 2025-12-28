import '../entities/custom_ingredient.dart';
import '../value_objects/food_category.dart';

/// カスタム食材のリポジトリインターフェース
abstract class CustomIngredientRepository {
  /// 全てのカスタム食材を取得
  Future<List<CustomIngredient>> getAll();

  /// 全てのカスタム食材をストリームで監視
  Stream<List<CustomIngredient>> watchAll();

  /// カテゴリごとのカスタム食材を取得
  Future<List<CustomIngredient>> getByCategory(FoodCategory category);

  /// カスタム食材を追加
  Future<void> add(CustomIngredient ingredient);

  /// カスタム食材を削除
  Future<void> delete(String ingredientId);
}
