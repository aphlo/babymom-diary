import '../../domain/entities/mom_monthly_records.dart';
import '../../domain/repositories/mom_record_repository.dart';

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

/// リアルタイム更新用のUseCase
class WatchMomMonthlyRecords {
  const WatchMomMonthlyRecords(this._repository);

  final MomRecordRepository _repository;

  Stream<MomMonthlyRecords> call({
    required int year,
    required int month,
  }) {
    return _repository.watchMonthlyRecords(year: year, month: month);
  }
}
