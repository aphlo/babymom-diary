import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../application/usecases/add_growth_record.dart';
import '../../../application/usecases/delete_growth_record.dart';
import '../../../application/usecases/get_growth_curves.dart';
import '../../../application/usecases/update_growth_record.dart';
import '../../../application/usecases/watch_growth_records.dart';
import '../../../domain/repositories/growth_curve_repository.dart';
import '../../../domain/repositories/growth_record_repository.dart';
import '../../../infrastructure/repositories/growth_curve_repository_impl.dart';
import '../../../infrastructure/repositories/growth_record_repository_impl.dart';
import '../../../infrastructure/sources/asset_growth_curve_data_source.dart';
import '../../../infrastructure/sources/growth_record_firestore_data_source.dart';

part 'growth_chart_providers.g.dart';

// ─────────────────────────────────────────────────────────────
// Growth Curve (アセットからの成長曲線データ)
// ─────────────────────────────────────────────────────────────

@riverpod
GrowthCurveRepository growthCurveRepository(Ref ref) {
  final dataSource = AssetGrowthCurveDataSource();
  return GrowthCurveRepositoryImpl(assetDataSource: dataSource);
}

@riverpod
GetGrowthCurves getGrowthCurvesUseCase(Ref ref) {
  final repo = ref.watch(growthCurveRepositoryProvider);
  return GetGrowthCurves(repo);
}

// ─────────────────────────────────────────────────────────────
// Growth Record (Firestoreからの成長記録データ)
// ─────────────────────────────────────────────────────────────

@riverpod
GrowthRecordRepository growthRecordRepository(Ref ref, String householdId) {
  final dataSource =
      GrowthRecordFirestoreDataSource(FirebaseFirestore.instance, householdId);
  return GrowthRecordRepositoryImpl(remote: dataSource);
}

@riverpod
WatchGrowthRecords watchGrowthRecordsUseCase(Ref ref, String householdId) {
  final repo = ref.watch(growthRecordRepositoryProvider(householdId));
  return WatchGrowthRecords(repo);
}

@riverpod
AddGrowthRecord addGrowthRecordUseCase(Ref ref, String householdId) {
  final repo = ref.watch(growthRecordRepositoryProvider(householdId));
  return AddGrowthRecord(repo);
}

@riverpod
UpdateGrowthRecord updateGrowthRecordUseCase(Ref ref, String householdId) {
  final repo = ref.watch(growthRecordRepositoryProvider(householdId));
  return UpdateGrowthRecord(repo);
}

@riverpod
DeleteGrowthRecord deleteGrowthRecordUseCase(Ref ref, String householdId) {
  final repo = ref.watch(growthRecordRepositoryProvider(householdId));
  return DeleteGrowthRecord(repo);
}
