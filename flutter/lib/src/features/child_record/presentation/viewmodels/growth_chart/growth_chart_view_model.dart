import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../menu/children/application/child_context_provider.dart';
import '../../../../menu/children/domain/entities/child_summary.dart';
import '../../../../menu/growth_chart_settings/application/growth_chart_settings_provider.dart';
import '../../../child_record.dart';
import '../../mappers/growth_chart_ui_mapper.dart';
import '../../models/growth_chart_data.dart';
import '../../models/growth_measurement_point.dart';
import '../../providers/growth_chart/growth_chart_providers.dart';
import 'growth_chart_state.dart';

part 'growth_chart_view_model.g.dart';

@Riverpod(keepAlive: true)
class GrowthChartViewModel extends _$GrowthChartViewModel {
  StreamSubscription<List<GrowthRecord>>? _recordsSubscription;
  List<GrowthRecord> _records = const <GrowthRecord>[];
  List<GrowthMeasurementPoint> _measurementPoints =
      const <GrowthMeasurementPoint>[];
  List<GrowthMeasurementPoint> _allMeasurementPoints =
      const <GrowthMeasurementPoint>[];
  List<GrowthCurvePoint> _heightCurve = const <GrowthCurvePoint>[];
  List<GrowthCurvePoint> _weightCurve = const <GrowthCurvePoint>[];
  bool _curvesLoaded = false;

  static const _mapper = GrowthChartUiMapper();

  @override
  GrowthChartState build() {
    ref.onDispose(() {
      _recordsSubscription?.cancel();
    });

    _listenToChildContext();
    _listenToSettingsChanges();

    // 初期状態を構築（childContextから初期値を取得）
    final childContext = ref.read(childContextProvider).value;
    final summary = childContext?.selectedChildSummary;

    if (summary != null) {
      // 子供が選択されている場合は初期化処理をスケジュール
      Future.microtask(() => _initializeForChild(summary));
    }

    return GrowthChartState.initial().copyWith(
      childSummary: summary,
      isLoadingChild: childContext == null,
    );
  }

  String? get _householdId => ref.read(childContextProvider).value?.householdId;

  void _initializeForChild(ChildSummary summary) {
    _subscribeToGrowthRecords(summary.id);
    _loadCurvesForCurrentChild();
  }

  void _listenToChildContext() {
    ref.listen<AsyncValue<ChildContext>>(
      childContextProvider,
      (previous, next) {
        next.when(
          data: (context) {
            final summary = context.selectedChildSummary;
            _handleChildSummaryChange(
              summary,
              previousSummary: previous?.value?.selectedChildSummary,
            );
          },
          loading: () {
            // loading中は何もしない
          },
          error: (error, stackTrace) {
            state = state.copyWith(
              childSummary: null,
              isLoadingChild: false,
              chartData: const AsyncValue<GrowthChartData>.data(
                GrowthChartData.empty,
              ),
            );
          },
        );
      },
    );
  }

  void _listenToSettingsChanges() {
    ref.listen<bool>(
      growthChartSettingsProvider,
      (previous, next) {
        if (previous == next) {
          return;
        }
        _rebuildMeasurements();
      },
    );
  }

  void _handleChildSummaryChange(
    ChildSummary? summary, {
    ChildSummary? previousSummary,
  }) {
    final childChanged = summary?.id != previousSummary?.id;
    final genderChanged = summary?.gender != previousSummary?.gender;
    final birthdayChanged = summary?.birthday != previousSummary?.birthday;
    final dueDateChanged = summary?.dueDate != previousSummary?.dueDate;

    state = state.copyWith(
      childSummary: summary,
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
    final householdId = _householdId;
    if (householdId == null) {
      return;
    }
    final watchUseCase =
        ref.read(watchGrowthRecordsUseCaseProvider(householdId));
    _records = const <GrowthRecord>[];
    _measurementPoints = const <GrowthMeasurementPoint>[];
    _allMeasurementPoints = const <GrowthMeasurementPoint>[];
    _recordsSubscription = watchUseCase(childId).listen(
      (records) {
        _records = records;
        _rebuildMeasurements();
      },
      onError: (error, stackTrace) {
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
    final getCurves = ref.read(getGrowthCurvesUseCaseProvider);
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
      _heightCurve = result.height;
      _weightCurve = result.weight;
      _curvesLoaded = true;
      _emitChartData();
    } catch (error, stackTrace) {
      state = state.copyWith(
        chartData: AsyncValue.error(error, stackTrace),
      );
    }
  }

  void _rebuildMeasurements() {
    final summary = state.childSummary;
    final birthday = summary?.birthday;
    final dueDate = summary?.dueDate;
    final useCorrectedAge = ref.read(growthChartSettingsProvider);

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
    if (!_curvesLoaded) {
      return;
    }
    final filteredMeasurements = _mapper.filterMeasurementsByRange(
      _measurementPoints,
      state.selectedAgeRange,
    );
    final data = GrowthChartData(
      heightCurve: _heightCurve,
      weightCurve: _weightCurve,
      measurements: filteredMeasurements,
      allMeasurements: _allMeasurementPoints,
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
    final addUseCase = ref.read(addGrowthRecordUseCaseProvider(householdId));
    await addUseCase(record);
  }

  Future<void> addWeightRecord({
    required DateTime recordedAt,
    required double weightGrams,
    required WeightUnit weightUnit,
    String? note,
  }) async {
    final householdId = _householdId;
    final child = state.childSummary;
    if (householdId == null || child == null) {
      throw StateError('Cannot add weight record without household and child.');
    }

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
      weightUnit: weightUnit,
      note: sanitizedNote,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    final addUseCase = ref.read(addGrowthRecordUseCaseProvider(householdId));
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
        ref.read(updateGrowthRecordUseCaseProvider(householdId));
    await updateUseCase(updated);
    _replaceLocalRecord(updated);
  }

  Future<void> updateWeightRecord({
    required String recordId,
    required DateTime recordedAt,
    required double weightGrams,
    required WeightUnit weightUnit,
    String? note,
  }) async {
    final record = _requireRecord(recordId);
    final householdId = _householdId;
    if (householdId == null) {
      throw StateError('Cannot update weight record without household.');
    }

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
      weightUnit: weightUnit,
      note: sanitizedNote,
      updatedAt: DateTime.now(),
    );
    final updateUseCase =
        ref.read(updateGrowthRecordUseCaseProvider(householdId));
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
        ref.read(deleteGrowthRecordUseCaseProvider(householdId));
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
}
