import '../entities/mom_daily_record.dart';
import '../entities/mom_monthly_records.dart';

abstract class MomRecordRepository {
  Future<MomMonthlyRecords> fetchMonthlyRecords({
    required int year,
    required int month,
  });

  Future<void> saveRecord(MomDailyRecord record);
}
