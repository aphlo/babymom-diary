import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/application/vaccine_catalog_providers.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/watch_vaccination_records.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/menu/children/application/child_context_provider.dart';
import 'package:babymom_diary/src/features/menu/household/domain/repositories/vaccine_visibility_settings_repository.dart';
import 'package:babymom_diary/src/features/menu/household/infrastructure/repositories/vaccine_visibility_settings_repository_impl.dart';
import 'package:babymom_diary/src/features/menu/household/infrastructure/sources/vaccine_visibility_settings_firestore_data_source.dart';

import '../mappers/vaccine_info_mapper.dart';
import 'vaccines_view_data.dart';

// ワクチン表示設定リポジトリのプロバイダー
final _vaccineVisibilitySettingsRepositoryProvider =
    Provider<VaccineVisibilitySettingsRepository>((ref) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final dataSource = VaccineVisibilitySettingsFirestoreDataSource(firestore);
  return VaccineVisibilitySettingsRepositoryImpl(dataSource: dataSource);
});

final vaccinesViewModelProvider =
    StateNotifierProvider<VaccinesViewModel, AsyncValue<VaccinesViewData>>(
        (ref) {
  final viewModel = VaccinesViewModel(ref);
  return viewModel;
});

class VaccinesViewModel extends StateNotifier<AsyncValue<VaccinesViewData>> {
  VaccinesViewModel(this._ref) : super(const AsyncValue.loading()) {
    _initialize();
  }

  final Ref _ref;

  GetVaccineMaster get _getGuideline => _ref.read(getVaccineGuidelineProvider);
  WatchVaccinationRecords get _watchVaccinationRecords =>
      _ref.read(watchVaccinationRecordsProvider);
  VaccineVisibilitySettingsRepository get _visibilitySettingsRepository =>
      _ref.read(_vaccineVisibilitySettingsRepositoryProvider);

  String? _householdId;
  String? _childId;
  DateTime? _childBirthday;

  StreamSubscription<List<VaccinationRecord>>? _recordSubscription;
  VaccineMaster? _guideline;
  List<VaccinationRecord> _records = const <VaccinationRecord>[];

  void _initialize() {
    _listenToChildContext();
    unawaited(_loadInitialData());
  }

  /// ChildContextProviderを監視し、householdId/子供/子供リストの変更に対応
  void _listenToChildContext() {
    _ref.listen<AsyncValue<ChildContext>>(
      childContextProvider,
      (previous, next) {
        if (!mounted) return;

        final previousContext = previous?.valueOrNull;
        final currentContext = next.valueOrNull;

        if (currentContext == null) return;

        final householdChanged =
            previousContext?.householdId != currentContext.householdId;
        final childChanged =
            previousContext?.selectedChildId != currentContext.selectedChildId;
        final birthdayChanged = previousContext?.selectedChildSummary?.birthday !=
            currentContext.selectedChildSummary?.birthday;

        // householdIdが変わった場合
        if (householdChanged) {
          _householdId = currentContext.householdId;
          _recordSubscription?.cancel();
          _records = const <VaccinationRecord>[];
        }

        // 子供が変わった場合（削除による自動選択を含む）
        if (childChanged || householdChanged) {
          _childId = currentContext.selectedChildId;
          _childBirthday = currentContext.selectedChildSummary?.birthday;
          _recordSubscription?.cancel();
          _records = const <VaccinationRecord>[];

          if (_householdId != null && _childId != null) {
            _subscribeToRecords();
          }
          _emitViewData();
        } else if (birthdayChanged) {
          // 誕生日のみが変わった場合
          _childBirthday = currentContext.selectedChildSummary?.birthday;
          _emitViewData();
        }
      },
      fireImmediately: true,
    );
  }

  Future<void> _loadInitialData() async {
    try {
      // ガイドラインをロード（ChildContextは_listenToChildContextで取得される）
      await _loadGuideline();
    } catch (error, stackTrace) {
      if (!mounted) return;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> _loadGuideline() async {
    try {
      final VaccineMaster guideline = await _getGuideline();
      if (!mounted) return;
      _guideline = guideline;
      _emitViewData();
    } catch (error, stackTrace) {
      if (!mounted) return;
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void _subscribeToRecords() {
    _recordSubscription?.cancel();
    if (_householdId == null || _childId == null) {
      return;
    }
    _recordSubscription = _watchVaccinationRecords(
      householdId: _householdId!,
      childId: _childId!,
    ).listen(
      (List<VaccinationRecord> records) {
        if (!mounted) return;
        _records = records;
        _emitViewData();
      },
      onError: (Object error, StackTrace stackTrace) {
        if (!mounted) return;
        state = AsyncValue.error(error, stackTrace);
      },
    );
  }

  Future<void> _emitViewData() async {
    final VaccineMaster? guideline = _guideline;
    if (guideline == null) {
      return;
    }
    final Map<String, VaccinationRecord> recordMap =
        <String, VaccinationRecord>{
      for (final VaccinationRecord record in _records) record.vaccineId: record,
    };

    // ビューデータを生成
    final viewData = mapGuidelineToViewData(
      guideline,
      recordsByVaccine: recordMap,
      childBirthday: _childBirthday,
    );

    // まず全てのワクチンを表示（フィルタリング前）
    // これにより、visibility settings取得中でもデータが表示される
    if (!mounted) return;
    state = AsyncValue.data(
      VaccinesViewData(
        periodLabels: viewData.periodLabels,
        vaccines: viewData.vaccines,
        version: viewData.version,
        publishedAt: viewData.publishedAt,
        recordsByVaccine: recordMap,
      ),
    );

    // ワクチン表示設定を取得してフィルタリング
    if (_householdId != null) {
      try {
        final settings = await _visibilitySettingsRepository.getSettings(
          householdId: _householdId!,
        );

        if (!mounted) return;

        // 表示されるべきワクチンのみをフィルタリング
        final filteredVaccines = viewData.vaccines
            .where((vaccine) => settings.isVisible(vaccine.id))
            .toList();

        state = AsyncValue.data(
          VaccinesViewData(
            periodLabels: viewData.periodLabels,
            vaccines: filteredVaccines,
            version: viewData.version,
            publishedAt: viewData.publishedAt,
            recordsByVaccine: recordMap,
          ),
        );
      } catch (error) {
        // フィルタリングに失敗しても、既に全ワクチンが表示されているので何もしない
      }
    }
  }

  Future<void> refresh() async {
    await _loadGuideline();
  }

  @override
  void dispose() {
    _recordSubscription?.cancel();
    super.dispose();
  }
}
