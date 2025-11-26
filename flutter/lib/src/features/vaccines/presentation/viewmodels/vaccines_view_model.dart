import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/application/vaccine_catalog_providers.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/watch_vaccination_records.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_provider.dart';
import 'package:babymom_diary/src/features/menu/children/application/selected_child_snapshot_provider.dart';
import 'package:babymom_diary/src/features/menu/children/domain/entities/child_summary.dart';
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
    _listenToHouseholdChange();
    _listenToSelectedChild();
    unawaited(_loadInitialData());
  }

  /// 選択中の子供のスナップショット（誕生日など）の変更を監視
  void _listenToChildSnapshot(String householdId) {
    _ref.listen<AsyncValue<ChildSummary?>>(
      selectedChildSnapshotProvider(householdId),
      (previous, next) {
        if (!mounted) return;
        next.whenData((summary) {
          // 選択中の子供の誕生日が変わった場合のみ更新
          if (summary?.id == _childId) {
            final newBirthday = summary?.birthday;
            if (newBirthday != _childBirthday) {
              _childBirthday = newBirthday;
              _emitViewData();
            }
          }
        });
      },
      fireImmediately: true,
    );
  }

  void _listenToHouseholdChange() {
    _ref.listen<AsyncValue<String>>(
      currentHouseholdIdProvider,
      (previous, next) {
        if (!mounted) return;
        final newHouseholdId = next.valueOrNull;
        final previousHouseholdId = previous?.valueOrNull;

        if (newHouseholdId != previousHouseholdId) {
          _householdId = newHouseholdId;
          // 世帯が変わった場合、レコード購読を再設定
          _recordSubscription?.cancel();
          _records = const <VaccinationRecord>[];

          // 世帯が変わったら、child snapshotのリスナーを再設定
          if (newHouseholdId != null) {
            _listenToChildSnapshot(newHouseholdId);
          }

          if (_householdId != null && _childId != null) {
            _subscribeToRecords();
          }
          _emitViewData();
        }
      },
    );
  }

  void _listenToSelectedChild() {
    _ref.listen<AsyncValue<String?>>(
      selectedChildControllerProvider,
      (previous, next) {
        if (!mounted) return;
        // loading状態の場合はスキップ
        if (next.isLoading) return;

        final newChildId = next.valueOrNull;
        if (newChildId == _childId) return;

        _childId = newChildId;
        _recordSubscription?.cancel();
        _records = const <VaccinationRecord>[];

        // 子供が変わった場合、誕生日をリセット
        // （実際の誕生日は _listenToChildSnapshot で更新される）
        _childBirthday = null;

        if (_householdId != null && _childId != null) {
          _subscribeToRecords();
        }
        _emitViewData();
      },
      fireImmediately: true,
    );
  }

  Future<void> _loadInitialData() async {
    try {
      final householdId = await _ref.read(currentHouseholdIdProvider.future);
      if (!mounted) return;
      _householdId = householdId;

      // 選択された子供を取得
      final childId = await _ref.read(selectedChildControllerProvider.future);
      if (!mounted) return;
      _childId = childId;

      // 子供のスナップショット（誕生日など）の監視を開始
      _listenToChildSnapshot(householdId);

      // ガイドラインをロード
      await _loadGuideline();

      // レコードを購読
      if (_householdId != null && _childId != null) {
        _subscribeToRecords();
      }
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
