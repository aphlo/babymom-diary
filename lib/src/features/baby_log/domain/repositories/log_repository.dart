import '../entities/record.dart';

abstract class LogRepository {
  Future<List<Record>> getRecordsForDay(DateTime day);
  Future<void> addRecord(Record record);
  Future<void> deleteRecord(String id);
}
