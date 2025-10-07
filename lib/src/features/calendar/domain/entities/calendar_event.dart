import 'package:flutter/foundation.dart';

@immutable
class CalendarEvent {
  const CalendarEvent({
    required this.id,
    required this.title,
    required this.memo,
    required this.allDay,
    required this.start,
    required this.end,
    required this.iconPath,
    required this.childId,
    this.householdId,
    this.childName,
    this.childColorHex,
  });

  final String id;
  final String title;
  final String memo;
  final bool allDay;
  final DateTime start;
  final DateTime end;
  final String iconPath;
  final String childId;
  final String? householdId;
  final String? childName;
  final String? childColorHex;

  CalendarEvent copyWith({
    String? id,
    String? title,
    String? memo,
    bool? allDay,
    DateTime? start,
    DateTime? end,
    String? iconPath,
    String? childId,
    String? householdId,
    String? childName,
    String? childColorHex,
  }) {
    return CalendarEvent(
      id: id ?? this.id,
      title: title ?? this.title,
      memo: memo ?? this.memo,
      allDay: allDay ?? this.allDay,
      start: start ?? this.start,
      end: end ?? this.end,
      iconPath: iconPath ?? this.iconPath,
      childId: childId ?? this.childId,
      householdId: householdId ?? this.householdId,
      childName: childName ?? this.childName,
      childColorHex: childColorHex ?? this.childColorHex,
    );
  }

  DateTime get startDateOnly => DateTime(start.year, start.month, start.day);

  DateTime get endDateOnly => DateTime(end.year, end.month, end.day);

  bool occursOn(DateTime date) {
    final d = DateTime(date.year, date.month, date.day);
    return !d.isBefore(startDateOnly) && !d.isAfter(endDateOnly);
  }
}
