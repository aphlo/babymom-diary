import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/custom_ingredient.dart';
import '../../domain/value_objects/food_category.dart';

part 'custom_ingredient_dto.freezed.dart';

/// カスタム食材DTO
@freezed
sealed class CustomIngredientDto with _$CustomIngredientDto {
  const CustomIngredientDto._();

  const factory CustomIngredientDto({
    required String id,
    required String name,
    required String categoryId,
    required DateTime createdAt,
  }) = _CustomIngredientDto;

  factory CustomIngredientDto.fromFirestore(
    Map<String, dynamic> data, {
    required String docId,
  }) {
    return CustomIngredientDto(
      id: docId,
      name: data['name'] as String,
      categoryId: data['categoryId'] as String,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  factory CustomIngredientDto.fromDomain(CustomIngredient ingredient) {
    return CustomIngredientDto(
      id: ingredient.id,
      name: ingredient.name,
      categoryId: ingredient.category.name,
      createdAt: ingredient.createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'categoryId': categoryId,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  CustomIngredient toDomain() {
    return CustomIngredient(
      id: id,
      name: name,
      category: _parseFoodCategory(categoryId) ?? FoodCategory.other,
      createdAt: createdAt,
    );
  }
}

FoodCategory? _parseFoodCategory(String? value) {
  if (value == null) return null;
  return FoodCategory.values.where((e) => e.name == value).firstOrNull;
}
