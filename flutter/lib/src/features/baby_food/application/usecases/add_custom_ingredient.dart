import 'package:uuid/uuid.dart';

import '../../domain/entities/custom_ingredient.dart';
import '../../domain/repositories/custom_ingredient_repository.dart';
import '../../domain/value_objects/food_category.dart';

/// カスタム食材を追加するユースケース
class AddCustomIngredient {
  AddCustomIngredient({
    required CustomIngredientRepository repository,
  }) : _repository = repository;

  final CustomIngredientRepository _repository;

  Future<CustomIngredient> call({
    required String name,
    required FoodCategory category,
  }) async {
    final trimmedName = name.trim();
    if (trimmedName.isEmpty) {
      throw ArgumentError('食材名を入力してください');
    }

    final ingredient = CustomIngredient(
      id: const Uuid().v4(),
      name: trimmedName,
      category: category,
      createdAt: DateTime.now(),
    );

    await _repository.add(ingredient);
    return ingredient;
  }
}
