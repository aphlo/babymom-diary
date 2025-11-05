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
import 'package:babymom_diary/src/features/vaccines/domain/services/influenza_schedule_generator.dart';
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

final vaccinesViewModelProvider = AutoDisposeStateNotifierProvider<
    VaccinesViewModel, AsyncValue<VaccinesViewData>>((ref) {
  final getGuideline = ref.watch(getVaccineGuidelineProvider);
  final watchVaccinationRecords = ref.watch(watchVaccinationRecordsProvider);
  final influenzaScheduleGenerator =
      ref.watch(influenzaScheduleGeneratorProvider);
  final visibilitySettingsRepository =
      ref.watch(_vaccineVisibilitySettingsRepositoryProvider);
  final String? householdId = ref.watch(currentHouseholdIdProvider).value;
  final String? childId = ref.watch(selectedChildControllerProvider).value;

  // 選択された子供の情報を取得
  final selectedChildSnapshot = householdId != null
      ? ref.watch(selectedChildSnapshotProvider(householdId)).value
      : null;

  final viewModel = VaccinesViewModel(
    getGuideline: getGuideline,
    watchVaccinationRecords: watchVaccinationRecords,
    influenzaScheduleGenerator: influenzaScheduleGenerator,
    visibilitySettingsRepository: visibilitySettingsRepository,
    householdId: householdId,
    childId: childId,
    childBirthday: selectedChildSnapshot?.birthday,
  );
  viewModel.initialize();
  return viewModel;
});

class VaccinesViewModel extends StateNotifier<AsyncValue<VaccinesViewData>> {
  VaccinesViewModel({
    required GetVaccineMaster getGuideline,
    required WatchVaccinationRecords watchVaccinationRecords,
    required InfluenzaScheduleGenerator influenzaScheduleGenerator,
    required VaccineVisibilitySettingsRepository visibilitySettingsRepository,
    this.householdId,
    this.childId,
    this.childBirthday,
  })  : _getGuideline = getGuideline,
        _watchVaccinationRecords = watchVaccinationRecords,
        _influenzaScheduleGenerator = influenzaScheduleGenerator,
        _visibilitySettingsRepository = visibilitySettingsRepository,
        super(const AsyncValue.loading());

  final GetVaccineMaster _getGuideline;
  final WatchVaccinationRecords _watchVaccinationRecords;
  final InfluenzaScheduleGenerator _influenzaScheduleGenerator;
  final VaccineVisibilitySettingsRepository _visibilitySettingsRepository;
  final String? householdId;
  final String? childId;
  final DateTime? childBirthday;

  StreamSubscription<List<VaccinationRecord>>? _recordSubscription;
  VaccineMaster? _guideline;
  List<VaccinationRecord> _records = const <VaccinationRecord>[];
  bool _initialized = false;

  void initialize() {
    if (_initialized) {
      return;
    }
    _initialized = true;
    _loadGuideline();
    _subscribeToRecordsIfAvailable();
  }

  Future<void> _loadGuideline() async {
    state = const AsyncValue.loading();
    try {
      final VaccineMaster guideline = await _getGuideline();
      _guideline = guideline;
      _emitViewData();
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  void _subscribeToRecordsIfAvailable() {
    if (householdId == null || childId == null) {
      return;
    }
    _recordSubscription = _watchVaccinationRecords(
      householdId: householdId!,
      childId: childId!,
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
      influenzaScheduleGenerator: _influenzaScheduleGenerator,
      recordsByVaccine: recordMap,
      childBirthday: childBirthday,
    );

    // ワクチン表示設定を取得してフィルタリング
    if (householdId != null) {
      try {
        final settings = await _visibilitySettingsRepository.getSettings(
          householdId: householdId!,
        );

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
          ),
        );
      } catch (error) {
        // フィルタリングに失敗した場合は全てのワクチンを表示
        state = AsyncValue.data(viewData);
      }
    } else {
      state = AsyncValue.data(viewData);
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
