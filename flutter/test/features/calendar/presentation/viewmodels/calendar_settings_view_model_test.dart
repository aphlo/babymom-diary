import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/calendar_settings_state.dart';

void main() {
  group('CalendarSettingsState', () {
    test('初期状態が正しい', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
      );

      expect(state.settings.startingDayOfWeek, false);
      expect(state.isLoading, false);
      expect(state.error, isNull);
    });

    test('copyWith で settings を更新できる', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
      );

      final newState = state.copyWith(
        settings: const CalendarSettings(startingDayOfWeek: true),
      );

      expect(newState.settings.startingDayOfWeek, true);
      expect(newState.isLoading, false);
    });

    test('copyWith で isLoading を更新できる', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
      );

      final newState = state.copyWith(isLoading: true);

      expect(newState.isLoading, true);
      expect(newState.settings.startingDayOfWeek, false);
    });

    test('copyWith で error を更新できる', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
      );

      final newState = state.copyWith(error: 'エラーメッセージ');

      expect(newState.error, 'エラーメッセージ');
    });

    test('copyWith で error を null に設定できる', () {
      const state = CalendarSettingsState(
        settings: CalendarSettings(startingDayOfWeek: false),
        error: 'エラー',
      );

      final newState = state.copyWith(error: null);

      expect(newState.error, isNull);
    });
  });
}
