import '../../domain/entities/mom_daily_record.dart';
import '../../domain/entities/mom_monthly_records.dart';
import '../../domain/repositories/mom_record_repository.dart';

/// 月間記録を一度だけ取得するUseCase
class GetMomMonthlyRecords {
  const GetMomMonthlyRecords(this._repository);

  final MomRecordRepository _repository;

  Future<MomMonthlyRecords> call({
    required int year,
    required int month,
  }) {
    return _repository.fetchMonthlyRecords(year: year, month: month);
  }
}

/// 特定の日付の記録をリアルタイムで監視するUseCase
class WatchMomRecordForDate {
  const WatchMomRecordForDate(this._repository);

  final MomRecordRepository _repository;

  Stream<MomDailyRecord> call({
    required DateTime date,
  }) {
    return _repository.watchRecordForDate(date: date);
  }
}
