import 'package:flutter/material.dart' hide TimeOfDay;
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/calendar/application/usecases/update_calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/application/usecases/delete_calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/application/calendar_event_controller.dart';
import 'package:babymom_diary/src/features/calendar/presentation/models/calendar_event_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/edit_calendar_event_state.dart';

part 'edit_calendar_event_view_model.g.dart';

@riverpod
class EditCalendarEventViewModel extends _$EditCalendarEventViewModel {
  UpdateCalendarEvent? _updateUseCase;
  DeleteCalendarEvent? _deleteUseCase;

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

  @override
  EditCalendarEventState build(CalendarEvent event) {
    final repository = ref.watch(calendarEventRepositoryProvider);
    _updateUseCase = UpdateCalendarEvent(repository);
    _deleteUseCase = DeleteCalendarEvent(repository);

    return EditCalendarEventState(
      eventId: event.id,
      title: event.title,
      memo: event.memo,
      allDay: event.allDay,
      startDate: _normalizeDate(event.start),
      endDate: _normalizeDate(event.end),
      startTime: TimeOfDay.fromDateTime(event.start),
      endTime: TimeOfDay.fromDateTime(event.end),
      selectedIconPath: event.iconPath,
      availableIconPaths: _availableIconPaths,
    );
  }

  void updateTitle(String title) {
    state = state.copyWith(title: title, titleError: null);
  }

  void updateMemo(String memo) {
    state = state.copyWith(memo: memo);
  }

  void updateAllDay(bool allDay) {
    state = state.copyWith(allDay: allDay, dateTimeError: null);
  }

  void updateStartDate(DateTime startDate) {
    state = state.copyWith(startDate: startDate, dateTimeError: null);
  }

  void updateEndDate(DateTime endDate) {
    state = state.copyWith(endDate: endDate, dateTimeError: null);
  }

  void updateStartTime(TimeOfDay startTime) {
    state = state.copyWith(startTime: startTime, dateTimeError: null);
  }

  void updateEndTime(TimeOfDay endTime) {
    state = state.copyWith(endTime: endTime, dateTimeError: null);
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
      showSecondsColumn: false,
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
      showSecondsColumn: false,
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

  Future<bool> updateEvent() async {
    String? titleError;
    String? dateTimeError;

    // タイトルのバリデーション
    if (state.title.trim().isEmpty) {
      titleError = 'タイトルを入力してください';
    }

    // 時間のバリデーション
    final start = state.effectiveStart;
    final end = state.effectiveEnd;
    if (!end.isAfter(start)) {
      dateTimeError = '終了時間は開始時間より後にしてください';
    }

    // エラーがある場合はstateを更新してfalseを返す
    if (titleError != null || dateTimeError != null) {
      state = state.copyWith(
        titleError: titleError,
        dateTimeError: dateTimeError,
      );
      return false;
    }

    state = state.copyWith(
        isSubmitting: true, titleError: null, dateTimeError: null);

    try {
      final householdId = await ref.read(currentHouseholdIdProvider.future);
      final updateUseCase = _updateUseCase;
      if (updateUseCase == null) {
        state = state.copyWith(
          isSubmitting: false,
          dateTimeError: 'イベントの更新に失敗しました',
        );
        return false;
      }

      await updateUseCase(
        eventId: state.eventId,
        householdId: householdId,
        title: state.title.trim(),
        memo: state.memo.trim(),
        allDay: state.allDay,
        start: state.effectiveStart,
        end: state.effectiveEnd,
        iconKey: state.selectedIconPath,
      );

      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (error) {
      state = state.copyWith(
        isSubmitting: false,
        dateTimeError: 'イベントの更新に失敗しました: $error',
      );
      return false;
    }
  }

  Future<bool> deleteEvent() async {
    if (!state.canDelete) {
      return false;
    }

    state =
        state.copyWith(isDeleting: true, titleError: null, dateTimeError: null);

    try {
      final householdId = await ref.read(currentHouseholdIdProvider.future);
      final deleteUseCase = _deleteUseCase;
      if (deleteUseCase == null) {
        state = state.copyWith(
          isDeleting: false,
          dateTimeError: 'イベントの削除に失敗しました',
        );
        return false;
      }

      await deleteUseCase(
        eventId: state.eventId,
        householdId: householdId,
        eventDate: state.startDate,
      );

      state = state.copyWith(isDeleting: false);
      return true;
    } catch (error) {
      state = state.copyWith(
        isDeleting: false,
        dateTimeError: 'イベントの削除に失敗しました: $error',
      );
      return false;
    }
  }

  CalendarEventModel? buildResult() {
    String? titleError;
    String? dateTimeError;

    // タイトルのバリデーション
    if (state.title.trim().isEmpty) {
      titleError = 'タイトルを入力してください';
    }

    // 時間のバリデーション
    final start = state.effectiveStart;
    final end = state.effectiveEnd;
    if (!end.isAfter(start)) {
      dateTimeError = '終了時間は開始時間より後にしてください';
    }

    // エラーがある場合はstateを更新してnullを返す
    if (titleError != null || dateTimeError != null) {
      state = state.copyWith(
        titleError: titleError,
        dateTimeError: dateTimeError,
      );
      return null;
    }

    // エラーがない場合は成功
    state = state.copyWith(titleError: null, dateTimeError: null);
    return CalendarEventModel(
      title: state.title.trim(),
      memo: state.memo.trim(),
      allDay: state.allDay,
      start: state.effectiveStart,
      end: state.effectiveEnd,
      iconPath: state.selectedIconPath,
    );
  }

  static DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
