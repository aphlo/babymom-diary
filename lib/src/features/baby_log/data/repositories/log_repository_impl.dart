import '../../baby_log.dart';
import '../sources/log_firestore_data_source.dart';
import '../sources/log_local_data_source.dart';

class LogRepositoryImpl implements LogRepository {
  final LogFirestoreDataSource? remote;
  final LogLocalDataSource? local;
  
  LogRepositoryImpl({this.remote, this.local});

  @override
  Future<void> addEntry(Entry entry) async {
    if (remote != null) {
      await remote!.upsert(entry);
    } else if (local != null) {
      await local!.upsert(entry);
    }
  }

  @override
  Future<void> deleteEntry(String id) async {
    if (remote != null) {
      await remote!.delete(id);
    } else if (local != null) {
      await local!.delete(id);
    }
  }

  @override
  Future<List<Entry>> getEntriesForDay(DateTime day) async {
    if (remote != null) {
      return remote!.getForDay(day);
    } else if (local != null) {
      return local!.getForDay(day);
    }
    return [];
  }
}