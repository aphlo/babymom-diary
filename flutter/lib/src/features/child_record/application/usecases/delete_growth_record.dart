import '../../child_record.dart';

class DeleteGrowthRecord {
  const DeleteGrowthRecord(this._repository);

  final GrowthRecordRepository _repository;

  Future<void> call({
    required String childId,
    required String recordId,
  }) {
    return _repository.deleteRecord(childId, recordId);
  }
}
