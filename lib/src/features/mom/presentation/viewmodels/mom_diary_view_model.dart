import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart'
    as fbcore;

import '../../application/mom_record_controller.dart';
import '../../application/usecases/get_mom_diary_monthly_entries.dart';
import '../../application/usecases/save_mom_diary_entry.dart';
import '../../domain/entities/mom_diary_entry.dart';
import '../models/mom_diary_ui_model.dart';
import 'mom_diary_page_state.dart';
import 'mom_record_page_state.dart';
import 'mom_record_view_model.dart';

final momDiaryViewModelProvider =
    AutoDisposeStateNotifierProvider<MomDiaryViewModel, MomDiaryPageState>(
  (ref) => MomDiaryViewModel(ref),
);

class MomDiaryViewModel extends StateNotifier<MomDiaryPageState> {
  MomDiaryViewModel(this._ref) : super(MomDiaryPageState.initial()) {
    _initialize();
  }

  final Ref _ref;
  GetMomDiaryMonthlyEntries? _fetchUseCase;
  SaveMomDiaryEntry? _saveUseCase;

  void _initialize() {
    final recordState = _ref.read(momRecordViewModelProvider);
    unawaited(loadForMonth(recordState.focusMonth, keepState: true));

    _ref.listen<MomRecordPageState>(
      momRecordViewModelProvider,
      (previous, next) {
        if (previous?.focusMonth == next.focusMonth) {
          return;
        }
        unawaited(loadForMonth(next.focusMonth));
      },
      fireImmediately: false,
    );
  }

  Future<void> loadForMonth(
    DateTime month, {
    bool keepState = false,
  }) async {
    final normalized = _normalizeMonth(month);
    final previous = keepState
        ? state.monthlyDiary
        : const AsyncValue<MomDiaryMonthlyUiModel>.loading();
    state = state.copyWith(
      focusMonth: normalized,
      monthlyDiary: previous,
    );
    try {
      final useCase = await _requireFetchUseCase();
      final result = await useCase(
        year: normalized.year,
        month: normalized.month,
      );
      final uiModel = MomDiaryMonthlyUiModel.fromDomain(result);
      state = state.copyWith(
        monthlyDiary: AsyncValue.data(uiModel),
      );
    } catch (error, stackTrace) {
      state = state.copyWith(
        monthlyDiary: AsyncValue.error(error, stackTrace),
      );
    }
  }

  Future<void> saveEntry(MomDiaryEntry entry) async {
    final saveUseCase = await _requireSaveUseCase();
    await saveUseCase(entry);
    await loadForMonth(entry.date);
  }

  Future<GetMomDiaryMonthlyEntries> _requireFetchUseCase() async {
    final existing = _fetchUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase =
        _ref.read(getMomDiaryMonthlyEntriesUseCaseProvider(householdId));
    _fetchUseCase = useCase;
    return useCase;
  }

  Future<SaveMomDiaryEntry> _requireSaveUseCase() async {
    final existing = _saveUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase = _ref.read(saveMomDiaryEntryUseCaseProvider(householdId));
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
