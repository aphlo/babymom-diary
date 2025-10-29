import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/household_service.dart' as fbcore;
import '../../../children/application/selected_child_snapshot_provider.dart';
import '../../../children/domain/entities/child_summary.dart';
import '../../child_record.dart';
import '../../infrastructure/repositories/growth_curve_repository_impl.dart';
import '../../infrastructure/repositories/growth_record_repository_impl.dart';
import '../../infrastructure/sources/asset_growth_curve_data_source.dart';
import '../../infrastructure/sources/growth_record_firestore_data_source.dart';
import '../../application/usecases/get_growth_curves.dart';
import '../../application/usecases/watch_growth_records.dart';
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
    } else if (birthdayChanged) {
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
    final birthday = state.childSummary?.birthday;
    _measurementPoints = _mapper.toMeasurementPoints(
      records: _records,
      birthday: birthday,
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
    final data = GrowthChartData(
      heightCurve: _heightCurve,
      weightCurve: _weightCurve,
      measurements: filteredMeasurements,
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

  @override
  void dispose() {
    _recordsSubscription?.cancel();
    super.dispose();
  }
}
