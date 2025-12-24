import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_settings_state.freezed.dart';

/// カレンダー設定画面の状態
@freezed
sealed class CalendarSettingsState with _$CalendarSettingsState {
  const factory CalendarSettingsState({
    required CalendarSettings settings,
    @Default(false) bool isLoading,
    String? error,
  }) = _CalendarSettingsState;
}
