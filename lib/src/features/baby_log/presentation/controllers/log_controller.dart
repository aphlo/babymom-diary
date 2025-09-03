import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../baby_log.dart';
import '../../application/usecases/add_entry.dart';
import '../../application/usecases/get_entries_for_day.dart';
import '../../data/repositories/log_repository_impl.dart';
import '../../data/sources/log_local_data_source.dart';

// Firestore instance
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

// DI graph (Firestore): data source -> repository -> usecases
// final _firestoreDataSourceProvider = Provider((ref) {
//   final db = ref.watch(firebaseFirestoreProvider);
//   return LogFirestoreDataSource(db);
// });

final _localDataSourceProvider = Provider((ref) => LogLocalDataSource());

final logRepositoryProvider = Provider<LogRepository>((ref) {
  // Use local data source for now (can switch to Firestore later)
  final local = ref.watch(_localDataSourceProvider);
  return LogRepositoryImpl(local: local);
});

final addEntryUseCaseProvider =
    Provider((ref) => AddEntry(ref.watch(logRepositoryProvider)));
final getEntriesForDayUseCaseProvider =
    Provider((ref) => GetEntriesForDay(ref.watch(logRepositoryProvider)));

class LogController extends AsyncNotifier<List<Entry>> {
  @override
  Future<List<Entry>> build() async {
    final get = ref.read(getEntriesForDayUseCaseProvider);
    return get(DateTime.now());
  }

  Future<void> refreshToday() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final get = ref.read(getEntriesForDayUseCaseProvider);
      return get(DateTime.now());
    });
  }

  Future<void> add(Entry entry) async {
    final add = ref.read(addEntryUseCaseProvider);
    await add(entry);
    await refreshToday();
  }
}

final logControllerProvider =
    AsyncNotifierProvider<LogController, List<Entry>>(
  LogController.new,
);
