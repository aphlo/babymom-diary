import '../../baby_log.dart';
import '../sources/log_firestore_data_source.dart';

class LogRepositoryImpl implements LogRepository {
  final LogFirestoreDataSource remote;

  LogRepositoryImpl({required this.remote});

  @override
  Future<void> addEntry(Entry entry) async => remote.upsert(entry);

  @override
  Future<void> deleteEntry(String id) async => remote.delete(id);

  @override
  Future<List<Entry>> getEntriesForDay(DateTime day) async =>
      remote.getForDay(day);
}
