import '../../domain/repositories/child_record_repository.dart';

class DeleteRecord {
  const DeleteRecord(this._repository);

  final ChildRecordRepository _repository;

  Future<void> call({
    required String childId,
    required String id,
  }) {
    return _repository.deleteRecord(childId, id);
  }
}
