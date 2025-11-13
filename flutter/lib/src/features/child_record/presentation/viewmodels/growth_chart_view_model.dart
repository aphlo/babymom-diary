import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/household_service.dart' as fbcore;
import '../../../menu/children/application/selected_child_snapshot_provider.dart';
import '../../../menu/children/domain/entities/child_summary.dart';
import '../../child_record.dart';
import '../../infrastructure/repositories/growth_curve_repository_impl.dart';
import '../../infrastructure/repositories/growth_record_repository_impl.dart';
import '../../infrastructure/sources/asset_growth_curve_data_source.dart';
import '../../infrastructure/sources/growth_record_firestore_data_source.dart';
import '../../application/usecases/add_growth_record.dart';
import '../../application/usecases/delete_growth_record.dart';
import '../../application/usecases/get_growth_curves.dart';
import '../../application/usecases/update_growth_record.dart';
import '../../application/usecases/watch_growth_records.dart';
import '../../application/growth_chart_settings_provider.dart';
import '../mappers/growth_chart_ui_mapper.dart';
import '../models/growth_chart_data.dart';
import '../models/growth_measurement_point.dart';
import 'growth_chart_state.dart';

final growthChartUiMapperProvider = Provider<GrowthChartUiMapper>((ref) {
  return const GrowthChartUiMapper();
});

final _assetGrowthCurveDataSourceProvider =
    Provider<AssetGrowthCurveDataSource>((ref) {
  return AssetGrowthCurveDataSource();
});

final growthCurveRepositoryProvider = Provider<GrowthCurveRepository>((ref) {
  final dataSource = ref.watch(_assetGrowthCurveDataSourceProvider);
  return GrowthCurveRepositoryImpl(assetDataSource: dataSource);
});

final getGrowthCurvesUseCaseProvider = Provider<GetGrowthCurves>((ref) {
  final repo = ref.watch(growthCurveRepositoryProvider);
  return GetGrowthCurves(repo);
});

final _growthRecordDataSourceProvider =
    Provider.family<GrowthRecordFirestoreDataSource, String>((ref, hid) {
  final db = ref.watch(fbcore.firebaseFirestoreProvider);
  return GrowthRecordFirestoreDataSource(db, hid);
});

final growthRecordRepositoryProvider =
    Provider.family<GrowthRecordRepository, String>((ref, hid) {
  final remote = ref.watch(_growthRecordDataSourceProvider(hid));
  return GrowthRecordRepositoryImpl(remote: remote);
});

final watchGrowthRecordsUseCaseProvider =
    Provider.family<WatchGrowthRecords, String>((ref, hid) {
  final repo = ref.watch(growthRecordRepositoryProvider(hid));
  return WatchGrowthRecords(repo);
});

final addGrowthRecordUseCaseProvider =
    Provider.family<AddGrowthRecord, String>((ref, hid) {
  final repo = ref.watch(growthRecordRepositoryProvider(hid));
  return AddGrowthRecord(repo);
});

final updateGrowthRecordUseCaseProvider =
    Provider.family<UpdateGrowthRecord, String>((ref, hid) {
  final repo = ref.watch(growthRecordRepositoryProvider(hid));
  return UpdateGrowthRecord(repo);
});

final deleteGrowthRecordUseCaseProvider =
    Provider.family<DeleteGrowthRecord, String>((ref, hid) {
  final repo = ref.watch(growthRecordRepositoryProvider(hid));
  return DeleteGrowthRecord(repo);
});

final growthChartViewModelProvider =
    StateNotifierProvider<GrowthChartViewModel, GrowthChartState>((ref) {
  final mapper = ref.watch(growthChartUiMapperProvider);
  return GrowthChartViewModel(ref, mapper);
});

class GrowthChartViewModel extends StateNotifier<GrowthChartState> {
  GrowthChartViewModel(this._ref, this._mapper)
      : super(GrowthChartState.initial()) {
    _initialize();
  }

  final Ref _ref;
  final GrowthChartUiMapper _mapper;

