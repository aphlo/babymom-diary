import 'package:flutter/material.dart';

class AddCalendarEventState {
  AddCalendarEventState({
    required this.title,
    required this.memo,
    required this.allDay,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.selectedIconPath,
    required this.isSubmitting,
    required this.titleError,
    required this.dateTimeError,
    required List<String> availableIconPaths,
  }) : availableIconPaths = List<String>.unmodifiable(availableIconPaths);

  final String title;
  final String memo;
  final bool allDay;
  final DateTime startDate;
  final DateTime endDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String selectedIconPath;
  final bool isSubmitting;
  final String? titleError;
  final String? dateTimeError;
  final List<String> availableIconPaths;

  bool get canSubmit {
    if (title.trim().isEmpty) return false;

    // 終了日時が開始日時より後であることをチェック
    final start = effectiveStart;
    final end = effectiveEnd;
    if (!end.isAfter(start)) return false;

    return true;
  }

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
      return normalizedEndDate.add(const Duration(hours: 23, minutes: 59));
    }
    return _combine(normalizedEndDate, endTime);
  }

  AddCalendarEventState copyWith({
    String? title,
    String? memo,
    bool? allDay,
    DateTime? startDate,
    DateTime? endDate,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? selectedIconPath,
    bool? isSubmitting,
    String? titleError,
    String? dateTimeError,
    List<String>? availableIconPaths,
  }) {
    return AddCalendarEventState(
      title: title ?? this.title,
      memo: memo ?? this.memo,
      allDay: allDay ?? this.allDay,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      selectedIconPath: selectedIconPath ?? this.selectedIconPath,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      titleError: titleError,
      dateTimeError: dateTimeError,
      availableIconPaths: availableIconPaths ?? this.availableIconPaths,
    );
  }

  static DateTime _combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
