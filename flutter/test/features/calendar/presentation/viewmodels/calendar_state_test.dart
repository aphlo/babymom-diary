import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/calendar_state.dart';

void main() {
  group('CalendarState', () {
    test('initial() は正しい初期状態を返す', () {
      final state = CalendarState.initial();
      final now = DateTime.now();
      final normalizedNow = DateTime(now.year, now.month, now.day);

      expect(state.focusedDay, normalizedNow);
      expect(state.selectedDay, normalizedNow);
      expect(state.eventsByDay, isEmpty);
      expect(state.eventsAsync.value, isEmpty);
      expect(state.householdId, isNull);
      expect(state.availableChildren, isEmpty);
      expect(state.selectedChildId, isNull);
      expect(state.calendarSettings.startingDayOfWeek, false);
      expect(state.pendingUiEvent, isNull);
    });

    test('isLoadingEvents は eventsAsync.isLoading を返す', () {
      final state = CalendarState.initial();
      expect(state.isLoadingEvents, false);
    });

    test('hasError は eventsAsync.hasError を返す', () {
      final state = CalendarState.initial();
      expect(state.hasError, false);
    });

    test('monthLabel は正しいフォーマットで月を返す', () {
      final state = CalendarState.initial().copyWith(
        focusedDay: DateTime(2024, 3, 15),
      );
      expect(state.monthLabel, '2024年03月');
    });

    group('eventsForSelectedDay', () {
      test('選択日のイベントを時刻順で返す', () {
        final event1 = CalendarEvent(
          id: '1',
          title: 'イベント1',
          memo: '',
          allDay: false,
          start: DateTime(2024, 3, 15, 14, 0),
          end: DateTime(2024, 3, 15, 15, 0),
          iconPath: 'default',
        );
        final event2 = CalendarEvent(
          id: '2',
          title: 'イベント2',
          memo: '',
          allDay: false,
          start: DateTime(2024, 3, 15, 10, 0),
          end: DateTime(2024, 3, 15, 11, 0),
          iconPath: 'default',
        );

        final state = CalendarState.initial().copyWith(
          selectedDay: DateTime(2024, 3, 15),
          eventsByDay: {
            DateTime(2024, 3, 15): [event1, event2],
          },
        );

        final events = state.eventsForSelectedDay();
        expect(events.length, 2);
        expect(events[0].id, '2'); // 10:00 が先
        expect(events[1].id, '1'); // 14:00 が後
      });

      test('選択日にイベントがない場合は空リストを返す', () {
        final state = CalendarState.initial().copyWith(
          selectedDay: DateTime(2024, 3, 15),
          eventsByDay: {},
        );

        expect(state.eventsForSelectedDay(), isEmpty);
      });
    });

    group('eventsForDay', () {
      test('指定日のイベントを返す', () {
        final event = CalendarEvent(
          id: '1',
          title: 'イベント',
          memo: '',
          allDay: true,
          start: DateTime(2024, 3, 15),
          end: DateTime(2024, 3, 15),
          iconPath: 'default',
        );

        final state = CalendarState.initial().copyWith(
          eventsByDay: {
            DateTime(2024, 3, 15): [event],
          },
        );

        expect(state.eventsForDay(DateTime(2024, 3, 15)).length, 1);
        expect(state.eventsForDay(DateTime(2024, 3, 16)), isEmpty);
      });
    });

    group('copyWith', () {
      test('focusedDay を更新できる', () {
        final state = CalendarState.initial();
        final newDate = DateTime(2024, 5, 1);
        final newState = state.copyWith(focusedDay: newDate);

        expect(newState.focusedDay, newDate);
        expect(newState.selectedDay, state.selectedDay);
      });

      test('selectedDay を更新できる', () {
        final state = CalendarState.initial();
        final newDate = DateTime(2024, 5, 15);
        final newState = state.copyWith(selectedDay: newDate);

        expect(newState.selectedDay, newDate);
        expect(newState.focusedDay, state.focusedDay);
      });

      test('householdId を更新できる', () {
        final state = CalendarState.initial();
        final newState = state.copyWith(householdId: 'test-household');

        expect(newState.householdId, 'test-household');
      });

      test('calendarSettings を更新できる', () {
        final state = CalendarState.initial();
        final newSettings = const CalendarSettings(startingDayOfWeek: true);
        final newState = state.copyWith(calendarSettings: newSettings);

        expect(newState.calendarSettings.startingDayOfWeek, true);
      });

      test('pendingUiEvent を更新・クリアできる', () {
        final state = CalendarState.initial();

        // 設定
        final stateWithEvent = state.copyWith(
          pendingUiEvent: const CalendarUiEvent.showMessage('テスト'),
        );
        stateWithEvent.pendingUiEvent?.map(
          showMessage: (value) => expect(value.message, 'テスト'),
          openAddEvent: (_) => fail('unexpected event'),
          openSettings: (_) => fail('unexpected event'),
        );

        // クリア（copyWith で pendingUiEvent を null にするには明示的に渡す）
        final clearedState = stateWithEvent.copyWith(pendingUiEvent: null);
        expect(clearedState.pendingUiEvent, isNull);
      });
    });
  });

  group('CalendarUiEvent', () {
    test('showMessage は正しいメッセージを持つ', () {
      const event = CalendarUiEvent.showMessage('エラーメッセージ');
      event.map(
        showMessage: (value) => expect(value.message, 'エラーメッセージ'),
        openAddEvent: (_) => fail('unexpected event'),
        openSettings: (_) => fail('unexpected event'),
      );
    });

    test('openSettings は openSettings フラグを持つ', () {
      const event = CalendarUiEvent.openSettings();
      event.map(
        showMessage: (_) => fail('unexpected event'),
        openAddEvent: (_) => fail('unexpected event'),
        openSettings: (_) => expect(true, true),
      );
    });
  });

  group('CalendarEvent', () {
    test('occursOn は正しく日付を判定する', () {
      final event = CalendarEvent(
        id: '1',
        title: '複数日イベント',
        memo: '',
        allDay: true,
        start: DateTime(2024, 3, 10),
        end: DateTime(2024, 3, 15),
        iconPath: 'default',
      );

      expect(event.occursOn(DateTime(2024, 3, 9)), false);
      expect(event.occursOn(DateTime(2024, 3, 10)), true);
      expect(event.occursOn(DateTime(2024, 3, 12)), true);
      expect(event.occursOn(DateTime(2024, 3, 15)), true);
      expect(event.occursOn(DateTime(2024, 3, 16)), false);
    });

    test('startDateOnly と endDateOnly は時刻を除いた日付を返す', () {
      final event = CalendarEvent(
        id: '1',
        title: 'イベント',
        memo: '',
        allDay: false,
        start: DateTime(2024, 3, 15, 10, 30),
        end: DateTime(2024, 3, 15, 14, 45),
        iconPath: 'default',
      );

      expect(event.startDateOnly, DateTime(2024, 3, 15));
      expect(event.endDateOnly, DateTime(2024, 3, 15));
    });

    test('copyWith で属性を更新できる', () {
      final event = CalendarEvent(
        id: '1',
        title: '元のタイトル',
        memo: '',
        allDay: true,
        start: DateTime(2024, 3, 15),
        end: DateTime(2024, 3, 15),
        iconPath: 'default',
      );

      final updated = event.copyWith(title: '新しいタイトル');
      expect(updated.title, '新しいタイトル');
      expect(updated.id, '1');
    });

    test('同じ内容のイベントは等しい', () {
      final event1 = CalendarEvent(
        id: '1',
        title: 'イベント',
        memo: 'メモ',
        allDay: true,
        start: DateTime(2024, 3, 15),
        end: DateTime(2024, 3, 15),
        iconPath: 'default',
      );
      final event2 = CalendarEvent(
        id: '1',
        title: 'イベント',
        memo: 'メモ',
        allDay: true,
        start: DateTime(2024, 3, 15),
        end: DateTime(2024, 3, 15),
        iconPath: 'default',
      );

      expect(event1, equals(event2));
      expect(event1.hashCode, equals(event2.hashCode));
    });
  });

  group('CalendarSettings', () {
    test('copyWith で設定を更新できる', () {
      const settings = CalendarSettings(startingDayOfWeek: false);
      final updated = settings.copyWith(startingDayOfWeek: true);

      expect(updated.startingDayOfWeek, true);
    });

    test('同じ内容の設定は等しい', () {
      const settings1 = CalendarSettings(startingDayOfWeek: true);
      const settings2 = CalendarSettings(startingDayOfWeek: true);

      expect(settings1, equals(settings2));
      expect(settings1.hashCode, equals(settings2.hashCode));
    });

    test('toString は正しい文字列を返す', () {
      const settings = CalendarSettings(startingDayOfWeek: true);
      expect(settings.toString(), 'CalendarSettings(startingDayOfWeek: true)');
    });
  });
}
