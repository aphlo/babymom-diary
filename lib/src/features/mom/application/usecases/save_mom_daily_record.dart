import '../../domain/entities/mom_daily_record.dart';
import '../../domain/repositories/mom_record_repository.dart';

class SaveMomDailyRecord {
  const SaveMomDailyRecord(this._repository);

  final MomRecordRepository _repository;

  Future<void> call(MomDailyRecord record) {
    return _repository.saveRecord(record);
  }
}
