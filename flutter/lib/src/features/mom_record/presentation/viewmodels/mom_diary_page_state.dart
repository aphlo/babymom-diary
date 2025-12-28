import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/mom_diary_ui_model.dart';

part 'mom_diary_page_state.freezed.dart';

@freezed
sealed class MomDiaryPageState with _$MomDiaryPageState {
  const MomDiaryPageState._();

  const factory MomDiaryPageState({
    required DateTime focusMonth,
    required AsyncValue<MomDiaryMonthlyUiModel> monthlyDiary,
    String? householdId,
  }) = _MomDiaryPageState;

  factory MomDiaryPageState.initial() {
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
