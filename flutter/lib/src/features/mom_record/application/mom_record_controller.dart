import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final _momRecordFirestoreDataSourceProvider =
    Provider.family<MomRecordFirestoreDataSource, String>((ref, householdId) {
  final firestore = ref.watch(fbcore.firebaseFirestoreProvider);
  return MomRecordFirestoreDataSource(
    firestore: firestore,
    householdId: householdId,
  );
});

final momRecordRepositoryProvider =
    Provider.family<MomRecordRepository, String>((ref, householdId) {
  final remote = ref.watch(_momRecordFirestoreDataSourceProvider(householdId));
  return MomRecordRepositoryImpl(remote: remote);
});

final getMomMonthlyRecordsUseCaseProvider =
    Provider.family<GetMomMonthlyRecords, String>((ref, householdId) {
  final repository = ref.watch(momRecordRepositoryProvider(householdId));
  return GetMomMonthlyRecords(repository);
});

final watchMomMonthlyRecordsUseCaseProvider =
    Provider.family<WatchMomMonthlyRecords, String>((ref, householdId) {
  final repository = ref.watch(momRecordRepositoryProvider(householdId));
  return WatchMomMonthlyRecords(repository);
});

final saveMomDailyRecordUseCaseProvider =
    Provider.family<SaveMomDailyRecord, String>((ref, householdId) {
  final repository = ref.watch(momRecordRepositoryProvider(householdId));
  return SaveMomDailyRecord(repository);
});

final _momDiaryFirestoreDataSourceProvider =
    Provider.family<MomDiaryFirestoreDataSource, String>((ref, householdId) {
  final firestore = ref.watch(fbcore.firebaseFirestoreProvider);
  return MomDiaryFirestoreDataSource(
    firestore: firestore,
    householdId: householdId,
  );
});

final momDiaryRepositoryProvider =
    Provider.family<MomDiaryRepository, String>((ref, householdId) {
  final remote = ref.watch(_momDiaryFirestoreDataSourceProvider(householdId));
  return MomDiaryRepositoryImpl(remote: remote);
});

final getMomDiaryMonthlyEntriesUseCaseProvider =
    Provider.family<GetMomDiaryMonthlyEntries, String>((ref, householdId) {
  final repository = ref.watch(momDiaryRepositoryProvider(householdId));
  return GetMomDiaryMonthlyEntries(repository);
});

final watchMomDiaryMonthlyEntriesUseCaseProvider =
    Provider.family<WatchMomDiaryMonthlyEntries, String>((ref, householdId) {
  final repository = ref.watch(momDiaryRepositoryProvider(householdId));
  return WatchMomDiaryMonthlyEntries(repository);
});

final saveMomDiaryEntryUseCaseProvider =
    Provider.family<SaveMomDiaryEntry, String>((ref, householdId) {
  final repository = ref.watch(momDiaryRepositoryProvider(householdId));
  return SaveMomDiaryEntry(repository);
});
