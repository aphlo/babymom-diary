import 'package:flutter/material.dart' hide TimeOfDay;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/calendar/application/usecases/update_calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/application/usecases/delete_calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/infrastructure/repositories/calendar_event_repository_impl.dart';
import 'package:babymom_diary/src/features/calendar/infrastructure/sources/calendar_event_firestore_data_source.dart';
import 'package:babymom_diary/src/features/calendar/presentation/models/calendar_event_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/edit_calendar_event_state.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final editCalendarEventViewModelProvider =
    AutoDisposeStateNotifierProviderFamily<EditCalendarEventViewModel,
        EditCalendarEventState, CalendarEvent>(
  (ref, event) {
    final repository = CalendarEventRepositoryImpl(
      remote: CalendarEventFirestoreDataSource(FirebaseFirestore.instance),
    );
    final updateUseCase = UpdateCalendarEvent(repository);
    final deleteUseCase = DeleteCalendarEvent(repository);

    return EditCalendarEventViewModel(
      event: event,
      updateUseCase: updateUseCase,
      deleteUseCase: deleteUseCase,
      ref: ref,
    );
  },
);

class EditCalendarEventViewModel extends StateNotifier<EditCalendarEventState> {
  EditCalendarEventViewModel({
    required CalendarEvent event,
    required UpdateCalendarEvent updateUseCase,
    required DeleteCalendarEvent deleteUseCase,
    required Ref ref,
  })  : _updateUseCase = updateUseCase,
        _deleteUseCase = deleteUseCase,
        _ref = ref,
        super(_initialState(event));

  final UpdateCalendarEvent _updateUseCase;
  final DeleteCalendarEvent _deleteUseCase;
  final Ref _ref;

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

  static EditCalendarEventState _initialState(CalendarEvent event) {
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
    if (!state.canSubmit) {
      state = state.copyWith(
        validationMessage: _getValidationMessage(),
      );
      return false;
    }

    state = state.copyWith(isSubmitting: true, validationMessage: null);

    try {
      final householdId = await _ref.read(currentHouseholdIdProvider.future);

      await _updateUseCase(
        eventId: state.eventId,
        householdId: householdId,
        title: state.title.trim(),
        memo: state.memo.trim(),
        allDay: state.allDay,
        start: state.effectiveStart,
        end: state.effectiveEnd,
        iconKey: state.selectedIconPath,
      );

      if (!mounted) return false;
      state = state.copyWith(isSubmitting: false);
      return true;
    } catch (error) {
      if (!mounted) return false;
      state = state.copyWith(
        isSubmitting: false,
        validationMessage: 'イベントの更新に失敗しました: $error',
      );
      return false;
    }
  }

  Future<bool> deleteEvent() async {
    if (!state.canDelete) {
      return false;
    }

    state = state.copyWith(isDeleting: true, validationMessage: null);

    try {
      final householdId = await _ref.read(currentHouseholdIdProvider.future);

      await _deleteUseCase(
        eventId: state.eventId,
        householdId: householdId,
      );

      if (!mounted) return false;
      state = state.copyWith(isDeleting: false);
      return true;
    } catch (error) {
      if (!mounted) return false;
      state = state.copyWith(
        isDeleting: false,
        validationMessage: 'イベントの削除に失敗しました: $error',
      );
      return false;
    }
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
