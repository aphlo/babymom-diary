import '../../child_record.dart';

class AddRecord {
  final ChildRecordRepository repo;
  AddRecord(this.repo);
  Future<void> call(String childId, Record record) =>
      repo.addRecord(childId, record);
}
