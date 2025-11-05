import '../../domain/entities/vaccine_visibility_settings.dart';
import '../../domain/repositories/vaccine_visibility_settings_repository.dart';

/// ワクチン表示設定を更新するユースケース
class UpdateVaccineVisibilitySettings {
  UpdateVaccineVisibilitySettings({
    required VaccineVisibilitySettingsRepository repository,
  }) : _repository = repository;

  final VaccineVisibilitySettingsRepository _repository;

  Future<void> call({
    required VaccineVisibilitySettings settings,
  }) async {
    await _repository.updateSettings(settings: settings);
  }
}
