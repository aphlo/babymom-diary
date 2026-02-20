import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../feeding_table_settings/domain/entities/feeding_table_settings.dart';
import '../../child_record.dart';
import '../../infrastructure/sources/record_firestore_data_source.dart';
import '../models/weekly_summary_model.dart';

part 'weekly_summary_provider.g.dart';

/// 週間サマリーデータを取得・集計するFutureProvider
@riverpod
Future<WeeklySummaryData> weeklySummary(
  Ref ref,
  WeeklySummaryQuery query,
) async {
  final db = FirebaseFirestore.instance;
  final recordSource = RecordFirestoreDataSource(db, query.householdId);

  final weekStart = DateTime(
    query.weekStart.year,
    query.weekStart.month,
    query.weekStart.day,
  );

  // 日曜〜土曜の7日分の日付リストを生成
  final dates = List.generate(7, (i) => weekStart.add(Duration(days: i)));

  // 7日分のレコードを並列取得
  final recordsByDay = await Future.wait(
    dates.map((d) => recordSource.getForDay(query.childId, d)).toList(),
  );

  // 日ごとに集計
  final days = <DaySummary>[];
  for (var i = 0; i < 7; i++) {
    final records = recordsByDay[i];
    final values = <FeedingTableCategory, CategoryDayValue>{};

    // 授乳
    final nursingCount =
        records.where((r) => r.type == RecordType.breastRight).length +
            records.where((r) => r.type == RecordType.breastLeft).length;
    values[FeedingTableCategory.nursing] =
        CategoryDayValue(count: nursingCount, totalAmount: 0);

    // ミルク
    final formulaRecords =
        records.where((r) => r.type == RecordType.formula).toList();
    final formulaAmount =
        formulaRecords.fold<double>(0, (acc, r) => acc + (r.amount ?? 0));
    values[FeedingTableCategory.formula] = CategoryDayValue(
        count: formulaRecords.length, totalAmount: formulaAmount);

    // 搾母乳
    final pumpRecords =
        records.where((r) => r.type == RecordType.pump).toList();
    final pumpAmount =
        pumpRecords.fold<double>(0, (acc, r) => acc + (r.amount ?? 0));
    values[FeedingTableCategory.pump] =
        CategoryDayValue(count: pumpRecords.length, totalAmount: pumpAmount);

    // 尿
    final peeCount = records.where((r) => r.type == RecordType.pee).length;
    values[FeedingTableCategory.pee] =
        CategoryDayValue(count: peeCount, totalAmount: 0);

    // 便
    final poopCount = records.where((r) => r.type == RecordType.poop).length;
    values[FeedingTableCategory.poop] =
        CategoryDayValue(count: poopCount, totalAmount: 0);

    // 体温（最新の記録を採用）
    final tempRecords =
        records.where((r) => r.type == RecordType.temperature).toList();
    double? latestTemp;
    if (tempRecords.isNotEmpty) {
      tempRecords.sort((a, b) => b.at.compareTo(a.at));
      latestTemp = tempRecords.first.amount;
    }
    values[FeedingTableCategory.temperature] = CategoryDayValue(
      count: tempRecords.length,
      totalAmount: 0,
      latestTemperature: latestTemp,
    );

    days.add(DaySummary(date: dates[i], values: values));
  }

  return WeeklySummaryData(days: days);
}
