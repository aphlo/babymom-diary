import 'package:freezed_annotation/freezed_annotation.dart';

part 'concurrent_vaccines_state.freezed.dart';

@freezed
sealed class ConcurrentVaccineMember with _$ConcurrentVaccineMember {
  const factory ConcurrentVaccineMember({
    required String vaccineId,
    required String vaccineName,
    required String doseId,
    required int doseNumber, // UI表示用
  }) = _ConcurrentVaccineMember;
}

@freezed
sealed class ConcurrentVaccinesState with _$ConcurrentVaccinesState {
  const factory ConcurrentVaccinesState({
    @Default(false) bool isLoading,
    String? error,
    @Default(<ConcurrentVaccineMember>[]) List<ConcurrentVaccineMember> members,
  }) = _ConcurrentVaccinesState;
}

@freezed
sealed class ConcurrentVaccinesParams with _$ConcurrentVaccinesParams {
  const factory ConcurrentVaccinesParams({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String currentVaccineId,
    required String currentDoseId,
  }) = _ConcurrentVaccinesParams;
}
