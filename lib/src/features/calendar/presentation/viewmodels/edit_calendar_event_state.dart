import 'package:flutter/foundation.dart';

@immutable
class EditCalendarEventState {
  const EditCalendarEventState({
    required this.eventId,
    required this.title,
    required this.memo,
    required this.allDay,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.selectedIconPath,
    required this.availableIconPaths,
    this.validationMessage,
    this.isSubmitting = false,
    this.isDeleting = false,
  });

  final String eventId;
  final String title;
  final String memo;
  final bool allDay;
  final DateTime startDate;
  final TimeOfDay startTime;
  final DateTime endDate;
  final TimeOfDay endTime;
  final String selectedIconPath;
  final List<String> availableIconPaths;
  final String? validationMessage;
  final bool isSubmitting;
  final bool isDeleting;

  bool get canSubmit => title.trim().isNotEmpty && !isSubmitting && !isDeleting;

  bool get canDelete => !isSubmitting && !isDeleting;

  DateTime get effectiveStart {
    if (allDay) {
      return DateTime(startDate.year, startDate.month, startDate.day);
    }
    return DateTime(
      startDate.year,
      startDate.month,
      startDate.day,
      startTime.hour,
      startTime.minute,
    );
  }

  DateTime get effectiveEnd {
    if (allDay) {
      return DateTime(endDate.year, endDate.month, endDate.day, 23, 59, 59);
    }
    return DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
      endTime.hour,
      endTime.minute,
    );
  }

  EditCalendarEventState copyWith({
    String? eventId,
    String? title,
    String? memo,
    bool? allDay,
    DateTime? startDate,
    TimeOfDay? startTime,
    DateTime? endDate,
    TimeOfDay? endTime,
    String? selectedIconPath,
    List<String>? availableIconPaths,
    String? validationMessage,
    bool? isSubmitting,
    bool? isDeleting,
  }) {
    return EditCalendarEventState(
      eventId: eventId ?? this.eventId,
      title: title ?? this.title,
      memo: memo ?? this.memo,
      allDay: allDay ?? this.allDay,
      startDate: startDate ?? this.startDate,
      startTime: startTime ?? this.startTime,
      endDate: endDate ?? this.endDate,
      endTime: endTime ?? this.endTime,
      selectedIconPath: selectedIconPath ?? this.selectedIconPath,
      availableIconPaths: availableIconPaths ?? this.availableIconPaths,
      validationMessage: validationMessage,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      isDeleting: isDeleting ?? this.isDeleting,
    );
  }
}

class TimeOfDay {
  const TimeOfDay({required this.hour, required this.minute});

  final int hour;
  final int minute;

  static TimeOfDay fromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }

  TimeOfDay copyWith({int? hour, int? minute}) {
    return TimeOfDay(
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is TimeOfDay && other.hour == hour && other.minute == minute;
  }

  @override
  int get hashCode => hour.hashCode ^ minute.hashCode;
}
