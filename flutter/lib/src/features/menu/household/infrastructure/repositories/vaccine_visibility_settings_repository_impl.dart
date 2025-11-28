import '../../domain/entities/vaccine_visibility_settings.dart';
import '../../domain/repositories/vaccine_visibility_settings_repository.dart';
import '../sources/vaccine_visibility_settings_firestore_data_source.dart';

/// ワクチン表示設定リポジトリの実装
class VaccineVisibilitySettingsRepositoryImpl
    implements VaccineVisibilitySettingsRepository {
  VaccineVisibilitySettingsRepositoryImpl({
    required VaccineVisibilitySettingsFirestoreDataSource dataSource,
  }) : _dataSource = dataSource;

  final VaccineVisibilitySettingsFirestoreDataSource _dataSource;

  @override
  Future<VaccineVisibilitySettings> getSettings({
    required String householdId,
  }) async {
    final visibilityMap = await _dataSource.getSettings(
      householdId: householdId,
    );

    return VaccineVisibilitySettings(
      householdId: householdId,
      visibilityMap: visibilityMap,
    );
  }

  @override
  Future<void> updateSettings({
    required VaccineVisibilitySettings settings,
  }) async {
    await _dataSource.updateSettings(
      householdId: settings.householdId,
      visibilityMap: settings.visibilityMap,
    );
  }
}