  StreamSubscription<List<GrowthRecord>>? _recordsSubscription;
  List<GrowthRecord> _records = const <GrowthRecord>[];
  List<GrowthMeasurementPoint> _measurementPoints =
      const <GrowthMeasurementPoint>[];
  List<GrowthMeasurementPoint> _allMeasurementPoints =
      const <GrowthMeasurementPoint>[];
  List<GrowthCurvePoint> _heightCurve = const <GrowthCurvePoint>[];
  List<GrowthCurvePoint> _weightCurve = const <GrowthCurvePoint>[];
  bool _curvesLoaded = false;
  String? _householdId;

  void _initialize() {
    Future<void>(() async {
      try {
        final hid = await _ref.read(fbcore.currentHouseholdIdProvider.future);
        if (!mounted) {
          return;
        }
        _householdId = hid;
        _listenToSelectedChild(hid);
        _listenToSettingsChanges();
      } catch (error, stackTrace) {
        if (!mounted) {
          return;
        }
        state = state.copyWith(
          chartData: AsyncValue.error(error, stackTrace),
          isLoadingChild: false,
        );
      }
    });
  }

  void _listenToSettingsChanges() {
    _ref.listen<bool>(
      growthChartSettingsProvider,
      (previous, next) {
        if (!mounted || previous == next) {
          return;
        }
        // Rebuild measurements when corrected age setting changes
        _rebuildMeasurements();
      },
    );
  }

  void _listenToSelectedChild(String householdId) {
    _ref.listen<AsyncValue<ChildSummary?>>(
      selectedChildSnapshotProvider(householdId),
      (previous, next) {
        if (!mounted) {
          return;
        }
        final summary = next.valueOrNull;
        _handleChildSummaryChange(summary);
      },
      fireImmediately: true,
    );
  }

  void _handleChildSummaryChange(ChildSummary? summary) {
    final previous = state.childSummary;
    final childChanged = summary?.id != previous?.id;
    final genderChanged = summary?.gender != previous?.gender;
    final birthdayChanged = summary?.birthday != previous?.birthday;
    final dueDateChanged = summary?.dueDate != previous?.dueDate;

    state = state.copyWith(
      childSummary: summary,
      replaceChildSummary: true,
      isLoadingChild: false,
    );

    if (summary == null) {
      _recordsSubscription?.cancel();
      _recordsSubscription = null;
      _records = const <GrowthRecord>[];
      _measurementPoints = const <GrowthMeasurementPoint>[];
      _allMeasurementPoints = const <GrowthMeasurementPoint>[];
      _heightCurve = const <GrowthCurvePoint>[];
      _weightCurve = const <GrowthCurvePoint>[];
      _curvesLoaded = false;
      state = state.copyWith(
        chartData: const AsyncValue<GrowthChartData>.data(
          GrowthChartData.empty,
        ),
      );
      return;
    }

    if (childChanged) {
      _subscribeToGrowthRecords(summary.id);
    } else if (birthdayChanged || dueDateChanged) {
      _rebuildMeasurements();
    }

    if (childChanged || genderChanged) {
      _loadCurvesForCurrentChild();
    }
  }

  void _subscribeToGrowthRecords(String childId) {
    _recordsSubscription?.cancel();
    final hid = _householdId;
    if (hid == null) {
      return;
    }
    final watchUseCase = _ref.read(watchGrowthRecordsUseCaseProvider(hid));
    _records = const <GrowthRecord>[];
    _measurementPoints = const <GrowthMeasurementPoint>[];
    _allMeasurementPoints = const <GrowthMeasurementPoint>[];
    _recordsSubscription = watchUseCase(childId).listen(
      (records) {
        _records = records;
        _rebuildMeasurements();
      },
      onError: (error, stackTrace) {
        if (!mounted) {
          return;
        }
        state = state.copyWith(
          chartData: AsyncValue.error(error, stackTrace),
        );
      },
    );
  }

