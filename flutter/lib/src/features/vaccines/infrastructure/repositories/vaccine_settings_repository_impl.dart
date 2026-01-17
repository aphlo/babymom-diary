import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:babymom_diary/src/core/preferences/shared_preferences_provider.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_settings.dart';
import 'package:babymom_diary/src/features/vaccines/domain/repositories/vaccine_settings_repository.dart';

part 'vaccine_settings_repository_impl.g.dart';

class VaccineSettingsRepositoryImpl implements VaccineSettingsRepository {
  VaccineSettingsRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyViewMode = 'vaccine_view_mode';

  final StreamController<VaccineSettings> _settingsController =
      StreamController<VaccineSettings>.broadcast();

  @override
  Future<VaccineSettings> getSettings() async {
    final viewModeIndex = _prefs.getInt(_keyViewMode);
    final viewMode = viewModeIndex != null
        ? VaccineViewMode.values[viewModeIndex]
        : VaccineViewMode.table;
    return VaccineSettings(viewMode: viewMode);
  }

  @override
  Future<void> saveSettings(VaccineSettings settings) async {
    await _prefs.setInt(_keyViewMode, settings.viewMode.index);
    _settingsController.add(settings);
  }

  @override
  Stream<VaccineSettings> watchSettings() {
    getSettings().then((settings) {
      if (!_settingsController.isClosed) {
        _settingsController.add(settings);
      }
    });
    return _settingsController.stream;
  }

  void dispose() {
    _settingsController.close();
  }
}

@Riverpod(keepAlive: true)
VaccineSettingsRepository vaccineSettingsRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return VaccineSettingsRepositoryImpl(prefs);
}
