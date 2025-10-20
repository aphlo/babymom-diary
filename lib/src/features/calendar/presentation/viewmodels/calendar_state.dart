// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/children/domain/entities/child_summary.dart';

@immutable
class CalendarUiEvent {
  const CalendarUiEvent._({this.message, this.openAddEvent});

  final String? message;
  final AddEventRequest? openAddEvent;

  const CalendarUiEvent.showMessage(String message)
      : this._(message: message, openAddEvent: null);

  const CalendarUiEvent.openAddEvent(AddEventRequest request)
      : this._(message: null, openAddEvent: request);
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
  final CalendarUiEvent? pendingUiEvent;

  bool get isLoadingEvents => eventsAsync.isLoading;

  bool get hasError => eventsAsync.hasError;

  Object? get loadError => eventsAsync.whenOrNull(error: (error, __) => error);

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
      pendingUiEvent: null,
    );
  }
}
