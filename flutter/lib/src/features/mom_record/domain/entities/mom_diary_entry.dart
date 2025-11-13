import 'package:flutter/foundation.dart';

@immutable
class MomDiaryEntry {
  MomDiaryEntry({
    required this.date,
    this.content,
  }) : assert(
          _isDateOnly(date),
          'date must be provided as a date-only value (time at 00:00).',
        );

  final DateTime date;
  final String? content;

  MomDiaryEntry copyWith({
    DateTime? date,
    String? content,
  }) {
    return MomDiaryEntry(
      date: date ?? this.date,
      content: content ?? this.content,
    );
  }

  static bool _isDateOnly(DateTime value) {
    return value.hour == 0 &&
        value.minute == 0 &&
        value.second == 0 &&
        value.millisecond == 0 &&
        value.microsecond == 0;
  }
}
