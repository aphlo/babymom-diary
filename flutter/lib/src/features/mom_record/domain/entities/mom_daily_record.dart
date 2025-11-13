import 'package:flutter/foundation.dart';

import '../value_objects/breast_condition.dart';
import '../value_objects/lochia_status.dart';

@immutable
class MomDailyRecord {
  MomDailyRecord({
    required this.date,
    this.temperatureCelsius,
    this.lochia,
    this.breast,
    this.memo,
  }) : assert(
          _isDateOnly(date),
          'date must be provided as a date-only value (time at 00:00).',
        );

  final DateTime date;
  final double? temperatureCelsius;
  final LochiaStatus? lochia;
  final BreastCondition? breast;
  final String? memo;

  MomDailyRecord copyWith({
    DateTime? date,
    double? temperatureCelsius,
    LochiaStatus? lochia,
    BreastCondition? breast,
    String? memo,
  }) {
    return MomDailyRecord(
      date: date ?? this.date,
      temperatureCelsius: temperatureCelsius ?? this.temperatureCelsius,
      lochia: lochia ?? this.lochia,
      breast: breast ?? this.breast,
      memo: memo ?? this.memo,
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
