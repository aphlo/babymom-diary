import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:babymom_diary/src/features/calendar/presentation/models/calendar_event_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/add_calendar_event_state.dart';

final addCalendarEventViewModelProvider =
    AutoDisposeStateNotifierProviderFamily<AddCalendarEventViewModel,
        AddCalendarEventState, DateTime>((ref, initialDate) {
  return AddCalendarEventViewModel(initialDate: initialDate);
});

class AddCalendarEventViewModel extends StateNotifier<AddCalendarEventState> {
  AddCalendarEventViewModel({
    required DateTime initialDate,
  }) : super(_initialState(initialDate: initialDate));

  static const String _noIconPath = '';

  static const List<String> _availableIconPaths = <String>[
    _noIconPath,
    'assets/icons/birthday.png',
    'assets/icons/seven_nights.png',
    'assets/icons/k2_syrup.png',
    'assets/icons/health_check.png',
    'assets/icons/vaccination.png',
    'assets/icons/omiyamairi.png',
    'assets/icons/okuizome.png',
    'assets/icons/medical_consultation.png',
    'assets/icons/half_birthday.png',
    'assets/icons/first_boy_festival.png',
    'assets/icons/first_girl_festival.png',
  ];

  static AddCalendarEventState _initialState({
    required DateTime initialDate,
  }) {
    final normalizedDate = _normalizeDate(initialDate);
    return AddCalendarEventState(
      title: '',
      memo: '',
      allDay: false,
      startDate: normalizedDate,
      endDate: normalizedDate,
      startTime: const TimeOfDay(hour: 9, minute: 0),
      endTime: const TimeOfDay(hour: 10, minute: 0),
      selectedIconPath: _noIconPath,
      isSubmitting: false,
      validationMessage: null,
      availableIconPaths: _availableIconPaths,
    );
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title);
  }

  void updateMemo(String memo) {
    state = state.copyWith(memo: memo);
  }

  void updateAllDay(bool allDay) {
    state = state.copyWith(allDay: allDay);
  }

  void updateStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate);
  }

  void updateEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate);
  }

  void updateStartTime(TimeOfDay startTime) {
    state = state.copyWith(startTime: startTime);
  }

  void updateEndTime(TimeOfDay endTime) {
    state = state.copyWith(endTime: endTime);
  }

  void selectIcon(String iconPath) {
    state = state.copyWith(selectedIconPath: iconPath);
  }

  void showStartDatePicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime(2100, 12, 31),
      onConfirm: (date) {
        updateStartDate(date);
      },
      currentTime: state.startDate,
      locale: LocaleType.jp,
    );
  }

  void showEndDatePicker(BuildContext context) {
    DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      minTime: DateTime(2000, 1, 1),
      maxTime: DateTime(2100, 12, 31),
      onConfirm: (date) {
        updateEndDate(date);
      },
      currentTime: state.endDate,
      locale: LocaleType.jp,
    );
  }

  void showStartTimePicker(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (time) {
        updateStartTime(TimeOfDay.fromDateTime(time));
      },
      currentTime: DateTime(
        2000,
        1,
        1,
        state.startTime.hour,
        state.startTime.minute,
      ),
      locale: LocaleType.jp,
    );
  }

  void showEndTimePicker(BuildContext context) {
    DatePicker.showTimePicker(
      context,
      showTitleActions: true,
      onConfirm: (time) {
        updateEndTime(TimeOfDay.fromDateTime(time));
      },
      currentTime: DateTime(
        2000,
        1,
        1,
        state.endTime.hour,
        state.endTime.minute,
      ),
      locale: LocaleType.jp,
    );
  }

  CalendarEventModel? buildResult() {
    if (!state.canSubmit) {
      state = state.copyWith(
        validationMessage: _getValidationMessage(),
      );
      return null;
    }

    state = state.copyWith(validationMessage: null);
    return CalendarEventModel(
      title: state.title.trim(),
      memo: state.memo.trim(),
      allDay: state.allDay,
      start: state.effectiveStart,
      end: state.effectiveEnd,
      iconPath: state.selectedIconPath,
    );
  }

  String _getValidationMessage() {
    if (state.title.trim().isEmpty) {
      return 'タイトルを入力してください';
    }

    if (!state.allDay) {
      final start = state.effectiveStart;
      final end = state.effectiveEnd;
      if (!end.isAfter(start)) {
        return '終了時間は開始時間より後にしてください';
      }
    }

    return '入力内容を確認してください';
  }

  static DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
