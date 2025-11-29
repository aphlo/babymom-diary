import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart'
    as fbcore;

import '../domain/repositories/mom_diary_repository.dart';
import '../domain/repositories/mom_record_repository.dart';
import '../infrastructure/repositories/mom_diary_repository_impl.dart';
import '../infrastructure/repositories/mom_record_repository_impl.dart';
import '../infrastructure/sources/mom_diary_firestore_data_source.dart';
import '../infrastructure/sources/mom_record_firestore_data_source.dart';
import 'usecases/get_mom_diary_monthly_entries.dart';
import 'usecases/get_mom_monthly_records.dart';
import 'usecases/save_mom_daily_record.dart';
import 'usecases/save_mom_diary_entry.dart';

part 'mom_record_controller.g.dart';

@Riverpod(keepAlive: true)
MomRecordFirestoreDataSource momRecordFirestoreDataSource(
  Ref ref,
  String householdId,
) {
  final firestore = ref.watch(fbcore.firebaseFirestoreProvider);
  return MomRecordFirestoreDataSource(
    firestore: firestore,
    householdId: householdId,
  );
}

@Riverpod(keepAlive: true)
MomRecordRepository momRecordRepository(
  Ref ref,
  String householdId,
) {
  final remote = ref.watch(momRecordFirestoreDataSourceProvider(householdId));
  return MomRecordRepositoryImpl(remote: remote);
}

@Riverpod(keepAlive: true)
GetMomMonthlyRecords getMomMonthlyRecordsUseCase(
  Ref ref,
  String householdId,
) {
  final repository = ref.watch(momRecordRepositoryProvider(householdId));
  return GetMomMonthlyRecords(repository);
}

@Riverpod(keepAlive: true)
WatchMomRecordForDate watchMomRecordForDateUseCase(
  Ref ref,
  String householdId,
) {
  final repository = ref.watch(momRecordRepositoryProvider(householdId));
  return WatchMomRecordForDate(repository);
}

@Riverpod(keepAlive: true)
SaveMomDailyRecord saveMomDailyRecordUseCase(
  Ref ref,
  String householdId,
) {
  final repository = ref.watch(momRecordRepositoryProvider(householdId));
  return SaveMomDailyRecord(repository);
}

@Riverpod(keepAlive: true)
MomDiaryFirestoreDataSource momDiaryFirestoreDataSource(
  Ref ref,
  String householdId,
) {
  final firestore = ref.watch(fbcore.firebaseFirestoreProvider);
  return MomDiaryFirestoreDataSource(
    firestore: firestore,
    householdId: householdId,
  );
}

@Riverpod(keepAlive: true)
MomDiaryRepository momDiaryRepository(
  Ref ref,
  String householdId,
) {
  final remote = ref.watch(momDiaryFirestoreDataSourceProvider(householdId));
  return MomDiaryRepositoryImpl(remote: remote);
}

@Riverpod(keepAlive: true)
GetMomDiaryMonthlyEntries getMomDiaryMonthlyEntriesUseCase(
  Ref ref,
  String householdId,
) {
  final repository = ref.watch(momDiaryRepositoryProvider(householdId));
  return GetMomDiaryMonthlyEntries(repository);
}

@Riverpod(keepAlive: true)
WatchMomDiaryForDate watchMomDiaryForDateUseCase(
  Ref ref,
  String householdId,
) {
  final repository = ref.watch(momDiaryRepositoryProvider(householdId));
  return WatchMomDiaryForDate(repository);
}

@Riverpod(keepAlive: true)
SaveMomDiaryEntry saveMomDiaryEntryUseCase(
  Ref ref,
  String householdId,
) {
  final repository = ref.watch(momDiaryRepositoryProvider(householdId));
  return SaveMomDiaryEntry(repository);
}
