import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:babymom_diary/src/features/calendar/presentation/models/calendar_event_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/add_calendar_event_state.dart';
import 'package:babymom_diary/src/features/children/domain/entities/child_summary.dart';

class AddCalendarEventViewModelArgs {
  const AddCalendarEventViewModelArgs({
    required this.initialDate,
    required this.children,
    this.initialChildId,
  });

  final DateTime initialDate;
  final List<ChildSummary> children;
  final String? initialChildId;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AddCalendarEventViewModelArgs &&
        other.initialDate == initialDate &&
        listEquals(other.children, children) &&
        other.initialChildId == initialChildId;
  }

  @override
  int get hashCode =>
      Object.hash(initialDate, Object.hashAll(children), initialChildId);
}

final addCalendarEventViewModelProvider =
    AutoDisposeStateNotifierProviderFamily<AddCalendarEventViewModel,
        AddCalendarEventState, AddCalendarEventViewModelArgs>((ref, args) {
  return AddCalendarEventViewModel(
    initialDate: args.initialDate,
    children: args.children,
    initialChildId: args.initialChildId,
  );
});

class AddCalendarEventViewModel extends StateNotifier<AddCalendarEventState> {
  AddCalendarEventViewModel({
    required DateTime initialDate,
    required List<ChildSummary> children,
    String? initialChildId,
  }) : super(
          _initialState(
            initialDate: initialDate,
            children: children,
            initialChildId: initialChildId,
          ),
        );

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
    required List<ChildSummary> children,
    String? initialChildId,
  }) {
    final normalizedDate = _normalizeDate(initialDate);
    final resolvedChildren = List<ChildSummary>.unmodifiable(children);
    final selectedChildId =
        _resolveInitialChildId(resolvedChildren, initialChildId);
    return AddCalendarEventState(
      children: resolvedChildren,
      selectedChildId: selectedChildId,
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

  void selectChild(String? childId) {
    state = state.copyWith(selectedChildId: childId);
  }

  void setTitle(String value) {
    state = state.copyWith(title: value);
  }

  void setMemo(String value) {
    state = state.copyWith(memo: value);
  }

  void toggleAllDay(bool value) {
    final normalizedStart = _normalizeDate(state.startDate);
    if (value) {
      state = state.copyWith(
        allDay: true,
        startDate: normalizedStart,
        endDate: normalizedStart,
      );
      return;
    }

    var nextState = state.copyWith(
      allDay: false,
      startDate: normalizedStart,
      endDate: state.endDate,
    );
    nextState = _ensureEndAfterStart(nextState);
    state = nextState;
  }

  void setStartDate(DateTime date) {
    final normalized = _normalizeDate(date);
    var nextState = state.copyWith(startDate: normalized);
    if (nextState.allDay) {
      nextState = nextState.copyWith(endDate: normalized);
    } else {
      nextState = _ensureEndAfterStart(nextState);
    }
    state = nextState;
  }

  void setEndDate(DateTime date) {
    if (state.allDay) return;
    final normalized = _normalizeDate(date);
    var nextState = state.copyWith(endDate: normalized);
    nextState = _ensureEndAfterStart(nextState);
    state = nextState;
  }

  void setStartTime(TimeOfDay time) {
    if (state.allDay) return;
    var nextState = state.copyWith(startTime: time);
    nextState = _ensureEndAfterStart(nextState);
    state = nextState;
  }

  void setEndTime(TimeOfDay time) {
    if (state.allDay) return;
    var nextState = state.copyWith(endTime: time);
    nextState = _ensureEndAfterStart(nextState);
    state = nextState;
  }

  void selectIcon(String path) {
    if (!state.availableIconPaths.contains(path)) {
      return;
    }
    state = state.copyWith(selectedIconPath: path);
  }

  Future<void> pickDate({
    required BuildContext context,
    required bool isStart,
  }) async {
    final current = isStart ? state.startDate : state.endDate;
    final pickedDate = await DatePicker.showDatePicker(
      context,
      showTitleActions: true,
      currentTime: current,
      locale: LocaleType.jp,
    );
    if (pickedDate == null) {
      return;
    }
    if (isStart) {
      setStartDate(pickedDate);
    } else {
      setEndDate(pickedDate);
    }
  }

  Future<void> pickTime({
    required BuildContext context,
    required bool isStart,
  }) async {
    if (state.allDay) {
      return;
    }

    final referenceDate = isStart ? state.startDate : state.endDate;
    final referenceTime = isStart ? state.startTime : state.endTime;
    final current = DateTime(
      referenceDate.year,
      referenceDate.month,
      referenceDate.day,
      referenceTime.hour,
      referenceTime.minute,
    );

    final picked = await DatePicker.showTimePicker(
      context,
      currentTime: current,
      showTitleActions: true,
      showSecondsColumn: false,
      locale: LocaleType.jp,
    );

    if (picked == null) {
      return;
    }

    final selectedTime = TimeOfDay(hour: picked.hour, minute: picked.minute);
    if (isStart) {
      setStartTime(selectedTime);
    } else {
      setEndTime(selectedTime);
    }
  }

  CalendarEventModel? handleSubmit({
    required GlobalKey<FormState> formKey,
    required String titleValue,
    required String memoValue,
  }) {
    if (!formKey.currentState!.validate()) {
      return null;
    }

    setTitle(titleValue);
    setMemo(memoValue);

    return submit();
  }

  CalendarEventModel? submit() {
    if (!state.hasChildren) {
      state = state.copyWith(
        validationMessage: '子どもを登録してから予定を追加してください。',
      );
      return null;
    }
    final selectedChildId = state.selectedChildId;
    if (selectedChildId == null || selectedChildId.isEmpty) {
      state = state.copyWith(
        validationMessage: '子どもを選択してください。',
      );
      return null;
    }
    final trimmedTitle = state.title.trim();
    if (trimmedTitle.isEmpty) {
      state = state.copyWith(validationMessage: '予定を入力してください');
      return null;
    }

    if (!state.allDay) {
      final start = _combine(state.startDate, state.startTime);
      final end = _combine(state.endDate, state.endTime);
      if (!end.isAfter(start)) {
        state = state.copyWith(
          validationMessage: '終了時間は開始時間より後にしてください。',
        );
        return null;
      }
    }

    final result = CalendarEventModel(
      childId: selectedChildId,
      title: trimmedTitle,
      memo: state.memo.trim(),
      allDay: state.allDay,
      start: state.effectiveStart,
      end: state.effectiveEnd,
      iconPath: state.selectedIconPath,
    );

    state = state.copyWith(validationMessage: null);
    return result;
  }

  static AddCalendarEventState _ensureEndAfterStart(
    AddCalendarEventState current,
  ) {
    final start = _combine(current.startDate, current.startTime);
    final end = _combine(current.endDate, current.endTime);
    if (end.isAfter(start)) {
      return current;
    }

    final fallback = start.add(const Duration(hours: 1));
    final normalizedFallbackDate = _normalizeDate(fallback);
    final fallbackTime =
        TimeOfDay(hour: fallback.hour, minute: fallback.minute);
    return current.copyWith(
      endDate: normalizedFallbackDate,
      endTime: fallbackTime,
    );
  }

  static DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  static DateTime _combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }

  static String? _resolveInitialChildId(
    List<ChildSummary> children,
    String? preferred,
  ) {
    if (children.isEmpty) {
      return null;
    }
    if (preferred == null || preferred.isEmpty) {
      return children.first.id;
    }
    final hasPreferred =
        children.any((child) => child.id == preferred && child.id.isNotEmpty);
    return hasPreferred ? preferred : children.first.id;
  }
}
