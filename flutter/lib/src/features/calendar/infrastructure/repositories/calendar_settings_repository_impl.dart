import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:babymom_diary/src/core/preferences/shared_preferences_provider.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:babymom_diary/src/features/calendar/domain/repositories/calendar_settings_repository.dart';

part 'calendar_settings_repository_impl.g.dart';

/// SharedPreferencesを使ったカレンダー設定リポジトリの実装
class CalendarSettingsRepositoryImpl implements CalendarSettingsRepository {
  CalendarSettingsRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyStartingDayOfWeek = 'calendar_starting_day_of_week';

  final StreamController<CalendarSettings> _settingsController =
      StreamController<CalendarSettings>.broadcast();

  @override
  Future<CalendarSettings> getSettings() async {
    final startingDayOfWeek =
        _prefs.getBool(_keyStartingDayOfWeek) ?? false; // デフォルトは日曜始まり
    return CalendarSettings(startingDayOfWeek: startingDayOfWeek);
  }

  @override
  Future<void> saveSettings(CalendarSettings settings) async {
    await _prefs.setBool(_keyStartingDayOfWeek, settings.startingDayOfWeek);
    _settingsController.add(settings);
  }

  @override
  Stream<CalendarSettings> watchSettings() {
    // 初期値を送信
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
CalendarSettingsRepository calendarSettingsRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return CalendarSettingsRepositoryImpl(prefs);
}
