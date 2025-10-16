import '../entities/record.dart';

abstract class ChildRecordRepository {
  Future<List<Record>> getRecordsForDay(String childId, DateTime day);
  Future<void> addRecord(String childId, Record record);
  Future<void> deleteRecord(String childId, String id);
}
