import '../../child_record.dart';

class AddGrowthRecord {
  const AddGrowthRecord(this._repository);

  final GrowthRecordRepository _repository;

  Future<GrowthRecord> call(GrowthRecord record) {
    return _repository.addRecord(record: record);
  }
}
