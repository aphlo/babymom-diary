import 'package:meta/meta.dart';

import '../../domain/entities/dose_record.dart';

@immutable
class DoseStatusInfo {
  const DoseStatusInfo({
    required this.doseNumber,
    this.status,
    this.scheduledDate,
    this.reservationGroupId,
  });

  final int doseNumber;
  final DoseStatus? status;
  final DateTime? scheduledDate;
  final String? reservationGroupId;
}

@immutable
class VaccineDetailState {
  const VaccineDetailState({
    this.isLoading = false,
    this.error,
    this.doseStatuses = const <int, DoseStatusInfo>{},
    this.doseNumbers = const <int>[],
    this.activeDoseNumber,
    this.pendingDoseNumber,
    this.recommendation,
  });

  final bool isLoading;
  final String? error;
  final Map<int, DoseStatusInfo> doseStatuses;
  final List<int> doseNumbers;
  final int? activeDoseNumber;
  final int? pendingDoseNumber;
  final DoseRecommendationInfo? recommendation;

  VaccineDetailState copyWith({
    bool? isLoading,
    String? error,
    Map<int, DoseStatusInfo>? doseStatuses,
    List<int>? doseNumbers,
    int? activeDoseNumber,
    int? pendingDoseNumber,
    DoseRecommendationInfo? recommendation,
    bool clearRecommendation = false,
    bool clearError = false,
  }) {
    return VaccineDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      doseStatuses: doseStatuses ?? this.doseStatuses,
      doseNumbers: doseNumbers ?? this.doseNumbers,
      activeDoseNumber: activeDoseNumber ?? this.activeDoseNumber,
      pendingDoseNumber: pendingDoseNumber ?? this.pendingDoseNumber,
      recommendation:
          clearRecommendation ? null : (recommendation ?? this.recommendation),
    );
  }
}

class DoseRecommendationInfo {
  const DoseRecommendationInfo({
    required this.doseNumber,
    required this.message,
    this.startDate,
    this.endDate,
  });

  final int doseNumber;
  final String message;
  final DateTime? startDate;
  final DateTime? endDate;
}

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
