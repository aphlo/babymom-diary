import 'package:flutter/foundation.dart';

import '../../domain/entities/mom_diary_month.dart';

@immutable
class MomDiaryEntryUiModel {
  const MomDiaryEntryUiModel({
    required this.date,
    required this.dateLabel,
    this.content,
  });

  final DateTime date;
  final String dateLabel;
  final String? content;

  bool get hasContent => content != null && content!.isNotEmpty;
}

@immutable
class MomDiaryMonthlyUiModel {
  MomDiaryMonthlyUiModel({
    required this.year,
    required this.month,
    required List<MomDiaryEntryUiModel> entries,
  }) : entries = List<MomDiaryEntryUiModel>.unmodifiable(entries);

  final int year;
  final int month;
  final List<MomDiaryEntryUiModel> entries;

  String get monthLabel => '$year年${month.toString().padLeft(2, '0')}月';

  static MomDiaryMonthlyUiModel fromDomain(MomDiaryMonth month) {
    return MomDiaryMonthlyUiModel(
      year: month.year,
      month: month.month,
      entries: month.entries
          .map(
            (entry) => MomDiaryEntryUiModel(
              date: entry.date,
              dateLabel: _formatDateLabel(entry.date),
              content: entry.content,
            ),
          )
          .toList(growable: false),
    );
  }
}

String _formatDateLabel(DateTime date) {
  const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
  final weekdayLabel = weekdays[date.weekday - 1];
  return '${date.day}日\n($weekdayLabel)';
}
