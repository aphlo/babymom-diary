import '../../domain/repositories/custom_ingredient_repository.dart';

/// カスタム食材を削除するユースケース
class DeleteCustomIngredient {
  DeleteCustomIngredient({
    required CustomIngredientRepository repository,
  }) : _repository = repository;

  final CustomIngredientRepository _repository;

  Future<void> call({
    required String ingredientId,
  }) async {
    await _repository.delete(ingredientId);
  }
}
