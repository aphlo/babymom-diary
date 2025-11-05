import '../../domain/entities/vaccine_visibility_settings.dart';
import '../../domain/repositories/vaccine_visibility_settings_repository.dart';

/// ワクチン表示設定を取得するユースケース
class GetVaccineVisibilitySettings {
  GetVaccineVisibilitySettings({
    required VaccineVisibilitySettingsRepository repository,
  }) : _repository = repository;

  final VaccineVisibilitySettingsRepository _repository;

  Future<VaccineVisibilitySettings> call({
    required String householdId,
  }) async {
    return await _repository.getSettings(householdId: householdId);
  }
}
