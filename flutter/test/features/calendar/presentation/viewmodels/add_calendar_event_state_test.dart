import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/add_calendar_event_state.dart';

void main() {
  group('AddCalendarEventState', () {
    late AddCalendarEventState state;

    setUp(() {
      state = AddCalendarEventState(
        title: '',
        memo: '',
        allDay: false,
        startDate: DateTime(2024, 3, 15),
        endDate: DateTime(2024, 3, 15),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 10, minute: 0),
        selectedIconPath: '',
        isSubmitting: false,
        titleError: null,
        dateTimeError: null,
        availableIconPaths: const ['', 'assets/icons/birthday.png'],
      );
    });

    group('canSubmit', () {
      test('タイトルが空の場合はfalse', () {
        expect(state.canSubmit, false);
      });

      test('タイトルがあり終了時刻が開始時刻より後の場合はtrue', () {
        final validState = state.copyWith(title: 'テストイベント');
        expect(validState.canSubmit, true);
      });

      test('終了時刻が開始時刻より前の場合はfalse', () {
        final invalidState = state.copyWith(
          title: 'テストイベント',
          endTime: const TimeOfDay(hour: 8, minute: 0),
        );
        expect(invalidState.canSubmit, false);
      });

      test('タイトルが空白のみの場合はfalse', () {
        final invalidState = state.copyWith(title: '   ');
        expect(invalidState.canSubmit, false);
      });
    });

    group('effectiveStart / effectiveEnd', () {
      test('allDay=false の場合は時刻を含む', () {
        final s = state.copyWith(
          startDate: DateTime(2024, 3, 15),
          startTime: const TimeOfDay(hour: 14, minute: 30),
        );
        expect(s.effectiveStart, DateTime(2024, 3, 15, 14, 30));
      });

      test('allDay=true の場合は日付のみ（開始）', () {
        final s = state.copyWith(
          allDay: true,
          startDate: DateTime(2024, 3, 15),
        );
        expect(s.effectiveStart, DateTime(2024, 3, 15));
      });

      test('allDay=true の場合は23:59まで（終了）', () {
        final s = state.copyWith(
          allDay: true,
          endDate: DateTime(2024, 3, 15),
        );
        expect(s.effectiveEnd, DateTime(2024, 3, 15, 23, 59));
      });
    });

    group('normalizedDate', () {
      test('normalizedStartDate は時刻を除いた日付を返す', () {
        final s = state.copyWith(
          startDate: DateTime(2024, 3, 15, 10, 30, 45),
        );
        expect(s.normalizedStartDate, DateTime(2024, 3, 15));
      });

      test('normalizedEndDate は時刻を除いた日付を返す', () {
        final s = state.copyWith(
          endDate: DateTime(2024, 3, 20, 14, 45, 30),
        );
        expect(s.normalizedEndDate, DateTime(2024, 3, 20));
      });
    });

    group('copyWith', () {
      test('title を更新できる', () {
        final newState = state.copyWith(title: '新しいタイトル');
        expect(newState.title, '新しいタイトル');
        expect(newState.memo, state.memo);
      });

      test('memo を更新できる', () {
        final newState = state.copyWith(memo: 'メモ内容');
        expect(newState.memo, 'メモ内容');
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

      test('isSubmitting を更新できる', () {
        final newState = state.copyWith(isSubmitting: true);
        expect(newState.isSubmitting, true);
      });

      test('titleError を更新できる', () {
        final newState = state.copyWith(titleError: 'エラーメッセージ');
        expect(newState.titleError, 'エラーメッセージ');
      });

      test('dateTimeError を更新できる', () {
        final newState = state.copyWith(dateTimeError: '日時エラー');
        expect(newState.dateTimeError, '日時エラー');
      });

      test('availableIconPaths は不変リスト', () {
        expect(
            () => state.availableIconPaths.add('test'), throwsUnsupportedError);
      });
    });
  });
}
