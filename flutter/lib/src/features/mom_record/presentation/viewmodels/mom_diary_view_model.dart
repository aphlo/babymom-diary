import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

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
    StateNotifierProvider.autoDispose<MomDiaryViewModel, MomDiaryPageState>(
  (ref) => MomDiaryViewModel(ref),
);

class MomDiaryViewModel extends StateNotifier<MomDiaryPageState> {
  MomDiaryViewModel(this._ref) : super(MomDiaryPageState.initial()) {
    _initialize();
  }

  final Ref _ref;
  GetMomDiaryMonthlyEntries? _getUseCase;
  WatchMomDiaryForDate? _watchUseCase;
  SaveMomDiaryEntry? _saveUseCase;
  StreamSubscription<MomDiaryEntry>? _editingDiarySubscription;

  /// 現在編集中の日付（リアルタイム監視対象）
  DateTime? _editingDate;

  /// 月間日記のキャッシュ（UI更新用）
  MomDiaryMonthlyUiModel? _monthlyDiaryCache;

  void _initialize() {
    final recordState = _ref.read(momRecordViewModelProvider);
    _loadMonthlyDiary(recordState.focusMonth);

    _ref.listen<MomRecordPageState>(
      momRecordViewModelProvider,
      (previous, next) {
        if (previous?.focusMonth == next.focusMonth) {
          return;
        }
        stopEditingDiary();
        _loadMonthlyDiary(next.focusMonth);
      },
      fireImmediately: false,
    );
  }

  /// 月間日記を一度だけ取得（リアルタイム更新なし）
  Future<void> _loadMonthlyDiary(DateTime month) async {
    final normalized = _normalizeMonth(month);
    if (!mounted) return;
    state = state.copyWith(
      focusMonth: normalized,
      monthlyDiary: const AsyncValue.loading(),
    );

    try {
      final useCase = await _requireGetUseCase();
      final result = await useCase(
        year: normalized.year,
        month: normalized.month,
      );
      if (!mounted) return;
      _monthlyDiaryCache = MomDiaryMonthlyUiModel.fromDomain(result);
      state = state.copyWith(
        monthlyDiary: AsyncValue.data(_monthlyDiaryCache!),
      );
    } catch (error, stackTrace) {
      if (!mounted) return;
      state = state.copyWith(
        monthlyDiary: AsyncValue.error(error, stackTrace),
      );
    }
  }

  /// 編集中の日付をリアルタイムで監視開始
  Future<void> startEditingDiary(DateTime date) async {
    _editingDiarySubscription?.cancel();
    _editingDate = date;

    try {
      final useCase = await _requireWatchUseCase();
      _editingDiarySubscription = useCase(date: date).listen(
        (entry) {
          if (!mounted) return;
          _updateEntryInCache(entry);
        },
        onError: (error, stackTrace) {
          // 編集中のエラーは無視（キャッシュデータを使用）
        },
      );
    } catch (error) {
      // UseCase取得エラーは無視
    }
  }

  /// 編集終了時にリアルタイム監視を停止
  void stopEditingDiary() {
    _editingDiarySubscription?.cancel();
    _editingDiarySubscription = null;
    _editingDate = null;
  }

  /// キャッシュ内の特定日付のエントリを更新
  void _updateEntryInCache(MomDiaryEntry entry) {
    final cache = _monthlyDiaryCache;
    if (cache == null) return;

    // 同じ月のデータかチェック
    if (entry.date.year != state.focusMonth.year ||
        entry.date.month != state.focusMonth.month) {
      return;
    }

    // キャッシュ内のエントリを更新
    final updatedEntries = cache.entries.map((e) {
      if (e.date.day == entry.date.day) {
        return MomDiaryEntryUiModel.fromDomain(entry);
      }
      return e;
    }).toList();

    _monthlyDiaryCache = MomDiaryMonthlyUiModel(
      year: cache.year,
      month: cache.month,
      entries: updatedEntries,
    );
    state = state.copyWith(
      monthlyDiary: AsyncValue.data(_monthlyDiaryCache!),
    );
  }

  Future<void> saveEntry(MomDiaryEntry entry) async {
    final saveUseCase = await _requireSaveUseCase();
    await saveUseCase(entry);
    // 編集中の日付ならリアルタイム更新される
    // そうでなければ手動で月間データを再取得
    if (_editingDate == null ||
        _editingDate!.day != entry.date.day ||
        _editingDate!.month != entry.date.month ||
        _editingDate!.year != entry.date.year) {
      _loadMonthlyDiary(state.focusMonth);
    }
  }

  /// エラー時の再読み込み用
  void reloadCurrentMonth() {
    _loadMonthlyDiary(state.focusMonth);
  }

  Future<GetMomDiaryMonthlyEntries> _requireGetUseCase() async {
    final existing = _getUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase =
        _ref.read(getMomDiaryMonthlyEntriesUseCaseProvider(householdId));
    _getUseCase = useCase;
    return useCase;
  }

  Future<WatchMomDiaryForDate> _requireWatchUseCase() async {
    final existing = _watchUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase = _ref.read(watchMomDiaryForDateUseCaseProvider(householdId));
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
    _editingDiarySubscription?.cancel();
    super.dispose();
  }
}
