import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_calendar_event_state.freezed.dart';

@freezed
sealed class AddCalendarEventState with _$AddCalendarEventState {
  const AddCalendarEventState._();

  const factory AddCalendarEventState({
    required String title,
    required String memo,
    required bool allDay,
    required DateTime startDate,
    required DateTime endDate,
    required TimeOfDay startTime,
    required TimeOfDay endTime,
    required String selectedIconPath,
    required bool isSubmitting,
    String? titleError,
    String? dateTimeError,
    required List<String> availableIconPaths,
  }) = _AddCalendarEventState;

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

  static DateTime _combine(DateTime date, TimeOfDay time) {
    return DateTime(date.year, date.month, date.day, time.hour, time.minute);
  }
}
