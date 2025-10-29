import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mom_record_ui_model.dart';

@immutable
class MomRecordPageState {
  const MomRecordPageState({
    required this.focusMonth,
    required this.monthlyRecords,
    required this.selectedTabIndex,
    this.householdId,
  });

  final DateTime focusMonth;
  final AsyncValue<MomMonthlyRecordUiModel> monthlyRecords;
  final int selectedTabIndex;
  final String? householdId;

  MomRecordPageState copyWith({
    DateTime? focusMonth,
    AsyncValue<MomMonthlyRecordUiModel>? monthlyRecords,
    int? selectedTabIndex,
    String? householdId,
  }) {
    return MomRecordPageState(
      focusMonth: focusMonth ?? this.focusMonth,
      monthlyRecords: monthlyRecords ?? this.monthlyRecords,
      selectedTabIndex: selectedTabIndex ?? this.selectedTabIndex,
      householdId: householdId ?? this.householdId,
    );
  }

  static MomRecordPageState initial() {
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
