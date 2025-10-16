import '../../child_record.dart';

class DeleteRecord {
  const DeleteRecord(this.repository);

  final ChildRecordRepository repository;

  Future<void> call(String childId, String id) {
    return repository.deleteRecord(childId, id);
  }
}
