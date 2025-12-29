import '../../domain/repositories/custom_ingredient_repository.dart';

/// カスタム食材を更新するユースケース
class UpdateCustomIngredient {
  UpdateCustomIngredient({
    required CustomIngredientRepository repository,
  }) : _repository = repository;

  final CustomIngredientRepository _repository;

  Future<void> call({
    required String ingredientId,
    required String newName,
  }) async {
    final trimmedName = newName.trim();
    if (trimmedName.isEmpty) {
      throw ArgumentError('食材名を入力してください');
    }

    await _repository.update(ingredientId: ingredientId, newName: trimmedName);
  }
}
