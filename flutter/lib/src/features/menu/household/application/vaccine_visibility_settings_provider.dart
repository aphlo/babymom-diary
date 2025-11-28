import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import '../domain/repositories/vaccine_visibility_settings_repository.dart';
import '../infrastructure/repositories/vaccine_visibility_settings_repository_impl.dart';
import '../infrastructure/sources/vaccine_visibility_settings_firestore_data_source.dart';

/// ワクチン表示設定リポジトリのプロバイダー
final vaccineVisibilitySettingsRepositoryProvider =
    Provider<VaccineVisibilitySettingsRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final dataSource = VaccineVisibilitySettingsFirestoreDataSource(firestore);
  return VaccineVisibilitySettingsRepositoryImpl(dataSource: dataSource);
});
