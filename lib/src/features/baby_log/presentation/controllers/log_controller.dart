import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../baby_log.dart';
import '../../application/usecases/add_record.dart';
import '../../application/usecases/get_records_for_day.dart';
import '../../data/repositories/log_repository_impl.dart';
import '../../data/sources/log_firestore_data_source.dart';
import '../../../children/application/selected_child_provider.dart';
import '../../../children/data/sources/child_firestore_data_source.dart';
import '../../../../core/firebase/household_service.dart' as fbcore;
import '../controllers/selected_log_date_provider.dart';

// Firestore instance
// Use central Firebase providers from core
final firebaseFirestoreProvider = Provider<FirebaseFirestore>(
    (ref) => ref.watch(fbcore.firebaseFirestoreProvider));

// DI graph (Firestore): data source -> repository -> usecases
final _firestoreDataSourceProvider =
    Provider.family<LogFirestoreDataSource, String>((ref, hid) {
  final db = ref.watch(firebaseFirestoreProvider);
  return LogFirestoreDataSource(db, hid);
});

final logRepositoryProvider =
    Provider.family<LogRepository, String>((ref, hid) {
  final remote = ref.watch(_firestoreDataSourceProvider(hid));
  return LogRepositoryImpl(remote: remote);
});

final addRecordUseCaseProvider = Provider.family<AddRecord, String>(
    (ref, hid) => AddRecord(ref.watch(logRepositoryProvider(hid))));
final getRecordsForDayUseCaseProvider =
    Provider.family<GetRecordsForDay, String>(
        (ref, hid) => GetRecordsForDay(ref.watch(logRepositoryProvider(hid))));

class LogController extends AsyncNotifier<List<Record>> {
  Future<String?> _ensureActiveChildId({
    required String householdId,
    required bool watchSelected,
  }) async {
    final selected = watchSelected
        ? await ref.watch(selectedChildControllerProvider.future)
        : await ref.read(selectedChildControllerProvider.future);
    if (selected != null && selected.isNotEmpty) {
      return selected;
    }

    final ds = ChildFirestoreDataSource(
      ref.read(firebaseFirestoreProvider),
      householdId,
    );
    final snap = await ds.childrenQuery().limit(1).get();
    if (snap.docs.isEmpty) {
      return null;
    }
    final firstId = snap.docs.first.id;
    await ref.read(selectedChildControllerProvider.notifier).select(firstId);
    return firstId;
  }

  @override
  Future<List<Record>> build() async {
    final date = ref.watch(selectedLogDateProvider);
    final hid = await ref.read(fbcore.currentHouseholdIdProvider.future);
    final childId = await _ensureActiveChildId(
      householdId: hid,
      watchSelected: true,
    );
    if (childId == null) {
      return const [];
    }
    final get = ref.read(getRecordsForDayUseCaseProvider(hid));
    return get(childId, date);
  }

  Future<void> refreshSelected() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final date = ref.read(selectedLogDateProvider);
      final hid = await ref.read(fbcore.currentHouseholdIdProvider.future);
      final childId = await _ensureActiveChildId(
        householdId: hid,
        watchSelected: false,
      );
      if (childId == null) {
        return const <Record>[];
      }
      final get = ref.read(getRecordsForDayUseCaseProvider(hid));
      return get(childId, date);
    });
  }

  Future<void> addRecord(Record record) async {
    final hid = await ref.read(fbcore.currentHouseholdIdProvider.future);
    final childId = await _ensureActiveChildId(
      householdId: hid,
      watchSelected: false,
    );
    if (childId == null) {
      throw StateError('子どもが登録されていません');
    }
    final add = ref.read(addRecordUseCaseProvider(hid));
    await add(childId, record);
    await refreshSelected();
  }
}

final logControllerProvider =
    AsyncNotifierProvider<LogController, List<Record>>(
  LogController.new,
);
