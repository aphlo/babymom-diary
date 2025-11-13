import 'package:flutter/foundation.dart';

import 'mom_diary_entry.dart';

@immutable
class MomDiaryMonth {
  MomDiaryMonth({
    required this.year,
    required this.month,
    required List<MomDiaryEntry> entries,
  })  : assert(month >= 1 && month <= 12, 'month must be between 1 and 12.'),
        entries = List<MomDiaryEntry>.unmodifiable(
          (List<MomDiaryEntry>.from(entries)
            ..sort((a, b) => a.date.compareTo(b.date))),
        ) {
    assert(
      entries.every(
        (entry) => entry.date.year == year && entry.date.month == month,
      ),
      'All entries must belong to the same month.',
    );
  }

  final int year;
  final int month;
  final List<MomDiaryEntry> entries;

  DateTime get monthStart => DateTime(year, month);

  DateTime get monthEnd =>
      DateTime(year, month + 1).subtract(const Duration(days: 1));
}
