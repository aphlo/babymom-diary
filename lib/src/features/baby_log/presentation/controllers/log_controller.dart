import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../baby_log.dart';
import '../../application/usecases/add_entry.dart';
import '../../application/usecases/get_entries_for_day.dart';
import '../../data/repositories/log_repository_impl.dart';
import '../../data/sources/log_firestore_data_source.dart';
import '../../../../core/firebase/household_service.dart' as fbcore;
import '../controllers/selected_log_date_provider.dart';

// Firestore instance
// Use central Firebase providers from core
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) =>
    ref.watch(fbcore.firebaseFirestoreProvider));

// DI graph (Firestore): data source -> repository -> usecases
final _firestoreDataSourceProvider = Provider.family<LogFirestoreDataSource, String>((ref, hid) {
  final db = ref.watch(firebaseFirestoreProvider);
  return LogFirestoreDataSource(db, hid);
});

final logRepositoryProvider = Provider.family<LogRepository, String>((ref, hid) {
  final remote = ref.watch(_firestoreDataSourceProvider(hid));
  return LogRepositoryImpl(remote: remote);
});

final addEntryUseCaseProvider = Provider.family<AddEntry, String>((ref, hid) =>
    AddEntry(ref.watch(logRepositoryProvider(hid))));
final getEntriesForDayUseCaseProvider =
    Provider.family<GetEntriesForDay, String>((ref, hid) =>
        GetEntriesForDay(ref.watch(logRepositoryProvider(hid))));

class LogController extends AsyncNotifier<List<Entry>> {
  @override
  Future<List<Entry>> build() async {
    final date = ref.watch(selectedLogDateProvider);
    final hid = await ref.read(fbcore.currentHouseholdIdProvider.future);
    final get = ref.read(getEntriesForDayUseCaseProvider(hid));
    return get(date);
  }

  Future<void> refreshSelected() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final date = ref.read(selectedLogDateProvider);
      final hid = await ref.read(fbcore.currentHouseholdIdProvider.future);
      final get = ref.read(getEntriesForDayUseCaseProvider(hid));
      return get(date);
    });
  }

  Future<void> add(Entry entry) async {
    final hid = await ref.read(fbcore.currentHouseholdIdProvider.future);
    final add = ref.read(addEntryUseCaseProvider(hid));
    await add(entry);
    await refreshSelected();
  }
}

final logControllerProvider =
    AsyncNotifierProvider<LogController, List<Entry>>(
  LogController.new,
);
