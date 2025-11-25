import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/edit_calendar_event_state.dart';

void main() {
  group('EditCalendarEventState', () {
    late EditCalendarEventState state;

    setUp(() {
      state = EditCalendarEventState(
        eventId: 'test-event-id',
        title: 'テストイベント',
        memo: 'メモ',
        allDay: false,
        startDate: DateTime(2024, 3, 15),
        endDate: DateTime(2024, 3, 15),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 10, minute: 0),
        selectedIconPath: '',
        availableIconPaths: const ['', 'assets/icons/birthday.png'],
      );
    });

    group('canSubmit', () {
      test('有効な状態の場合はtrue', () {
        expect(state.canSubmit, true);
      });

      test('タイトルが空の場合はfalse', () {
        final invalidState = state.copyWith(title: '');
        expect(invalidState.canSubmit, false);
      });

      test('タイトルが空白のみの場合はfalse', () {
        final invalidState = state.copyWith(title: '   ');
        expect(invalidState.canSubmit, false);
      });

      test('isSubmitting中はfalse', () {
        final submittingState = state.copyWith(isSubmitting: true);
        expect(submittingState.canSubmit, false);
      });

      test('isDeleting中はfalse', () {
        final deletingState = state.copyWith(isDeleting: true);
        expect(deletingState.canSubmit, false);
      });

      test('終了時刻が開始時刻より前の場合はfalse', () {
        final invalidState = state.copyWith(
          endTime: const TimeOfDay(hour: 8, minute: 0),
        );
        expect(invalidState.canSubmit, false);
      });

      test('終了時刻と開始時刻が同じ場合はfalse', () {
        final invalidState = state.copyWith(
          startTime: const TimeOfDay(hour: 10, minute: 0),
          endTime: const TimeOfDay(hour: 10, minute: 0),
        );
        expect(invalidState.canSubmit, false);
      });
    });

    group('canDelete', () {
      test('通常時はtrue', () {
        expect(state.canDelete, true);
      });

      test('isSubmitting中はfalse', () {
        final submittingState = state.copyWith(isSubmitting: true);
        expect(submittingState.canDelete, false);
      });

      test('isDeleting中はfalse', () {
        final deletingState = state.copyWith(isDeleting: true);
        expect(deletingState.canDelete, false);
      });
    });

    group('effectiveStart / effectiveEnd', () {
      test('allDay=false の場合は時刻を含む', () {
        expect(state.effectiveStart, DateTime(2024, 3, 15, 9, 0));
        expect(state.effectiveEnd, DateTime(2024, 3, 15, 10, 0));
      });

      test('allDay=true の場合、開始は日付のみ', () {
        final allDayState = state.copyWith(allDay: true);
        expect(allDayState.effectiveStart, DateTime(2024, 3, 15));
      });

      test('allDay=true の場合、終了は23:59:59', () {
        final allDayState = state.copyWith(allDay: true);
        expect(allDayState.effectiveEnd, DateTime(2024, 3, 15, 23, 59, 59));
      });

      test('異なる日付でも正しく計算', () {
        final multiDayState = state.copyWith(
          startDate: DateTime(2024, 3, 15),
          endDate: DateTime(2024, 3, 20),
          startTime: const TimeOfDay(hour: 14, minute: 30),
          endTime: const TimeOfDay(hour: 18, minute: 0),
        );
        expect(multiDayState.effectiveStart, DateTime(2024, 3, 15, 14, 30));
        expect(multiDayState.effectiveEnd, DateTime(2024, 3, 20, 18, 0));
      });
    });

    group('copyWith', () {
      test('eventId を更新できる', () {
        final newState = state.copyWith(eventId: 'new-id');
        expect(newState.eventId, 'new-id');
      });

      test('title を更新できる', () {
        final newState = state.copyWith(title: '新しいタイトル');
        expect(newState.title, '新しいタイトル');
        expect(newState.eventId, state.eventId);
      });

      test('memo を更新できる', () {
        final newState = state.copyWith(memo: '新しいメモ');
        expect(newState.memo, '新しいメモ');
      });

      test('allDay を更新できる', () {
        final newState = state.copyWith(allDay: true);
        expect(newState.allDay, true);
      });

      test('startDate を更新できる', () {
        final newDate = DateTime(2024, 4, 1);
        final newState = state.copyWith(startDate: newDate);
        expect(newState.startDate, newDate);
      });

      test('endDate を更新できる', () {
        final newDate = DateTime(2024, 4, 5);
        final newState = state.copyWith(endDate: newDate);
        expect(newState.endDate, newDate);
      });

      test('startTime を更新できる', () {
        const newTime = TimeOfDay(hour: 15, minute: 30);
        final newState = state.copyWith(startTime: newTime);
        expect(newState.startTime, newTime);
      });

      test('endTime を更新できる', () {
        const newTime = TimeOfDay(hour: 18, minute: 0);
        final newState = state.copyWith(endTime: newTime);
        expect(newState.endTime, newTime);
      });

      test('selectedIconPath を更新できる', () {
        final newState =
            state.copyWith(selectedIconPath: 'assets/icons/birthday.png');
        expect(newState.selectedIconPath, 'assets/icons/birthday.png');
      });

      test('titleError を更新できる', () {
        final newState = state.copyWith(titleError: 'タイトルエラー');
        expect(newState.titleError, 'タイトルエラー');
      });

      test('titleError を null に設定できる', () {
        final stateWithError = state.copyWith(titleError: 'エラー');
        final clearedState = stateWithError.copyWith(titleError: null);
        expect(clearedState.titleError, isNull);
      });

      test('dateTimeError を更新できる', () {
        final newState = state.copyWith(dateTimeError: '日時エラー');
        expect(newState.dateTimeError, '日時エラー');
      });

      test('isSubmitting を更新できる', () {
        final newState = state.copyWith(isSubmitting: true);
        expect(newState.isSubmitting, true);
      });

      test('isDeleting を更新できる', () {
        final newState = state.copyWith(isDeleting: true);
        expect(newState.isDeleting, true);
      });

      test('availableIconPaths を更新できる', () {
        final newState = state.copyWith(
          availableIconPaths: ['path1', 'path2'],
        );
        expect(newState.availableIconPaths, ['path1', 'path2']);
      });
    });
  });

  group('TimeOfDay', () {
    test('fromDateTime で DateTime から生成', () {
      final dateTime = DateTime(2024, 3, 15, 14, 30);
      final timeOfDay = TimeOfDay.fromDateTime(dateTime);
      expect(timeOfDay.hour, 14);
      expect(timeOfDay.minute, 30);
    });

    test('copyWith で hour を更新', () {
      const time = TimeOfDay(hour: 10, minute: 30);
      final newTime = time.copyWith(hour: 15);
      expect(newTime.hour, 15);
      expect(newTime.minute, 30);
    });

    test('copyWith で minute を更新', () {
      const time = TimeOfDay(hour: 10, minute: 30);
      final newTime = time.copyWith(minute: 45);
      expect(newTime.hour, 10);
      expect(newTime.minute, 45);
    });

    test('同じ値の TimeOfDay は等しい', () {
      const time1 = TimeOfDay(hour: 10, minute: 30);
      const time2 = TimeOfDay(hour: 10, minute: 30);
      expect(time1, equals(time2));
      expect(time1.hashCode, equals(time2.hashCode));
    });

    test('異なる値の TimeOfDay は等しくない', () {
      const time1 = TimeOfDay(hour: 10, minute: 30);
      const time2 = TimeOfDay(hour: 10, minute: 31);
      expect(time1, isNot(equals(time2)));
    });
  });
}
