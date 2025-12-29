import '../entities/baby_food_record.dart';

/// 離乳食記録のリポジトリインターフェース
abstract class BabyFoodRecordRepository {
  /// 指定した日の離乳食記録を取得
  Future<List<BabyFoodRecord>> getRecordsForDay(String childId, DateTime day);

  /// 指定した日の離乳食記録をストリームで監視
  Stream<List<BabyFoodRecord>> watchRecordsForDay(String childId, DateTime day);

  /// 全ての離乳食記録をストリームで監視
  Stream<List<BabyFoodRecord>> watchAllRecords(String childId);

  /// 離乳食記録を追加
  Future<void> addRecord(String childId, BabyFoodRecord record);

  /// 離乳食記録を更新
  Future<void> updateRecord(String childId, BabyFoodRecord record);

  /// 離乳食記録を削除
  Future<void> deleteRecord(String childId, String recordId);
}
