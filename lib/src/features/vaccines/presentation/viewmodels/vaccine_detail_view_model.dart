import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/utils/date_formatter.dart';

import '../../application/usecases/get_vaccine_by_id.dart';
import '../../application/usecases/watch_vaccination_record.dart';
import '../../domain/entities/dose_record.dart';
import '../../domain/entities/vaccination_record.dart';
import '../../domain/entities/vaccine.dart';
import '../../domain/services/vaccination_schedule_policy.dart';
import '../../domain/value_objects/vaccination_recommendation.dart';
import '../../application/vaccine_catalog_providers.dart';
import 'vaccine_detail_state.dart';

class VaccineDetailViewModel extends StateNotifier<VaccineDetailState> {
  VaccineDetailViewModel({
    required WatchVaccinationRecord watchVaccinationRecord,
    required GetVaccineById getVaccineById,
    required VaccinationSchedulePolicy vaccinationSchedulePolicy,
  })  : _watchVaccinationRecord = watchVaccinationRecord,
        _getVaccineById = getVaccineById,
        _vaccinationSchedulePolicy = vaccinationSchedulePolicy,
        super(const VaccineDetailState());

  final WatchVaccinationRecord _watchVaccinationRecord;
  final GetVaccineById _getVaccineById;
  final VaccinationSchedulePolicy _vaccinationSchedulePolicy;

  StreamSubscription<VaccinationRecord?>? _subscription;
  Vaccine? _vaccine;
  DateTime? _childBirthday;
  List<int> _doseNumbers = const <int>[];
  bool _initialized = false;

  void initialize({
    required String householdId,
    required String childId,
    required String vaccineId,
    required List<int> doseNumbers,
    required DateTime? childBirthday,
  }) {
    if (_initialized) {
      return;
    }
    _initialized = true;

    _childBirthday = childBirthday;
    _doseNumbers = List<int>.from(doseNumbers)..sort();

    state = state.copyWith(
      isLoading: true,
      doseStatuses: _buildInitialStatuses(doseNumbers),
      doseNumbers: List<int>.unmodifiable(_doseNumbers),
      activeDoseNumber: doseNumbers.isNotEmpty ? doseNumbers.first : null,
      pendingDoseNumber: _findFirstPendingDose(
        _doseNumbers,
        _buildInitialStatuses(_doseNumbers),
      ),
      clearRecommendation: true,
      clearError: true,
    );

    _prepareDataAndListen(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    );
  }

