import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:babymom_diary/src/features/calendar/domain/repositories/calendar_settings_repository.dart';
import 'package:babymom_diary/src/features/calendar/infrastructure/repositories/calendar_settings_repository_impl.dart';

import 'calendar_settings_state.dart';

part 'calendar_settings_view_model.g.dart';

@Riverpod(keepAlive: true)
class CalendarSettingsViewModel extends _$CalendarSettingsViewModel {
  CalendarSettingsRepository? _repository;

  @override
  CalendarSettingsState build() {
    _repository = ref.watch(calendarSettingsRepositoryProvider);

    final initialState = const CalendarSettingsState(
      settings: CalendarSettings(startingDayOfWeek: false),
    );

    // 初期化処理をスケジュール
    Future.microtask(() => _loadSettings());

    return initialState;
  }

  Future<void> _loadSettings() async {
    final repository = _repository;
    if (repository == null) return;

    try {
      state = state.copyWith(isLoading: true, error: null);
      final settings = await repository.getSettings();
      state = state.copyWith(settings: settings, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '設定の読み込みに失敗しました: $e',
      );
    }
  }

  Future<void> updateStartingDayOfWeek(bool startingDayOfWeek) async {
    final repository = _repository;
    if (repository == null) return;

    try {
      state = state.copyWith(isLoading: true, error: null);
      final newSettings = state.settings.copyWith(
        startingDayOfWeek: startingDayOfWeek,
      );
      await repository.saveSettings(newSettings);
      state = state.copyWith(settings: newSettings, isLoading: false);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '設定の保存に失敗しました: $e',
      );
    }
  }
}
