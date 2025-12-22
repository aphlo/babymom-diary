import 'package:freezed_annotation/freezed_annotation.dart';

part 'edit_calendar_event_state.freezed.dart';

@freezed
sealed class EditCalendarEventState with _$EditCalendarEventState {
  const EditCalendarEventState._();

  const factory EditCalendarEventState({
    required String eventId,
    required String title,
    required String memo,
    required bool allDay,
    required DateTime startDate,
    required TimeOfDay startTime,
    required DateTime endDate,
    required TimeOfDay endTime,
    required String selectedIconPath,
    required List<String> availableIconPaths,
    String? titleError,
    String? dateTimeError,
    @Default(false) bool isSubmitting,
    @Default(false) bool isDeleting,
  }) = _EditCalendarEventState;

  bool get canSubmit {
    if (title.trim().isEmpty || isSubmitting || isDeleting) {
      return false;
    }

    // 終了日時が開始日時より後であることをチェック
    final start = effectiveStart;
    final end = effectiveEnd;
    return end.isAfter(start);
  }

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
}

@freezed
sealed class TimeOfDay with _$TimeOfDay {
  const TimeOfDay._();

  const factory TimeOfDay({
    required int hour,
    required int minute,
  }) = _TimeOfDay;

  factory TimeOfDay.fromDateTime(DateTime dateTime) {
    return TimeOfDay(hour: dateTime.hour, minute: dateTime.minute);
  }
}
