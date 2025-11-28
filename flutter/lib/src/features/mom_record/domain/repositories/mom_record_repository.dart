import '../entities/mom_daily_record.dart';
import '../entities/mom_monthly_records.dart';

abstract class MomRecordRepository {
  /// 月間記録を一度だけ取得（リアルタイム更新なし）
  Future<MomMonthlyRecords> fetchMonthlyRecords({
    required int year,
    required int month,
  });

  /// 特定の日付の記録をリアルタイムで監視
  Stream<MomDailyRecord> watchRecordForDate({
    required DateTime date,
  });

  Future<void> saveRecord(MomDailyRecord record);
}
