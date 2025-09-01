import '../../baby_log.dart';

class GetEntriesForDay {
  final LogRepository repo;
  GetEntriesForDay(this.repo);
  Future<List<Entry>> call(DateTime day) => repo.getEntriesForDay(day);
}