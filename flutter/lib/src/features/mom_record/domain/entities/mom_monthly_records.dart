import 'package:flutter/foundation.dart';

import 'mom_daily_record.dart';

@immutable
class MomMonthlyRecords {
  MomMonthlyRecords({
    required this.year,
    required this.month,
    required List<MomDailyRecord> records,
  })  : assert(month >= 1 && month <= 12, 'month must be between 1 and 12.'),
        records = List<MomDailyRecord>.unmodifiable(
          (List<MomDailyRecord>.from(records)
            ..sort((a, b) => a.date.compareTo(b.date))),
        ) {
    assert(
      records.every(
        (record) => record.date.year == year && record.date.month == month,
      ),
      'All records must belong to the same month.',
    );
  }

  final int year;
  final int month;
  final List<MomDailyRecord> records;

  DateTime get monthStart => DateTime(year, month);

  DateTime get monthEnd => DateTime(year, month + 1).subtract(
        const Duration(days: 1),
      );
}
