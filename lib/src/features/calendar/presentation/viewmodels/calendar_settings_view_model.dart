import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:babymom_diary/src/features/calendar/domain/repositories/calendar_settings_repository.dart';
import 'package:babymom_diary/src/features/calendar/infrastructure/repositories/calendar_settings_repository_impl.dart';

/// カレンダー設定画面の状態
class CalendarSettingsState {
  const CalendarSettingsState({
    required this.settings,
    this.isLoading = false,
    this.error,
  });

  final CalendarSettings settings;
  final bool isLoading;
  final String? error;

  CalendarSettingsState copyWith({
    CalendarSettings? settings,
    bool? isLoading,
    String? error,
  }) {
    return CalendarSettingsState(
      settings: settings ?? this.settings,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// カレンダー設定画面のViewModel
class CalendarSettingsViewModel extends StateNotifier<CalendarSettingsState> {
  CalendarSettingsViewModel(this._repository)
      : super(const CalendarSettingsState(
          settings: CalendarSettings(startingDayOfWeek: false),
        )) {
    _loadSettings();
  }

  final CalendarSettingsRepository _repository;

  Future<void> _loadSettings() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final settings = await _repository.getSettings();
      if (!mounted) return;
      state = state.copyWith(settings: settings, isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: '設定の読み込みに失敗しました: $e',
      );
    }
  }

  Future<void> updateStartingDayOfWeek(bool startingDayOfWeek) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final newSettings = state.settings.copyWith(
        startingDayOfWeek: startingDayOfWeek,
      );
      await _repository.saveSettings(newSettings);
      if (!mounted) return;
      state = state.copyWith(settings: newSettings, isLoading: false);
    } catch (e) {
      if (!mounted) return;
      state = state.copyWith(
        isLoading: false,
        error: '設定の保存に失敗しました: $e',
      );
    }
  }
}

/// カレンダー設定ViewModelのプロバイダー
final calendarSettingsViewModelProvider =
    StateNotifierProvider<CalendarSettingsViewModel, CalendarSettingsState>(
        (ref) {
  final repository = ref.watch(calendarSettingsRepositoryProvider);
  return CalendarSettingsViewModel(repository);
});
