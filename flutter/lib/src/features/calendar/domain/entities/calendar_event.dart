import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_event.freezed.dart';

@freezed
sealed class CalendarEvent with _$CalendarEvent {
  const CalendarEvent._();

  const factory CalendarEvent({
    required String id,
    required String title,
    required String memo,
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconPath,
    String? householdId,
  }) = _CalendarEvent;

  DateTime get startDateOnly => DateTime(start.year, start.month, start.day);

  DateTime get endDateOnly => DateTime(end.year, end.month, end.day);

  bool occursOn(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    return !d.isBefore(startDateOnly) && !d.isAfter(endDateOnly);
  }
}
