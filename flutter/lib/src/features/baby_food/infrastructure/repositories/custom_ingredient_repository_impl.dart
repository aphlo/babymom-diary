import '../../domain/entities/custom_ingredient.dart';
import '../../domain/repositories/custom_ingredient_repository.dart';
import '../../domain/value_objects/food_category.dart';
import '../sources/custom_ingredient_firestore_data_source.dart';

/// カスタム食材リポジトリの実装
class CustomIngredientRepositoryImpl implements CustomIngredientRepository {
  CustomIngredientRepositoryImpl({
    required CustomIngredientFirestoreDataSource dataSource,
  }) : _dataSource = dataSource;

  final CustomIngredientFirestoreDataSource _dataSource;

  @override
  Future<List<CustomIngredient>> getAll() {
    return _dataSource.getAll();
  }

  @override
  Stream<List<CustomIngredient>> watchAll() {
    return _dataSource.watchAll();
  }

  @override
  Future<List<CustomIngredient>> getByCategory(FoodCategory category) {
    return _dataSource.getByCategory(category);
  }

  @override
  Future<void> add(CustomIngredient ingredient) {
    return _dataSource.add(ingredient);
  }

  @override
  Future<void> update({required String ingredientId, required String newName}) {
    return _dataSource.update(ingredientId: ingredientId, newName: newName);
  }

  @override
  Future<void> delete(String ingredientId) {
    return _dataSource.delete(ingredientId);
  }
}
