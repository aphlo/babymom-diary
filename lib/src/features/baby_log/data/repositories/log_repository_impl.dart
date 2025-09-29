import '../../baby_log.dart';
import '../sources/log_firestore_data_source.dart';

class LogRepositoryImpl implements LogRepository {
  final LogFirestoreDataSource remote;

  LogRepositoryImpl({required this.remote});

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
