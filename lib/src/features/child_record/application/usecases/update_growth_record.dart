import '../../child_record.dart';

class UpdateGrowthRecord {
  const UpdateGrowthRecord(this._repository);

  final GrowthRecordRepository _repository;

  Future<GrowthRecord> call(GrowthRecord record) {
    return _repository.updateRecord(record: record);
  }
}
