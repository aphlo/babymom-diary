import 'package:meta/meta.dart';

@immutable
class ConcurrentVaccineMember {
  const ConcurrentVaccineMember({
    required this.vaccineId,
    required this.vaccineName,
    required this.doseId,
    required this.doseNumber,
  });

  final String vaccineId;
  final String vaccineName;
  final String doseId;
  final int doseNumber; // UI表示用
}

@immutable
class ConcurrentVaccinesState {
  const ConcurrentVaccinesState({
    this.isLoading = false,
    this.error,
    this.members = const <ConcurrentVaccineMember>[],
  });

  final bool isLoading;
  final String? error;
  final List<ConcurrentVaccineMember> members;

  ConcurrentVaccinesState copyWith({
    bool? isLoading,
    String? error,
    List<ConcurrentVaccineMember>? members,
    bool clearError = false,
  }) {
    return ConcurrentVaccinesState(
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
      members: members ?? this.members,
    );
  }
}

@immutable
class ConcurrentVaccinesParams {
  const ConcurrentVaccinesParams({
    required this.householdId,
    required this.childId,
    required this.reservationGroupId,
    required this.currentVaccineId,
    required this.currentDoseId,
  });

  final String householdId;
  final String childId;
  final String reservationGroupId;
  final String currentVaccineId;
  final String currentDoseId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ConcurrentVaccinesParams &&
          runtimeType == other.runtimeType &&
          householdId == other.householdId &&
          childId == other.childId &&
          reservationGroupId == other.reservationGroupId &&
          currentVaccineId == other.currentVaccineId &&
          currentDoseId == other.currentDoseId;

  @override
  int get hashCode => Object.hash(
        householdId,
        childId,
        reservationGroupId,
        currentVaccineId,
        currentDoseId,
      );
}
