import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/vaccines/application/usecases/get_vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/application/vaccine_catalog_providers.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/application/usecases/watch_vaccination_records.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart';
import 'package:babymom_diary/src/features/children/application/selected_child_provider.dart';

import '../mappers/vaccine_info_mapper.dart';
import 'vaccines_view_data.dart';

final vaccinesViewModelProvider = AutoDisposeStateNotifierProvider<
    VaccinesViewModel, AsyncValue<VaccinesViewData>>((ref) {
  final getGuideline = ref.watch(getVaccineGuidelineProvider);
  final watchVaccinationRecords = ref.watch(watchVaccinationRecordsProvider);
  final String? householdId = ref.watch(currentHouseholdIdProvider).value;
  final String? childId = ref.watch(selectedChildControllerProvider).value;

  final viewModel = VaccinesViewModel(
    getGuideline: getGuideline,
    watchVaccinationRecords: watchVaccinationRecords,
    householdId: householdId,
    childId: childId,
  );
  viewModel.initialize();
  return viewModel;
});

class VaccinesViewModel extends StateNotifier<AsyncValue<VaccinesViewData>> {
  VaccinesViewModel({
    required GetVaccineMaster getGuideline,
    required WatchVaccinationRecords watchVaccinationRecords,
    this.householdId,
    this.childId,
  })  : _getGuideline = getGuideline,
        _watchVaccinationRecords = watchVaccinationRecords,
        super(const AsyncValue.loading());

  final GetVaccineMaster _getGuideline;
  final WatchVaccinationRecords _watchVaccinationRecords;
  final String? householdId;
  final String? childId;

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

  void _emitViewData() {
    final VaccineMaster? guideline = _guideline;
    if (guideline == null) {
      return;
    }
    final Map<String, VaccinationRecord> recordMap =
        <String, VaccinationRecord>{
      for (final VaccinationRecord record in _records) record.vaccineId: record,
    };
    state = AsyncValue.data(
      mapGuidelineToViewData(
        guideline,
        recordsByVaccine: recordMap,
      ),
    );
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
