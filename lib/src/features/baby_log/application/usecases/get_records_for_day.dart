import '../../baby_log.dart';

class GetRecordsForDay {
  final LogRepository repo;
  GetRecordsForDay(this.repo);
  Future<List<Record>> call(String childId, DateTime day) =>
      repo.getRecordsForDay(childId, day);
}
