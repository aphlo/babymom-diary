import '../../child_record.dart';
import '../sources/record_firestore_data_source.dart';

class ChildRecordRepositoryImpl implements ChildRecordRepository {
  final RecordFirestoreDataSource remote;

  ChildRecordRepositoryImpl({required this.remote});

  @override
  Future<void> addRecord(String childId, Record record) async =>
      remote.upsert(childId, record);

  @override
  Future<void> deleteRecord(String childId, String id) async =>
      remote.delete(childId, id);

  @override
  Future<List<Record>> getRecordsForDay(String childId, DateTime day) async =>
      remote.getForDay(childId, day);
}
