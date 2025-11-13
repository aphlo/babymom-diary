import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mom_diary_ui_model.dart';

@immutable
class MomDiaryPageState {
  const MomDiaryPageState({
    required this.focusMonth,
    required this.monthlyDiary,
    this.householdId,
  });

  final DateTime focusMonth;
  final AsyncValue<MomDiaryMonthlyUiModel> monthlyDiary;
  final String? householdId;

  MomDiaryPageState copyWith({
    DateTime? focusMonth,
    AsyncValue<MomDiaryMonthlyUiModel>? monthlyDiary,
    String? householdId,
  }) {
    return MomDiaryPageState(
      focusMonth: focusMonth ?? this.focusMonth,
      monthlyDiary: monthlyDiary ?? this.monthlyDiary,
      householdId: householdId ?? this.householdId,
    );
  }

  static MomDiaryPageState initial() {
    final now = DateTime.now();
    final normalized = DateTime(now.year, now.month);
    return MomDiaryPageState(
      focusMonth: normalized,
      monthlyDiary: const AsyncValue.loading(),
      householdId: null,
    );
  }

  bool isSameMonth(DateTime other) {
    return focusMonth.year == other.year && focusMonth.month == other.month;
  }
}
