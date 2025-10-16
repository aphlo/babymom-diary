import '../../child_record.dart';

class GetRecordsForDay {
  final ChildRecordRepository repo;
  GetRecordsForDay(this.repo);
  Future<List<Record>> call(String childId, DateTime day) =>
      repo.getRecordsForDay(childId, day);
}
