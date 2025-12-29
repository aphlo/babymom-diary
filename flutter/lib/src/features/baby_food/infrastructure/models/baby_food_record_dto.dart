import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/baby_food_item.dart';
import '../../domain/entities/baby_food_record.dart';
import '../../domain/value_objects/amount_unit.dart';
import '../../domain/value_objects/baby_food_reaction.dart';
import '../../domain/value_objects/food_category.dart';

part 'baby_food_record_dto.freezed.dart';

/// 離乳食の食材アイテムDTO
@freezed
sealed class BabyFoodItemDto with _$BabyFoodItemDto {
  const BabyFoodItemDto._();

  const factory BabyFoodItemDto({
    required String ingredientId,
    required String ingredientName,
    required String categoryId,
    double? amount,
    String? unit,
    String? reaction,
    bool? hasAllergy,
    String? memo,
  }) = _BabyFoodItemDto;

  factory BabyFoodItemDto.fromJson(Map<String, dynamic> json) {
    return BabyFoodItemDto(
      ingredientId: json['ingredientId'] as String,
      ingredientName: json['ingredientName'] as String,
      categoryId: json['categoryId'] as String,
      amount: (json['amount'] as num?)?.toDouble(),
      unit: json['unit'] as String?,
      reaction: json['reaction'] as String?,
      hasAllergy: json['hasAllergy'] as bool?,
      memo: json['memo'] as String?,
    );
  }

  factory BabyFoodItemDto.fromDomain(BabyFoodItem item) {
    return BabyFoodItemDto(
      ingredientId: item.ingredientId,
      ingredientName: item.ingredientName,
      categoryId: item.category.name,
      amount: item.amount,
      unit: item.unit?.name,
      reaction: item.reaction?.firestoreValue,
      hasAllergy: item.hasAllergy,
      memo: item.memo,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'ingredientId': ingredientId,
      'ingredientName': ingredientName,
      'categoryId': categoryId,
      if (amount != null) 'amount': amount,
      if (unit != null) 'unit': unit,
      if (reaction != null) 'reaction': reaction,
      if (hasAllergy != null) 'hasAllergy': hasAllergy,
      if (memo != null) 'memo': memo,
    };
  }

  BabyFoodItem toDomain() {
    return BabyFoodItem(
      ingredientId: ingredientId,
      ingredientName: ingredientName,
      category: _parseFoodCategory(categoryId) ?? FoodCategory.other,
      amount: amount,
      unit: _parseAmountUnit(unit),
      reaction: BabyFoodReactionLabel.fromFirestoreValue(reaction),
      hasAllergy: hasAllergy,
      memo: memo,
    );
  }
}

/// 離乳食記録DTO
@freezed
sealed class BabyFoodRecordDto with _$BabyFoodRecordDto {
  const BabyFoodRecordDto._();

  const factory BabyFoodRecordDto({
    required String id,
    required DateTime recordedAt,
    required List<BabyFoodItemDto> items,
    String? note,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _BabyFoodRecordDto;

  factory BabyFoodRecordDto.fromFirestore(
    Map<String, dynamic> data, {
    required String docId,
  }) {
    final rawItems = data['items'] as List<dynamic>? ?? [];
    final items = rawItems
        .map((item) =>
            BabyFoodItemDto.fromJson(Map<String, dynamic>.from(item as Map)))
        .toList();

    return BabyFoodRecordDto(
      id: docId,
      recordedAt: (data['recordedAt'] as Timestamp).toDate(),
      items: items,
      note: data['note'] as String?,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  factory BabyFoodRecordDto.fromDomain(BabyFoodRecord record) {
    return BabyFoodRecordDto(
      id: record.id,
      recordedAt: record.recordedAt,
      items: record.items.map(BabyFoodItemDto.fromDomain).toList(),
      note: record.note,
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'recordedAt': Timestamp.fromDate(recordedAt),
      'items': items.map((item) => item.toJson()).toList(),
      if (note != null) 'note': note,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  BabyFoodRecord toDomain() {
    return BabyFoodRecord(
      id: id,
      recordedAt: recordedAt,
      items: items.map((item) => item.toDomain()).toList(),
      note: note,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

FoodCategory? _parseFoodCategory(String? value) {
  if (value == null) return null;
  return FoodCategory.values.where((e) => e.name == value).firstOrNull;
}

AmountUnit? _parseAmountUnit(String? value) {
  if (value == null) return null;
  return AmountUnit.values.where((e) => e.name == value).firstOrNull;
}
