import 'package:freezed_annotation/freezed_annotation.dart';

import '../../models/weekly_summary_model.dart';

part 'weekly_summary_state.freezed.dart';

@freezed
sealed class WeeklySummaryState with _$WeeklySummaryState {
  const WeeklySummaryState._();

  const factory WeeklySummaryState({
    required DateTime weekStart, // 常に日曜日
  }) = _WeeklySummaryState;

  DateTime get weekEnd => weekStart.add(const Duration(days: 6));

  bool get canGoToNextWeek {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return weekEnd.isBefore(today);
  }

  String get dateRangeLabel {
    final ws = weekStart;
    final we = weekEnd;
    return '${ws.month}/${ws.day}(${_weekdayLabel(ws)})〜${we.month}/${we.day}(${_weekdayLabel(we)})';
  }

  static String _weekdayLabel(DateTime date) {
    const labels = ['月', '火', '水', '木', '金', '土', '日'];
    return labels[date.weekday - 1];
  }

  factory WeeklySummaryState.fromDate(DateTime date) {
    return WeeklySummaryState(
      weekStart: WeeklySummaryData.sundayStartOfWeek(date),
    );
  }
}
