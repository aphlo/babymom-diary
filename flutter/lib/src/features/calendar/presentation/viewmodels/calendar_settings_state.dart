import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';

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