  Future<void> _loadCurvesForCurrentChild() async {
    final summary = state.childSummary;
    if (summary == null) {
      return;
    }
    final getCurves = _ref.read(getGrowthCurvesUseCaseProvider);
    final range = state.selectedAgeRange;
    _curvesLoaded = false;
    state = state.copyWith(
      chartData: const AsyncValue<GrowthChartData>.loading(),
    );
    try {
      final result = await getCurves(
        gender: summary.gender,
        ageRange: range,
      );
      if (!mounted) {
        return;
      }
      _heightCurve = result.height;
      _weightCurve = result.weight;
      _curvesLoaded = true;
      _emitChartData();
    } catch (error, stackTrace) {
      if (!mounted) {
        return;
      }
      state = state.copyWith(
        chartData: AsyncValue.error(error, stackTrace),
      );
    }
  }

  void _rebuildMeasurements() {
    final summary = state.childSummary;
    final birthday = summary?.birthday;
    final dueDate = summary?.dueDate;
    final useCorrectedAge = _ref.read(growthChartSettingsProvider);

    _measurementPoints = _mapper.toMeasurementPoints(
      records: _records,
      birthday: birthday,
      useCorrectedAge: useCorrectedAge,
      dueDate: dueDate,
    );
    _allMeasurementPoints = _mapper.toAllMeasurementPoints(
      records: _records,
      birthday: birthday,
      useCorrectedAge: useCorrectedAge,
      dueDate: dueDate,
    );
    _emitChartData();
  }

  void _emitChartData() {
    if (!_curvesLoaded || !mounted) {
      return;
    }
    final filteredMeasurements = _mapper.filterMeasurementsByRange(
      _measurementPoints,
      state.selectedAgeRange,
    );
    final allFilteredMeasurements = _mapper.filterMeasurementsByRange(
      _allMeasurementPoints,
      state.selectedAgeRange,
    );
    final data = GrowthChartData(
      heightCurve: _heightCurve,
      weightCurve: _weightCurve,
      measurements: filteredMeasurements,
      allMeasurements: allFilteredMeasurements,
    );
    state = state.copyWith(
      chartData: AsyncValue.data(data),
    );
  }

  Future<void> changeAgeRange(AgeRange range) async {
    if (range == state.selectedAgeRange) {
      return;
    }
    state = state.copyWith(selectedAgeRange: range);
    await _loadCurvesForCurrentChild();
  }

