import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart'
    as fbcore;

import '../../application/mom_record_controller.dart';
import '../../application/usecases/get_mom_monthly_records.dart';
import '../../application/usecases/save_mom_daily_record.dart';
import '../../domain/entities/mom_daily_record.dart';
import '../models/mom_record_ui_model.dart';
import 'mom_record_page_state.dart';

final momRecordViewModelProvider =
    AutoDisposeStateNotifierProvider<MomRecordViewModel, MomRecordPageState>(
  (ref) => MomRecordViewModel(ref),
);

class MomRecordViewModel extends StateNotifier<MomRecordPageState> {
  MomRecordViewModel(this._ref) : super(MomRecordPageState.initial()) {
    unawaited(loadForMonth(state.focusMonth));
  }

  final Ref _ref;
  GetMomMonthlyRecords? _fetchUseCase;
  SaveMomDailyRecord? _saveUseCase;

  Future<void> loadForMonth(DateTime month) async {
    final normalized = _normalizeMonth(month);
    state = state.copyWith(
      focusMonth: normalized,
      monthlyRecords: const AsyncValue.loading(),
    );

    try {
      final useCase = await _requireFetchUseCase();
      final result = await useCase(
        year: normalized.year,
        month: normalized.month,
      );
      final uiModel = MomMonthlyRecordUiModel.fromDomain(result);
      state = state.copyWith(
        monthlyRecords: AsyncValue.data(uiModel),
      );
    } catch (error, stackTrace) {
      state = state.copyWith(
        monthlyRecords: AsyncValue.error(error, stackTrace),
      );
    }
  }

  Future<void> goToPreviousMonth() {
    final current = state.focusMonth;
    final previousMonth = DateTime(current.year, current.month - 1);
    return loadForMonth(previousMonth);
  }

  Future<void> goToNextMonth() {
    final current = state.focusMonth;
    final nextMonth = DateTime(current.year, current.month + 1);
    return loadForMonth(nextMonth);
  }

  Future<void> saveRecord(MomDailyRecord record) async {
    final saveUseCase = await _requireSaveUseCase();
    await saveUseCase(record);
    await loadForMonth(record.date);
  }

  Future<GetMomMonthlyRecords> _requireFetchUseCase() async {
    final existing = _fetchUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase = _ref.read(getMomMonthlyRecordsUseCaseProvider(householdId));
    _fetchUseCase = useCase;
    return useCase;
  }

  Future<SaveMomDailyRecord> _requireSaveUseCase() async {
    final existing = _saveUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase = _ref.read(saveMomDailyRecordUseCaseProvider(householdId));
    _saveUseCase = useCase;
    return useCase;
  }

  Future<String> _ensureHouseholdId() async {
    final existing = state.householdId;
    if (existing != null) {
      return existing;
    }
    final householdId =
        await _ref.read(fbcore.currentHouseholdIdProvider.future);
    state = state.copyWith(householdId: householdId);
    return householdId;
  }

  static DateTime _normalizeMonth(DateTime date) {
    return DateTime(date.year, date.month);
  }
}
