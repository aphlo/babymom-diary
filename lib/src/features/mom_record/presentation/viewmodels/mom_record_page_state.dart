import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/mom_record_ui_model.dart';

@immutable
class MomRecordPageState {
  const MomRecordPageState({
    required this.focusMonth,
    required this.monthlyRecords,
    this.householdId,
  });

  final DateTime focusMonth;
  final AsyncValue<MomMonthlyRecordUiModel> monthlyRecords;
  final String? householdId;

  MomRecordPageState copyWith({
    DateTime? focusMonth,
    AsyncValue<MomMonthlyRecordUiModel>? monthlyRecords,
    String? householdId,
  }) {
    return MomRecordPageState(
      focusMonth: focusMonth ?? this.focusMonth,
      monthlyRecords: monthlyRecords ?? this.monthlyRecords,
      householdId: householdId ?? this.householdId,
    );
  }

  static MomRecordPageState initial() {
    final now = DateTime.now();
    final normalized = DateTime(now.year, now.month);
    return MomRecordPageState(
      focusMonth: normalized,
      monthlyRecords: const AsyncValue.loading(),
      householdId: null,
    );
  }

  String get monthLabel =>
      '${focusMonth.year}年${focusMonth.month.toString().padLeft(2, '0')}月';

  bool get hasHousehold => householdId != null;
}
