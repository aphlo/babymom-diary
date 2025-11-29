import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/add_calendar_event_state.dart';

void main() {
  group('AddCalendarEventState', () {
    test('初期状態が正しい', () {
      final state = AddCalendarEventState(
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

      expect(state.title, '');
      expect(state.memo, '');
      expect(state.allDay, false);
      expect(state.startDate, DateTime(2024, 3, 15));
      expect(state.endDate, DateTime(2024, 3, 15));
      expect(state.startTime, const TimeOfDay(hour: 9, minute: 0));
      expect(state.endTime, const TimeOfDay(hour: 10, minute: 0));
      expect(state.selectedIconPath, '');
      expect(state.isSubmitting, false);
      expect(state.titleError, isNull);
      expect(state.dateTimeError, isNull);
      expect(state.availableIconPaths.isNotEmpty, true);
    });

    test('copyWith でタイトルを更新できる', () {
      final state = AddCalendarEventState(
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
        availableIconPaths: const [],
      );

      final updated = state.copyWith(title: 'テストイベント');
      expect(updated.title, 'テストイベント');
    });

    test('copyWith でメモを更新できる', () {
      final state = AddCalendarEventState(
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
        availableIconPaths: const [],
      );

      final updated = state.copyWith(memo: 'メモ内容');
      expect(updated.memo, 'メモ内容');
    });

    test('copyWith で終日フラグを更新できる', () {
      final state = AddCalendarEventState(
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
        availableIconPaths: const [],
      );

      final updated = state.copyWith(allDay: true);
      expect(updated.allDay, true);
    });

    test('copyWith で開始日を更新できる', () {
      final state = AddCalendarEventState(
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
        availableIconPaths: const [],
      );

      final newDate = DateTime(2024, 4, 1);
      final updated = state.copyWith(startDate: newDate);
      expect(updated.startDate, newDate);
    });

    test('copyWith で開始時刻を更新できる', () {
      final state = AddCalendarEventState(
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
        availableIconPaths: const [],
      );

      const newTime = TimeOfDay(hour: 14, minute: 30);
      final updated = state.copyWith(startTime: newTime);
      expect(updated.startTime, newTime);
    });

    test('copyWith でアイコンを更新できる', () {
      final state = AddCalendarEventState(
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
        availableIconPaths: const [],
      );

      final updated =
          state.copyWith(selectedIconPath: 'assets/icons/birthday.png');
      expect(updated.selectedIconPath, 'assets/icons/birthday.png');
    });

    test('effectiveStart は終日の場合は日の開始を返す', () {
      final state = AddCalendarEventState(
        title: '',
        memo: '',
        allDay: true,
        startDate: DateTime(2024, 3, 15),
        endDate: DateTime(2024, 3, 15),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 10, minute: 0),
        selectedIconPath: '',
        isSubmitting: false,
        titleError: null,
        dateTimeError: null,
        availableIconPaths: const [],
      );

      expect(state.effectiveStart, DateTime(2024, 3, 15, 0, 0));
    });

    test('effectiveEnd は終日の場合は日の終わり(23:59)を返す', () {
      final state = AddCalendarEventState(
        title: '',
        memo: '',
        allDay: true,
        startDate: DateTime(2024, 3, 15),
        endDate: DateTime(2024, 3, 15),
        startTime: const TimeOfDay(hour: 9, minute: 0),
        endTime: const TimeOfDay(hour: 10, minute: 0),
        selectedIconPath: '',
        isSubmitting: false,
        titleError: null,
        dateTimeError: null,
        availableIconPaths: const [],
      );

      expect(state.effectiveEnd, DateTime(2024, 3, 15, 23, 59));
    });
  });
}
