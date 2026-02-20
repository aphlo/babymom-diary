import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/weekly_summary_model.dart';
import 'weekly_summary_state.dart';

part 'weekly_summary_view_model.g.dart';

@riverpod
class WeeklySummaryViewModel extends _$WeeklySummaryViewModel {
  @override
  WeeklySummaryState build(DateTime initialDate) {
    return WeeklySummaryState(
      weekStart: WeeklySummaryData.sundayStartOfWeek(initialDate),
    );
  }

  void goToPreviousWeek() {
    state = state.copyWith(
      weekStart: state.weekStart.subtract(const Duration(days: 7)),
    );
  }

  void goToNextWeek() {
    if (!state.canGoToNextWeek) return;
    state = state.copyWith(
      weekStart: state.weekStart.add(const Duration(days: 7)),
    );
  }
}
