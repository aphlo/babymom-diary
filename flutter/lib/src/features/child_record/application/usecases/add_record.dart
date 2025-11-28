import '../../domain/entities/record.dart';
import '../../domain/repositories/child_record_repository.dart';

class AddRecord {
  const AddRecord(this._repository);

  final ChildRecordRepository _repository;

  Future<void> call({
    required String childId,
    required Record record,
  }) {
    return _repository.addRecord(childId, record);
  }
}
