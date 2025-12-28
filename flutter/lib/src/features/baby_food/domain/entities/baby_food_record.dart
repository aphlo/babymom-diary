import 'package:freezed_annotation/freezed_annotation.dart';

import 'baby_food_item.dart';

part 'baby_food_record.freezed.dart';

/// 離乳食の記録
@freezed
sealed class BabyFoodRecord with _$BabyFoodRecord {
  const BabyFoodRecord._();

  const factory BabyFoodRecord({
    /// 記録ID
    required String id,

    /// 記録日時
    required DateTime recordedAt,

    /// 食べた食材リスト
    required List<BabyFoodItem> items,

    /// メモ（任意）
    String? note,

    /// 作成日時
    required DateTime createdAt,

    /// 更新日時
    required DateTime updatedAt,
  }) = _BabyFoodRecord;

  /// 記録されている食材の数
  int get itemCount => items.length;

  /// 食材名のサマリー（例: "米, にんじん, 豆腐"）
  String get itemsSummary {
    if (items.isEmpty) return '';
    return items.map((item) => item.ingredientName).join(', ');
  }

  /// 食材名のサマリー（省略版、最大3件）
  String get itemsSummaryShort {
    if (items.isEmpty) return '';
    if (items.length <= 3) {
      return items.map((item) => item.ingredientName).join(', ');
    }
    final first3 = items.take(3).map((item) => item.ingredientName).join(', ');
    return '$first3 他${items.length - 3}件';
  }
}

/// BabyFoodRecordのIDを生成する
String generateBabyFoodRecordId({
  required String childId,
  required DateTime recordedAt,
}) {
  final datePart =
      '${recordedAt.year.toString().padLeft(4, '0')}-${recordedAt.month.toString().padLeft(2, '0')}-${recordedAt.day.toString().padLeft(2, '0')}';
  final timePart =
      '${recordedAt.hour.toString().padLeft(2, '0')}${recordedAt.minute.toString().padLeft(2, '0')}';
  final randomPart =
      DateTime.now().microsecondsSinceEpoch.toRadixString(36).padLeft(8, '0');
  return 'babyfood-$datePart-$timePart-$randomPart';
}
