import 'package:flutter/foundation.dart';

import '../../../feeding_table_settings/domain/entities/feeding_table_settings.dart';

/// 週間サマリー取得のためのクエリパラメータ
@immutable
class WeeklySummaryQuery {
  const WeeklySummaryQuery({
    required this.householdId,
    required this.childId,
    required this.weekStart,
  });

  final String householdId;
  final String childId;

  /// 週の開始日（日曜日）
  final DateTime weekStart;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WeeklySummaryQuery &&
          runtimeType == other.runtimeType &&
          householdId == other.householdId &&
          childId == other.childId &&
          weekStart.year == other.weekStart.year &&
          weekStart.month == other.weekStart.month &&
          weekStart.day == other.weekStart.day;

  @override
  int get hashCode => Object.hash(
        householdId,
        childId,
        DateTime(weekStart.year, weekStart.month, weekStart.day),
      );
}

/// カテゴリ×日の集計値
@immutable
class CategoryDayValue {
  const CategoryDayValue({
    required this.count,
    required this.totalAmount,
    this.latestTemperature,
  });

  static const zero = CategoryDayValue(count: 0, totalAmount: 0);

  /// 回数
  final int count;

  /// 合計量（ml等）
  final double totalAmount;

  /// その日の最新体温（℃）。体温カテゴリでのみ使用。
  final double? latestTemperature;
}

/// 1日分のサマリー
@immutable
class DaySummary {
  const DaySummary({
    required this.date,
    required this.values,
  });

  final DateTime date;
  final Map<FeedingTableCategory, CategoryDayValue> values;
}

/// 週間サマリーデータ（7日分、日曜始まり）
@immutable
class WeeklySummaryData {
  const WeeklySummaryData({required this.days});

  final List<DaySummary> days;

  DateTime get startDate => days.first.date;
  DateTime get endDate => days.last.date;

  /// 日曜始まりの週の開始日を計算
  static DateTime sundayStartOfWeek(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);
    final offset = normalized.weekday % 7; // 日=0, 月=1, …, 土=6
    return normalized.subtract(Duration(days: offset));
  }
}
