import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/usecases/watch_vaccination_record.dart';
import '../../domain/entities/dose_record.dart';
import '../../domain/entities/vaccination_record.dart';
import '../../application/vaccine_catalog_providers.dart';
import 'vaccine_detail_state.dart';

class VaccineDetailViewModel extends StateNotifier<VaccineDetailState> {
  VaccineDetailViewModel({
    required WatchVaccinationRecord watchVaccinationRecord,
  })  : _watchVaccinationRecord = watchVaccinationRecord,
        super(const VaccineDetailState());

  final WatchVaccinationRecord _watchVaccinationRecord;
  StreamSubscription<VaccinationRecord?>? _subscription;

  void initialize({
    required String householdId,
    required String childId,
    required String vaccineId,
    required List<int> doseNumbers,
  }) {
    state = state.copyWith(
      isLoading: true,
      doseStatuses: _buildInitialStatuses(doseNumbers),
      activeDoseNumber: doseNumbers.isNotEmpty ? doseNumbers.first : null,
      clearError: true,
    );

    _subscription?.cancel();
    _subscription = _watchVaccinationRecord(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    ).listen(
      (record) {
        final statuses = _buildDoseStatuses(doseNumbers, record);
        final activeDose = _resolveActiveDoseNumber(statuses);
        state = state.copyWith(
          isLoading: false,
          doseStatuses: statuses,
          activeDoseNumber: activeDose,
          clearError: true,
        );
      },
      onError: (Object error, StackTrace stackTrace) {
        state = state.copyWith(
          isLoading: false,
          error: '接種状況の取得に失敗しました',
        );
      },
    );
  }

  Map<int, DoseStatusInfo> _buildInitialStatuses(List<int> doseNumbers) {
    final statuses = <int, DoseStatusInfo>{};
    for (final dose in doseNumbers) {
      statuses[dose] = DoseStatusInfo(doseNumber: dose);
    }
    return statuses;
  }

  Map<int, DoseStatusInfo> _buildDoseStatuses(
    List<int> doseNumbers,
    VaccinationRecord? record,
  ) {
    final statuses = <int, DoseStatusInfo>{};
    for (final dose in doseNumbers) {
      final doseRecord = record?.getDose(dose);
      statuses[dose] = DoseStatusInfo(
        doseNumber: dose,
        status: doseRecord?.status,
        scheduledDate: doseRecord?.scheduledDate,
        completedDate: doseRecord?.completedDate,
      );
    }
    return statuses;
  }

  int? _resolveActiveDoseNumber(Map<int, DoseStatusInfo> statuses) {
    if (statuses.isEmpty) return null;

    final sortedDoseNumbers = statuses.keys.toList()..sort();

    final scheduled = sortedDoseNumbers.where((dose) {
      final info = statuses[dose];
      return info?.status == DoseStatus.scheduled;
    });
    if (scheduled.isNotEmpty) {
      return scheduled.first;
    }

    final pending = sortedDoseNumbers.where((dose) {
      final info = statuses[dose];
      return info?.status == null;
    });
    if (pending.isNotEmpty) {
      return pending.first;
    }

    final skipped = sortedDoseNumbers.where((dose) {
      final info = statuses[dose];
      return info?.status == DoseStatus.skipped;
    });
    if (skipped.isNotEmpty) {
      return skipped.first;
    }

    return sortedDoseNumbers.last;
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

final vaccineDetailViewModelProvider = StateNotifierProvider.autoDispose
    .family<VaccineDetailViewModel, VaccineDetailState, VaccineDetailParams>(
  (ref, params) {
    final watchRecord = ref.watch(watchVaccinationRecordProvider);
    final viewModel = VaccineDetailViewModel(
      watchVaccinationRecord: watchRecord,
    );
    viewModel.initialize(
      householdId: params.householdId,
      childId: params.childId,
      vaccineId: params.vaccineId,
      doseNumbers: params.doseNumbers,
    );
    return viewModel;
  },
);

class VaccineDetailParams {
  const VaccineDetailParams({
    required this.vaccineId,
    required this.doseNumbers,
    required this.householdId,
    required this.childId,
  });

  final String vaccineId;
  final List<int> doseNumbers;
  final String householdId;
  final String childId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineDetailParams &&
          runtimeType == other.runtimeType &&
          vaccineId == other.vaccineId &&
          householdId == other.householdId &&
          childId == other.childId &&
          _listEquals(doseNumbers, other.doseNumbers);

  @override
  int get hashCode => Object.hash(
        vaccineId,
        householdId,
        childId,
        Object.hashAll(doseNumbers),
      );

  bool _listEquals(List<int> a, List<int> b) {
    if (identical(a, b)) return true;
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }
}
