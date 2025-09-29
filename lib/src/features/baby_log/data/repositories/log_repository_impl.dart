import '../../baby_log.dart';
import '../sources/log_firestore_data_source.dart';

class LogRepositoryImpl implements LogRepository {
  final LogFirestoreDataSource remote;

  LogRepositoryImpl({required this.remote});

  @override
  Future<void> addRecord(Record record) async => remote.upsert(record);

  @override
  Future<void> deleteRecord(String id) async => remote.delete(id);

  @override
  Future<List<Record>> getRecordsForDay(DateTime day) async =>
      remote.getForDay(day);
}
