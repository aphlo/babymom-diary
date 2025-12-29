import '../../domain/entities/custom_ingredient.dart';
import '../../domain/repositories/custom_ingredient_repository.dart';

/// カスタム食材を監視するユースケース
class WatchCustomIngredients {
  WatchCustomIngredients({
    required CustomIngredientRepository repository,
  }) : _repository = repository;

  final CustomIngredientRepository _repository;

  Stream<List<CustomIngredient>> call() {
    return _repository.watchAll();
  }
}
