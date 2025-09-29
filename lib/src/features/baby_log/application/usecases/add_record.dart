import '../../baby_log.dart';

class AddRecord {
  final LogRepository repo;
  AddRecord(this.repo);
  Future<void> call(Record record) => repo.addRecord(record);
}
