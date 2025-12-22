import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../models/mom_record_ui_model.dart';

part 'mom_record_page_state.freezed.dart';

@freezed
sealed class MomRecordPageState with _$MomRecordPageState {
  const MomRecordPageState._();

  const factory MomRecordPageState({
    required DateTime focusMonth,
    required AsyncValue<MomMonthlyRecordUiModel> monthlyRecords,
    required int selectedTabIndex,
    String? householdId,
  }) = _MomRecordPageState;

  factory MomRecordPageState.initial() {
    final now = DateTime.now();
    final normalized = DateTime(now.year, now.month);
    return MomRecordPageState(
      focusMonth: normalized,
      monthlyRecords: const AsyncValue.loading(),
      selectedTabIndex: 0,
      householdId: null,
    );
  }

  String get monthLabel =>
      '${focusMonth.year}年${focusMonth.month.toString().padLeft(2, '0')}月';

  bool get hasHousehold => householdId != null;
}
