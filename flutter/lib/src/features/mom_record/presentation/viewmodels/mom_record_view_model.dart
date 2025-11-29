import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/core/firebase/household_service.dart'
    as fbcore;

import '../../application/mom_record_controller.dart';
import '../../application/usecases/get_mom_monthly_records.dart';
import '../../application/usecases/save_mom_daily_record.dart';
import '../../domain/entities/mom_daily_record.dart';
import '../models/mom_record_ui_model.dart';
import 'mom_record_page_state.dart';

part 'mom_record_view_model.g.dart';

@Riverpod(keepAlive: true)
class MomRecordViewModel extends _$MomRecordViewModel {
  GetMomMonthlyRecords? _getUseCase;
  WatchMomRecordForDate? _watchUseCase;
  SaveMomDailyRecord? _saveUseCase;
  StreamSubscription<MomDailyRecord>? _editingRecordSubscription;

  /// 現在編集中の日付（リアルタイム監視対象）
  DateTime? _editingDate;

  /// 月間記録のキャッシュ（UI更新用）
  MomMonthlyRecordUiModel? _monthlyRecordsCache;

  @override
  MomRecordPageState build() {
    ref.onDispose(() {
      _editingRecordSubscription?.cancel();
    });

    final initialState = MomRecordPageState.initial();

    // 初期化処理をスケジュール
    Future.microtask(() => _loadMonthlyRecords(initialState.focusMonth));

    return initialState;
  }

  /// 月間記録を一度だけ取得（リアルタイム更新なし）
  Future<void> _loadMonthlyRecords(DateTime month) async {
    final normalized = _normalizeMonth(month);
    state = state.copyWith(
      focusMonth: normalized,
      monthlyRecords: const AsyncValue.loading(),
    );

    try {
      final useCase = await _requireGetUseCase();
      final result = await useCase(
        year: normalized.year,
        month: normalized.month,
      );
      _monthlyRecordsCache = MomMonthlyRecordUiModel.fromDomain(result);
      state = state.copyWith(
        monthlyRecords: AsyncValue.data(_monthlyRecordsCache!),
      );
    } catch (error, stackTrace) {
      state = state.copyWith(
        monthlyRecords: AsyncValue.error(error, stackTrace),
      );
    }
  }

  /// 編集中の日付をリアルタイムで監視開始
  Future<void> startEditingRecord(DateTime date) async {
    _editingRecordSubscription?.cancel();
    _editingDate = date;

    try {
      final useCase = await _requireWatchUseCase();
      _editingRecordSubscription = useCase(date: date).listen(
        (record) {
          _updateRecordInCache(record);
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
  void stopEditingRecord() {
    _editingRecordSubscription?.cancel();
    _editingRecordSubscription = null;
    _editingDate = null;
  }

  /// キャッシュ内の特定日付のレコードを更新
  void _updateRecordInCache(MomDailyRecord record) {
    final cache = _monthlyRecordsCache;
    if (cache == null) return;

    // 同じ月のデータかチェック
    if (record.date.year != state.focusMonth.year ||
        record.date.month != state.focusMonth.month) {
      return;
    }

    // キャッシュ内のレコードを更新
    final updatedDays = cache.days.map((day) {
      if (day.date.day == record.date.day) {
        return MomDailyRecordUiModel.fromDomain(record);
      }
      return day;
    }).toList();

    _monthlyRecordsCache = MomMonthlyRecordUiModel(
      year: cache.year,
      month: cache.month,
      days: updatedDays,
    );
    state = state.copyWith(
      monthlyRecords: AsyncValue.data(_monthlyRecordsCache!),
    );
  }

  void goToPreviousMonth() {
    stopEditingRecord();
    final current = state.focusMonth;
    final previousMonth = DateTime(current.year, current.month - 1);
    _loadMonthlyRecords(previousMonth);
  }

  void goToNextMonth() {
    stopEditingRecord();
    final current = state.focusMonth;
    final nextMonth = DateTime(current.year, current.month + 1);
    _loadMonthlyRecords(nextMonth);
  }

  void onSelectTab(int index) {
    if (index == state.selectedTabIndex) {
      return;
    }
    state = state.copyWith(selectedTabIndex: index);
  }

  /// エラー時の再読み込み用
  void reloadCurrentMonth() {
    _loadMonthlyRecords(state.focusMonth);
  }

  Future<void> saveRecord(MomDailyRecord record) async {
    final saveUseCase = await _requireSaveUseCase();
    await saveUseCase(record);
    // 編集中の日付ならリアルタイム更新される
    // そうでなければ手動で月間データを再取得
    if (_editingDate == null ||
        _editingDate!.day != record.date.day ||
        _editingDate!.month != record.date.month ||
        _editingDate!.year != record.date.year) {
      _loadMonthlyRecords(state.focusMonth);
    }
  }

  Future<GetMomMonthlyRecords> _requireGetUseCase() async {
    final existing = _getUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase = ref.read(getMomMonthlyRecordsUseCaseProvider(householdId));
    _getUseCase = useCase;
    return useCase;
  }

  Future<WatchMomRecordForDate> _requireWatchUseCase() async {
    final existing = _watchUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase = ref.read(watchMomRecordForDateUseCaseProvider(householdId));
    _watchUseCase = useCase;
    return useCase;
  }

  Future<SaveMomDailyRecord> _requireSaveUseCase() async {
    final existing = _saveUseCase;
    if (existing != null) {
      return existing;
    }
    final householdId = await _ensureHouseholdId();
    final useCase = ref.read(saveMomDailyRecordUseCaseProvider(householdId));
    _saveUseCase = useCase;
    return useCase;
  }

  Future<String> _ensureHouseholdId() async {
    final existing = state.householdId;
    if (existing != null) {
      return existing;
    }
    final householdId =
        await ref.read(fbcore.currentHouseholdIdProvider.future);
    state = state.copyWith(householdId: householdId);
    return householdId;
  }

  static DateTime _normalizeMonth(DateTime date) {
    return DateTime(date.year, date.month);
  }
}
