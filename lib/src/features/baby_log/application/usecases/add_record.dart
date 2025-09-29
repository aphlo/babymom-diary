import '../../baby_log.dart';

class AddRecord {
  final LogRepository repo;
  AddRecord(this.repo);
  Future<void> call(String childId, Record record) =>
      repo.addRecord(childId, record);
}
