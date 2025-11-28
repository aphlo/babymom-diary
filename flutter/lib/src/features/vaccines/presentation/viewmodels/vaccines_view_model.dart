import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/application/vaccine_catalog_providers.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/watch_vaccination_records.dart';
import 'package:babymom_diary/src/features/menu/children/application/child_context_provider.dart';
import 'package:babymom_diary/src/features/menu/household/application/vaccine_visibility_settings_provider.dart';

import '../mappers/vaccine_info_mapper.dart';
import '../models/vaccines_view_data.dart';

part 'vaccines_view_model.g.dart';

@Riverpod(keepAlive: true)
class VaccinesViewModel extends _$VaccinesViewModel {
  StreamSubscription<List<VaccinationRecord>>? _recordSubscription;
  VaccineMaster? _guideline;
  List<VaccinationRecord> _records = const <VaccinationRecord>[];

  String? _householdId;
  String? _childId;
  DateTime? _childBirthday;

  GetVaccineMaster get _getGuideline => ref.read(getVaccineGuidelineProvider);
  WatchVaccinationRecords get _watchVaccinationRecords =>
      ref.read(watchVaccinationRecordsProvider);

  @override
  AsyncValue<VaccinesViewData> build() {
    ref.onDispose(() {
      _recordSubscription?.cancel();
    });

    _listenToChildContext();

    // 初期状態を構築（childContextから初期値を取得）
    final childContext = ref.read(childContextProvider).value;
    if (childContext != null) {
      _householdId = childContext.householdId;
      _childId = childContext.selectedChildId;
      _childBirthday = childContext.selectedChildSummary?.birthday;

      // 初期化処理をスケジュール
      Future.microtask(() => _initializeData());
    } else {
      // childContextがまだない場合も初期化を試みる
      Future.microtask(() => _loadGuideline());
    }

    return const AsyncValue.loading();
  }

  Future<void> _initializeData() async {
    await _loadGuideline();
    if (_householdId != null && _childId != null) {
      _subscribeToRecords();
    }
  }

  /// ChildContextProviderを監視し、householdId/子供/子供リストの変更に対応
  void _listenToChildContext() {
    ref.listen<AsyncValue<ChildContext>>(
      childContextProvider,
      (previous, next) {
        final previousContext = previous?.value;
        final currentContext = next.value;

        if (currentContext == null) return;

        final householdChanged =
            previousContext?.householdId != currentContext.householdId;
        final childChanged =
            previousContext?.selectedChildId != currentContext.selectedChildId;
        final birthdayChanged =
            previousContext?.selectedChildSummary?.birthday !=
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
    );
  }

  Future<void> _loadGuideline() async {
    try {
      final VaccineMaster guideline = await _getGuideline();
      _guideline = guideline;
      _emitViewData();
    } catch (error, stackTrace) {
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
        _records = records;
        _emitViewData();
      },
      onError: (Object error, StackTrace stackTrace) {
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
        final settings = await ref
            .read(vaccineVisibilitySettingsRepositoryProvider)
            .getSettings(householdId: _householdId!);

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
}
