import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_settings.dart';

abstract class VaccineSettingsRepository {
  Future<VaccineSettings> getSettings();
  Future<void> saveSettings(VaccineSettings settings);
  Stream<VaccineSettings> watchSettings();
}
