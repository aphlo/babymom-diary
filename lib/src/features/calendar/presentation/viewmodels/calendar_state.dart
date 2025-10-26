// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:babymom_diary/src/features/children/domain/entities/child_summary.dart';

@immutable
class CalendarUiEvent {
  const CalendarUiEvent._({this.message, this.openAddEvent, this.openSettings});

  final String? message;
  final AddEventRequest? openAddEvent;
  final bool? openSettings;

  const CalendarUiEvent.showMessage(String message)
      : this._(message: message, openAddEvent: null, openSettings: null);

  const CalendarUiEvent.openAddEvent(AddEventRequest request)
      : this._(message: null, openAddEvent: request, openSettings: null);

  const CalendarUiEvent.openSettings()
      : this._(message: null, openAddEvent: null, openSettings: true);
}

@immutable
class AddEventRequest {
  const AddEventRequest({
    required this.initialDate,
    required this.children,
    required this.initialChildId,
  });

  final DateTime initialDate;
  final List<ChildSummary> children;
  final String? initialChildId;
}

@immutable
class CalendarState {
  CalendarState({
    required this.focusedDay,
    required this.selectedDay,
    required Map<DateTime, List<CalendarEvent>> eventsByDay,
    required this.eventsAsync,
    required this.householdId,
    required List<ChildSummary> availableChildren,
    required this.selectedChildId,
    required this.calendarSettings,
    this.pendingUiEvent,
  })  : eventsByDay =
            Map<DateTime, List<CalendarEvent>>.unmodifiable(eventsByDay.map(
          (key, value) =>
              MapEntry(key, List<CalendarEvent>.unmodifiable(value)),
        )),
        availableChildren = List<ChildSummary>.unmodifiable(availableChildren);

  final DateTime focusedDay;
  final DateTime selectedDay;
  final Map<DateTime, List<CalendarEvent>> eventsByDay;
  final AsyncValue<List<CalendarEvent>> eventsAsync;
  final String? householdId;
  final List<ChildSummary> availableChildren;
  final String? selectedChildId;
  final CalendarSettings calendarSettings;
  final CalendarUiEvent? pendingUiEvent;

  bool get isLoadingEvents => eventsAsync.isLoading;

  bool get hasError => eventsAsync.hasError;

  Object? get loadError => eventsAsync.whenOrNull(error: (error, __) => error);

  String get monthLabel {
    return DateFormat.yMMMM('ja').format(focusedDay);
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

  CalendarState copyWith({
    DateTime? focusedDay,
    DateTime? selectedDay,
    Map<DateTime, List<CalendarEvent>>? eventsByDay,
    AsyncValue<List<CalendarEvent>>? eventsAsync,
    String? householdId,
    List<ChildSummary>? availableChildren,
    String? selectedChildId,
    CalendarSettings? calendarSettings,
    CalendarUiEvent? pendingUiEvent,
  }) {
    return CalendarState(
      focusedDay: focusedDay ?? this.focusedDay,
      selectedDay: selectedDay ?? this.selectedDay,
      eventsByDay: eventsByDay ?? this.eventsByDay,
      eventsAsync: eventsAsync ?? this.eventsAsync,
      householdId: householdId ?? this.householdId,
      availableChildren: availableChildren ?? this.availableChildren,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      calendarSettings: calendarSettings ?? this.calendarSettings,
      pendingUiEvent: pendingUiEvent,
    );
  }

  static CalendarState initial() {
    final now = DateTime.now();
    final normalized = DateTime(now.year, now.month, now.day);
    final initialEvents =
        AsyncValue<List<CalendarEvent>>.data(const <CalendarEvent>[]);
    final eventsByDay = <DateTime, List<CalendarEvent>>{};
    final children = <ChildSummary>[];
    return CalendarState(
      focusedDay: normalized,
      selectedDay: normalized,
      eventsByDay: eventsByDay,
      eventsAsync: initialEvents,
      householdId: null,
      availableChildren: children,
      selectedChildId: null,
      calendarSettings:
          const CalendarSettings(startingDayOfWeek: false), // デフォルトは日曜始まり
      pendingUiEvent: null,
    );
  }
}