  Future<void> addHeightRecord({
    required DateTime recordedAt,
    required double heightCm,
    String? note,
  }) async {
    final householdId = _householdId;
    final child = state.childSummary;
    if (householdId == null || child == null) {
      throw StateError('Cannot add height record without household and child.');
    }

    // Check for duplicate height record on the same date
    final normalizedDate = _normalizeDate(recordedAt);
    final hasDuplicate = _records.any((record) =>
        record.recordedAt == normalizedDate && record.height != null);

    if (hasDuplicate) {
      throw DuplicateGrowthRecordException(
        recordType: GrowthRecordType.height,
        recordedAt: normalizedDate,
      );
    }

    final sanitizedNote = _sanitizeNote(note);
    final record = GrowthRecord(
      childId: child.id,
      recordedAt: normalizedDate,
      height: heightCm,
      note: sanitizedNote,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final addUseCase = _ref.read(addGrowthRecordUseCaseProvider(householdId));
    await addUseCase(record);
  }

  Future<void> addWeightRecord({
    required DateTime recordedAt,
    required double weightGrams,
    String? note,
  }) async {
    final householdId = _householdId;
    final child = state.childSummary;
    if (householdId == null || child == null) {
      throw StateError('Cannot add weight record without household and child.');
    }

    // Check for duplicate weight record on the same date
    final normalizedDate = _normalizeDate(recordedAt);
    final hasDuplicate = _records.any((record) =>
        record.recordedAt == normalizedDate && record.weight != null);

    if (hasDuplicate) {
      throw DuplicateGrowthRecordException(
        recordType: GrowthRecordType.weight,
        recordedAt: normalizedDate,
      );
    }

    final sanitizedNote = _sanitizeNote(note);
    final record = GrowthRecord(
      childId: child.id,
      recordedAt: normalizedDate,
      weight: weightGrams,
      note: sanitizedNote,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final addUseCase = _ref.read(addGrowthRecordUseCaseProvider(householdId));
    await addUseCase(record);
  }

  Future<void> updateHeightRecord({
    required String recordId,
    required DateTime recordedAt,
    required double heightCm,
    String? note,
  }) async {
    final record = _requireRecord(recordId);
    final householdId = _householdId;
    if (householdId == null) {
      throw StateError('Cannot update height record without household.');
    }

    // Check for duplicate height record on the same date (excluding current record)
    final normalizedDate = _normalizeDate(recordedAt);
    final hasDuplicate = _records.any((r) =>
        r.id != recordId && r.recordedAt == normalizedDate && r.height != null);

    if (hasDuplicate) {
      throw DuplicateGrowthRecordException(
        recordType: GrowthRecordType.height,
        recordedAt: normalizedDate,
      );
    }

    final sanitizedNote = _sanitizeNote(note ?? record.note);
    final updated = record.copyWith(
      recordedAt: normalizedDate,
      height: heightCm,
      note: sanitizedNote,
      updatedAt: DateTime.now(),
    );
    final updateUseCase =
        _ref.read(updateGrowthRecordUseCaseProvider(householdId));
    await updateUseCase(updated);
    _replaceLocalRecord(updated);
  }

  Future<void> updateWeightRecord({
    required String recordId,
    required DateTime recordedAt,
    required double weightGrams,
    String? note,
  }) async {
    final record = _requireRecord(recordId);
    final householdId = _householdId;
    if (householdId == null) {
      throw StateError('Cannot update weight record without household.');
    }

    // Check for duplicate weight record on the same date (excluding current record)
    final normalizedDate = _normalizeDate(recordedAt);
    final hasDuplicate = _records.any((r) =>
        r.id != recordId && r.recordedAt == normalizedDate && r.weight != null);

    if (hasDuplicate) {
      throw DuplicateGrowthRecordException(
        recordType: GrowthRecordType.weight,
        recordedAt: normalizedDate,
      );
    }

    final sanitizedNote = _sanitizeNote(note ?? record.note);
    final updated = record.copyWith(
      recordedAt: normalizedDate,
      weight: weightGrams,
      note: sanitizedNote,
      updatedAt: DateTime.now(),
    );
    final updateUseCase =
        _ref.read(updateGrowthRecordUseCaseProvider(householdId));
    await updateUseCase(updated);
    _replaceLocalRecord(updated);
  }

  Future<void> deleteGrowthRecord(String recordId) async {
    final child = state.childSummary;
    final householdId = _householdId;
    if (child == null || householdId == null) {
      throw StateError('Cannot delete record without household and child.');
    }
    final deleteUseCase =
        _ref.read(deleteGrowthRecordUseCaseProvider(householdId));
    await deleteUseCase(childId: child.id, recordId: recordId);
    _removeLocalRecord(recordId);
  }

  DateTime _normalizeDate(DateTime input) {
    return DateTime(input.year, input.month, input.day);
  }

  String? _sanitizeNote(String? note) {
    final trimmed = note?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  GrowthRecord _requireRecord(String recordId) {
    try {
      return _records.firstWhere((record) => record.id == recordId);
    } catch (_) {
      throw StateError('Growth record not found: $recordId');
    }
  }

  void _replaceLocalRecord(GrowthRecord record) {
    final index = _records.indexWhere((element) => element.id == record.id);
    if (index == -1) {
      return;
    }
    final updated = List<GrowthRecord>.from(_records);
    updated[index] = record;
    _records = updated;
    _rebuildMeasurements();
  }

  void _removeLocalRecord(String recordId) {
    final updated = _records
        .where((record) => record.id != recordId)
        .toList(growable: false);
    if (updated.length == _records.length) {
      return;
    }
    _records = updated;
    _rebuildMeasurements();
  }

  @override
  void dispose() {
    _recordsSubscription?.cancel();
    super.dispose();
  }
}
