import '../../baby_log.dart';

class GetRecordsForDay {
  final LogRepository repo;
  GetRecordsForDay(this.repo);
  Future<List<Record>> call(DateTime day) => repo.getRecordsForDay(day);
}
