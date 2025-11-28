import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/household_service.dart' as fbcore;
import '../../infrastructure/sources/record_firestore_data_source.dart';
import '../mappers/record_ui_mapper.dart';
import '../models/record_item_model.dart';

/// 日別の記録を取得するためのクエリパラメータ
@immutable
class DailyRecordsQuery {
  const DailyRecordsQuery({
    required this.householdId,
    required this.childId,
    required this.date,
  });

  final String householdId;
  final String childId;
  final DateTime date;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyRecordsQuery &&
          runtimeType == other.runtimeType &&
          householdId == other.householdId &&
          childId == other.childId &&
          date.year == other.date.year &&
          date.month == other.date.month &&
          date.day == other.date.day;

  @override
  int get hashCode => Object.hash(
        householdId,
        childId,
        DateTime(date.year, date.month, date.day),
      );
}

/// 日別の記録をリアルタイムで取得する StreamProvider
///
/// [DailyRecordsQuery] で指定された householdId, childId, date に基づいて
/// Firestore から記録を監視し、UI モデルに変換して返す。
///
/// 使用例:
/// ```dart
/// final recordsAsync = ref.watch(dailyRecordsProvider(DailyRecordsQuery(
///   householdId: context.householdId,
///   childId: childId,
///   date: selectedDate,
/// )));
/// ```
final dailyRecordsProvider = StreamProvider.autoDispose
    .family<List<RecordItemModel>, DailyRecordsQuery>((ref, query) {
  final db = ref.watch(fbcore.firebaseFirestoreProvider);
  final dataSource = RecordFirestoreDataSource(db, query.householdId);
  const mapper = RecordUiMapper();

  return dataSource.watchForDay(query.childId, query.date).map(
        (records) => records.map(mapper.toUiModel).toList(),
      );
});
