import 'package:babymom_diary/src/core/utils/date_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:babymom_diary/src/features/menu/children/domain/entities/child_summary.dart';

part 'calendar_state.freezed.dart';

@freezed
sealed class CalendarUiEvent with _$CalendarUiEvent {
  const factory CalendarUiEvent.showMessage(String message) = _ShowMessage;
  const factory CalendarUiEvent.openAddEvent(AddEventRequest request) =
      _OpenAddEvent;
  const factory CalendarUiEvent.openSettings() = _OpenSettings;
}

@freezed
sealed class AddEventRequest with _$AddEventRequest {
  const factory AddEventRequest({
    required DateTime initialDate,
    required List<ChildSummary> children,
    required String? initialChildId,
  }) = _AddEventRequest;
}

@freezed
sealed class CalendarState with _$CalendarState {
  const CalendarState._();

  const factory CalendarState({
    required DateTime focusedDay,
    required DateTime selectedDay,
    required Map<DateTime, List<CalendarEvent>> eventsByDay,
    required AsyncValue<List<CalendarEvent>> eventsAsync,
    required String? householdId,
    required List<ChildSummary> availableChildren,
    required String? selectedChildId,
    required CalendarSettings calendarSettings,
    CalendarUiEvent? pendingUiEvent,
  }) = _CalendarState;

  factory CalendarState.initial() {
    final now = DateTime.now();
    final normalized = DateTime(now.year, now.month, now.day);
    final initialEvents =
        AsyncValue<List<CalendarEvent>>.data(const <CalendarEvent>[]);
    final eventsByDay = <DateTime, List<CalendarEvent>>{};
    final children = <ChildSummary>[];
    return CalendarState(
      focusedDay: normalized,
      selectedDay: normalized,
      eventsByDay: _normalizeEventsByDay(eventsByDay),
      eventsAsync: initialEvents,
      householdId: null,
      availableChildren: List<ChildSummary>.unmodifiable(children),
      selectedChildId: null,
      calendarSettings:
          const CalendarSettings(startingDayOfWeek: false), // デフォルトは日曜始まり
      pendingUiEvent: null,
    );
  }

  bool get isLoadingEvents => eventsAsync.isLoading;

  bool get hasError => eventsAsync.hasError;

  Object? get loadError => eventsAsync.whenOrNull(error: (error, __) => error);

  String get monthLabel {
    return DateFormatter.yyyyMM(focusedDay);
  }

  List<CalendarEvent> eventsForSelectedDay() {
    final key = DateTime(
      selectedDay.year,
      selectedDay.month,
      selectedDay.day,
    );
    final list = eventsByDay[key] ?? const <CalendarEvent>[];
    return list.toList()..sort((a, b) => a.start.compareTo(b.start));
  }

  List<CalendarEvent> eventsForDay(DateTime day) {
    final key = DateTime(day.year, day.month, day.day);
    return eventsByDay[key] ?? const <CalendarEvent>[];
  }
}

Map<DateTime, List<CalendarEvent>> _normalizeEventsByDay(
  Map<DateTime, List<CalendarEvent>> eventsByDay,
) {
  return Map<DateTime, List<CalendarEvent>>.unmodifiable(
    eventsByDay.map(
      (key, value) => MapEntry(
        key,
        List<CalendarEvent>.unmodifiable(value),
      ),
    ),
  );
}
