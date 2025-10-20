import 'package:flutter/material.dart';

import 'package:babymom_diary/src/features/children/domain/entities/child_summary.dart';

class AddCalendarEventState {
  AddCalendarEventState({
    required List<ChildSummary> children,
    required this.selectedChildId,
    required this.title,
    required this.memo,
    required this.allDay,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.selectedIconPath,
    required this.isSubmitting,
    required this.validationMessage,
    required List<String> availableIconPaths,
  })  : children = List<ChildSummary>.unmodifiable(children),
        availableIconPaths = List<String>.unmodifiable(availableIconPaths);

  final List<ChildSummary> children;
  final String? selectedChildId;
  final String title;
  final String memo;
  final bool allDay;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String selectedIconPath;
  final bool isSubmitting;
  final String? validationMessage;
  final List<String> availableIconPaths;

  bool get hasChildren => children.isNotEmpty;

  bool get canSubmit =>
      hasChildren &&
      selectedChildId != null &&
      selectedChildId!.isNotEmpty &&
      title.trim().isNotEmpty;

  DateTime get normalizedStartDate =>
      DateTime(startDate.year, startDate.month, startDate.day);

  DateTime get normalizedEndDate =>
      DateTime(endDate.year, endDate.month, endDate.day);

  DateTime get effectiveStart {
    if (allDay) {
      return normalizedStartDate;
    }
    return _combine(normalizedStartDate, startTime);
  }

  DateTime get effectiveEnd {
    if (allDay) {
      return normalizedStartDate.add(const Duration(hours: 23, minutes: 59));
    }
    return _combine(normalizedEndDate, endTime);
  }

  AddCalendarEventState copyWith({
    List<ChildSummary>? children,
    String? selectedChildId,
    String? title,
    String? memo,
    bool? allDay,
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? selectedIconPath,
    bool? isSubmitting,
    String? validationMessage,
    List<String>? availableIconPaths,
  }) {
    return AddCalendarEventState(
      children: children ?? this.children,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      title: title ?? this.title,
      memo: memo ?? this.memo,
      allDay: allDay ?? this.allDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      selectedIconPath: selectedIconPath ?? this.selectedIconPath,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      validationMessage: validationMessage,
      availableIconPaths: availableIconPaths ?? this.availableIconPaths,
    );
  }

  static DateTime _combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
