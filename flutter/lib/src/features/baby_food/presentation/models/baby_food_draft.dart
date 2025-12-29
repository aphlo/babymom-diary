import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/baby_food_item.dart';
import '../../domain/entities/baby_food_record.dart';
import '../../domain/value_objects/amount_unit.dart';
import '../../domain/value_objects/baby_food_reaction.dart';
import '../../domain/value_objects/food_category.dart';

part 'baby_food_draft.freezed.dart';

/// 離乳食記録の編集用ドラフト
@freezed
sealed class BabyFoodDraft with _$BabyFoodDraft {
  const BabyFoodDraft._();

  const factory BabyFoodDraft({
    /// 既存レコードのID（新規作成の場合はnull）
    String? existingId,

    /// 記録日時
    required DateTime recordedAt,

    /// 選択された食材リスト
    required List<BabyFoodItemDraft> items,

    /// メモ
    String? note,
  }) = _BabyFoodDraft;

  /// 新規作成用のドラフト
  factory BabyFoodDraft.newRecord({
    required DateTime recordedAt,
  }) {
    return BabyFoodDraft(
      existingId: null,
      recordedAt: recordedAt,
      items: const [],
      note: null,
    );
  }

  /// 既存レコードからドラフトを作成
  factory BabyFoodDraft.fromRecord(BabyFoodRecord record) {
    return BabyFoodDraft(
      existingId: record.id,
      recordedAt: record.recordedAt,
      items: record.items.map(BabyFoodItemDraft.fromItem).toList(),
      note: record.note,
    );
  }

  /// 新規作成かどうか
  bool get isNew => existingId == null;

  /// 時刻のみ
  TimeOfDay get timeOfDay => TimeOfDay.fromDateTime(recordedAt);

  /// 選択された食材名のサマリー
  String get itemsSummary {
    if (items.isEmpty) return '食材を選択してください';
    return items.map((item) => item.ingredientName).join(', ');
  }

  /// ドメインエンティティに変換
  List<BabyFoodItem> toItems() {
    return items.map((draft) => draft.toItem()).toList();
  }
}

/// 離乳食の食材編集用ドラフト
@freezed
sealed class BabyFoodItemDraft with _$BabyFoodItemDraft {
  const BabyFoodItemDraft._();

  const factory BabyFoodItemDraft({
    required String ingredientId,
    required String ingredientName,
    required FoodCategory category,
    double? amount,
    AmountUnit? unit,
    BabyFoodReaction? reaction,
    bool? hasAllergy,
    String? memo,
  }) = _BabyFoodItemDraft;

  /// プリセット食材から作成
  factory BabyFoodItemDraft.fromPreset({
    required String ingredientName,
    required FoodCategory category,
  }) {
    return BabyFoodItemDraft(
      ingredientId: ingredientName, // プリセットは名前をIDとして使用
      ingredientName: ingredientName,
      category: category,
      amount: null,
      unit: null,
    );
  }

  /// カスタム食材から作成
  factory BabyFoodItemDraft.fromCustom({
    required String id,
    required String name,
    required FoodCategory category,
  }) {
    return BabyFoodItemDraft(
      ingredientId: id,
      ingredientName: name,
      category: category,
      amount: null,
      unit: null,
    );
  }

  /// ドメインエンティティから作成
  factory BabyFoodItemDraft.fromItem(BabyFoodItem item) {
    return BabyFoodItemDraft(
      ingredientId: item.ingredientId,
      ingredientName: item.ingredientName,
      category: item.category,
      amount: item.amount,
      unit: item.unit,
      reaction: item.reaction,
      hasAllergy: item.hasAllergy,
      memo: item.memo,
    );
  }

  /// ドメインエンティティに変換
  BabyFoodItem toItem() {
    return BabyFoodItem(
      ingredientId: ingredientId,
      ingredientName: ingredientName,
      category: category,
      amount: amount,
      unit: amount != null ? unit : null,
      reaction: reaction,
      hasAllergy: hasAllergy,
      memo: memo,
    );
  }

  /// 量の表示文字列
  String? get amountDisplay {
    if (amount == null || unit == null) return null;
    final formattedAmount = amount == amount!.truncate()
        ? amount!.truncate().toString()
        : amount.toString();
    return '$formattedAmount${unit!.shortLabel}';
  }
}
