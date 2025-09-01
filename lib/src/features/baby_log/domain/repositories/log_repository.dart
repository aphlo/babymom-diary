import '../entities/entry.dart';

abstract class LogRepository {
  Future<List<Entry>> getEntriesForDay(DateTime day);
  Future<void> addEntry(Entry entry);
  Future<void> deleteEntry(String id);
}