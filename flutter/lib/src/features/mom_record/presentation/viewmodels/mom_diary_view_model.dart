import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart'
    as fbcore;

import '../../application/mom_record_controller.dart';
import '../../application/usecases/get_mom_diary_monthly_entries.dart';
import '../../application/usecases/save_mom_diary_entry.dart';
import '../../domain/entities/mom_diary_entry.dart';
import '../../domain/entities/mom_diary_month.dart';
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
  WatchMomDiaryMonthlyEntries? _watchUseCase;
  SaveMomDiaryEntry? _saveUseCase;
  StreamSubscription<MomDiaryMonth>? _diarySubscription;

  void _initialize() {
    final recordState = _ref.read(momRecordViewModelProvider);
    _subscribeToMonth(recordState.focusMonth);

    _ref.listen<MomRecordPageState>(
      momRecordViewModelProvider,
      (previous, next) {
        if (previous?.focusMonth == next.focusMonth) {
          return;
        }
        _subscribeToMonth(next.focusMonth);
      },
      fireImmediately: false,
    );
  }

  void _subscribeToMonth(DateTime month) {
    _diarySubscription?.cancel();

    final normalized = _normalizeMonth(month);
    if (!mounted) return;
    state = state.copyWith(
      focusMonth: normalized,
      monthlyDiary: const AsyncValue.loading(),
    );

    unawaited(_startSubscription(normalized));
  }

  Future<void> _startSubscription(DateTime month) async {
    try {
      final useCase = await _requireWatchUseCase();
      _diarySubscription = useCase(
        year: month.year,
        month: month.month,
      ).listen(
        (result) {
          if (!mounted) return;
          final uiModel = MomDiaryMonthlyUiModel.fromDomain(result);
          state = state.copyWith(
            monthlyDiary: AsyncValue.data(uiModel),
          );
        },
        onError: (error, stackTrace) {
          if (!mounted) return;
          state = state.copyWith(
            monthlyDiary: AsyncValue.error(error, stackTrace),
          );
        },
      );
    } catch (error, stackTrace) {
      if (!mounted) return;
      state = state.copyWith(
        monthlyDiary: AsyncValue.error(error, stackTrace),
      );
    }
  }

  Future<void> saveEntry(MomDiaryEntry entry) async {
    final saveUseCase = await _requireSaveUseCase();
    await saveUseCase(entry);
    // Streamが自動更新するため手動リロードは不要
  }

  /// エラー時の再読み込み用
  void reloadCurrentMonth() {
    _subscribeToMonth(state.focusMonth);
  }

  Future<WatchMomDiaryMonthlyEntries> _requireWatchUseCase() async {
    final existing = _watchUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase =
        _ref.read(watchMomDiaryMonthlyEntriesUseCaseProvider(householdId));
    _watchUseCase = useCase;
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

  @override
  void dispose() {
    _diarySubscription?.cancel();
    super.dispose();
  }
}