  Future<void> _prepareDataAndListen({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) async {
    try {
      _vaccine = await _getVaccineById(vaccineId);
      if (_vaccine != null) {
        final derivedDoseNumbers = _collectDoseNumbers(_vaccine!);
        if (derivedDoseNumbers.isNotEmpty) {
          _doseNumbers = derivedDoseNumbers;
          state = state.copyWith(
            doseNumbers: List<int>.unmodifiable(_doseNumbers),
            doseStatuses: _buildInitialStatuses(_doseNumbers),
            activeDoseNumber:
                _doseNumbers.isNotEmpty ? _doseNumbers.first : null,
            pendingDoseNumber:
                _doseNumbers.isNotEmpty ? _doseNumbers.first : null,
            clearRecommendation: true,
          );
        }
      }
    } catch (_) {
      state = state.copyWith(
        error: 'ワクチン情報の取得に失敗しました',
        isLoading: false,
      );
      return;
    }

    _subscription?.cancel();
    _subscription = _watchVaccinationRecord(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    ).listen(
      _handleRecordUpdate,
      onError: (Object error, StackTrace stackTrace) {
        state = state.copyWith(
          isLoading: false,
          error: '接種状況の取得に失敗しました',
        );
      },
    );
  }

  void _handleRecordUpdate(VaccinationRecord? record) {
    if (_doseNumbers.isEmpty) {
      state = state.copyWith(isLoading: false);
      return;
    }

    final Map<int, DoseStatusInfo> statuses =
        _buildDoseStatuses(_doseNumbers, record);
    final int? pendingDose = _findFirstPendingDose(_doseNumbers, statuses);
    final int? activeDose = _resolveActiveDoseNumber(statuses);

    final DoseRecommendationInfo? recommendation =
        _buildRecommendationInfo(pendingDose, record);

    state = state.copyWith(
      isLoading: false,
      doseStatuses: statuses,
      doseNumbers: List<int>.unmodifiable(_doseNumbers),
      activeDoseNumber: activeDose,
      pendingDoseNumber: pendingDose,
      recommendation: recommendation,
      clearRecommendation: recommendation == null,
      clearError: true,
    );
  }

  DoseRecommendationInfo? _buildRecommendationInfo(
    int? pendingDose,
    VaccinationRecord? record,
  ) {
    if (pendingDose == null || _vaccine == null) {
      return null;
    }

    final VaccinationRecommendation? recommendation =
        _vaccinationSchedulePolicy.recommend(
      vaccine: _vaccine!,
      doseNumber: pendingDose,
      record: record,
      childBirthday: _childBirthday,
    );

    if (recommendation == null) {
      return null;
    }

    final String? message = _formatRecommendationMessage(recommendation);
    if (message == null) {
      return null;
    }

    return DoseRecommendationInfo(
      doseNumber: recommendation.doseNumber,
      message: message,
      startDate: recommendation.startDate,
      endDate: recommendation.endDate,
    );
  }

  String? _formatRecommendationMessage(
    VaccinationRecommendation recommendation,
  ) {
    if (recommendation.startDate != null) {
      final String startText =
          DateFormatter.yyyyMMddE(recommendation.startDate!);
      final DateTime? end = recommendation.endDate;
      final String header = '接種時期のめやす';
      if (end == null) {
        return '$header\n$startText以降';
      }
      final String endText = DateFormatter.yyyyMMddE(end);
      if (recommendation.startDate!.isAtSameMomentAs(end)) {
        return '$header\n$startText';
      }
      return '$header\n$startText〜\n$endText';
    }

    if (recommendation.labels.isNotEmpty) {
      return _fallbackRecommendationText(recommendation.labels);
    }

    return null;
  }

  String _fallbackRecommendationText(List<String> labels) {
    if (labels.isEmpty) {
      return '接種時期の情報がありません';
    }
    if (labels.length == 1) {
      return '接種時期のめやす\n${labels.first}ごろ';
    }
    return '接種時期のめやす\n${labels.first} 〜 ${labels.last}ごろ';
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

  int? _findFirstPendingDose(
    List<int> doseNumbers,
    Map<int, DoseStatusInfo> statuses,
  ) {
    for (final int dose in doseNumbers) {
      final DoseStatusInfo? info = statuses[dose];
      if (info == null || info.status == null) {
        return dose;
      }
    }
    return null;
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

  List<int> _collectDoseNumbers(Vaccine vaccine) {
    final Set<int> result = <int>{};
    for (final VaccineScheduleSlot slot in vaccine.schedule) {
      result.addAll(slot.doseNumbers);
    }
    final List<int> sorted = result.toList()..sort();
    return sorted;
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
    final getVaccineById = ref.watch(getVaccineByIdProvider);
    final schedulePolicy = ref.watch(vaccinationSchedulePolicyProvider);
    final viewModel = VaccineDetailViewModel(
      watchVaccinationRecord: watchRecord,
      getVaccineById: getVaccineById,
      vaccinationSchedulePolicy: schedulePolicy,
    );
    viewModel.initialize(
      householdId: params.householdId,
      childId: params.childId,
      vaccineId: params.vaccineId,
      doseNumbers: params.doseNumbers,
      childBirthday: params.childBirthday,
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
    required this.childBirthday,
  });

  final String vaccineId;
  final List<int> doseNumbers;
  final String householdId;
  final String childId;
  final DateTime? childBirthday;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineDetailParams &&
          runtimeType == other.runtimeType &&
          vaccineId == other.vaccineId &&
          householdId == other.householdId &&
          childId == other.childId &&
          _listEquals(doseNumbers, other.doseNumbers) &&
          childBirthday == other.childBirthday;

  @override
  int get hashCode => Object.hash(
        vaccineId,
        householdId,
        childId,
        Object.hashAll(doseNumbers),
        childBirthday,
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
