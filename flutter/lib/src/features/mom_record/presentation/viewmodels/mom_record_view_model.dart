import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart'
    as fbcore;

import '../../application/mom_record_controller.dart';
import '../../application/usecases/get_mom_monthly_records.dart';
import '../../application/usecases/save_mom_daily_record.dart';
import '../../domain/entities/mom_daily_record.dart';
import '../../domain/entities/mom_monthly_records.dart';
import '../models/mom_record_ui_model.dart';
import 'mom_record_page_state.dart';

final momRecordViewModelProvider =
    AutoDisposeStateNotifierProvider<MomRecordViewModel, MomRecordPageState>(
  (ref) => MomRecordViewModel(ref),
);

class MomRecordViewModel extends StateNotifier<MomRecordPageState> {
  MomRecordViewModel(this._ref)
      : _keepAliveLink = _ref.keepAlive(),
        super(MomRecordPageState.initial()) {
    _subscribeToRecords(state.focusMonth);
  }

  final Ref _ref;
  final KeepAliveLink _keepAliveLink;
  WatchMomMonthlyRecords? _watchUseCase;
  SaveMomDailyRecord? _saveUseCase;
  StreamSubscription<MomMonthlyRecords>? _recordsSubscription;

  void _subscribeToRecords(DateTime month) {
    _recordsSubscription?.cancel();

    final normalized = _normalizeMonth(month);
    if (!mounted) return;
    state = state.copyWith(
      focusMonth: normalized,
      monthlyRecords: const AsyncValue.loading(),
    );

    unawaited(_startSubscription(normalized));
  }

  Future<void> _startSubscription(DateTime month) async {
    try {
      final useCase = await _requireWatchUseCase();
      _recordsSubscription = useCase(
        year: month.year,
        month: month.month,
      ).listen(
        (result) {
          if (!mounted) return;
          final uiModel = MomMonthlyRecordUiModel.fromDomain(result);
          state = state.copyWith(
            monthlyRecords: AsyncValue.data(uiModel),
          );
        },
        onError: (error, stackTrace) {
          if (!mounted) return;
          state = state.copyWith(
            monthlyRecords: AsyncValue.error(error, stackTrace),
          );
        },
      );
    } catch (error, stackTrace) {
      if (!mounted) return;
      state = state.copyWith(
        monthlyRecords: AsyncValue.error(error, stackTrace),
      );
    }
  }

  void goToPreviousMonth() {
    final current = state.focusMonth;
    final previousMonth = DateTime(current.year, current.month - 1);
    _subscribeToRecords(previousMonth);
  }

  void goToNextMonth() {
    final current = state.focusMonth;
    final nextMonth = DateTime(current.year, current.month + 1);
    _subscribeToRecords(nextMonth);
  }

  void onSelectTab(int index) {
    if (index == state.selectedTabIndex) {
      return;
    }
    state = state.copyWith(selectedTabIndex: index);
  }

  /// エラー時の再読み込み用
  void reloadCurrentMonth() {
    _subscribeToRecords(state.focusMonth);
  }

  Future<void> saveRecord(MomDailyRecord record) async {
    final saveUseCase = await _requireSaveUseCase();
    await saveUseCase(record);
    // Streamが自動更新するため手動リロードは不要
  }

  Future<WatchMomMonthlyRecords> _requireWatchUseCase() async {
    final existing = _watchUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase =
        _ref.read(watchMomMonthlyRecordsUseCaseProvider(householdId));
    _watchUseCase = useCase;
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

  @override
  void dispose() {
    _recordsSubscription?.cancel();
    _keepAliveLink.close();
    super.dispose();
  }
}
