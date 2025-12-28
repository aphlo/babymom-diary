import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/dose_record.dart';

part 'vaccine_detail_state.freezed.dart';

@freezed
sealed class DoseStatusInfo with _$DoseStatusInfo {
  const factory DoseStatusInfo({
    required int doseNumber,
    DoseStatus? status,
    DateTime? scheduledDate,
    String? reservationGroupId,
  }) = _DoseStatusInfo;
}

@freezed
sealed class DoseRecommendationInfo with _$DoseRecommendationInfo {
  const factory DoseRecommendationInfo({
    required int doseNumber,
    required String message,
    DateTime? startDate,
    DateTime? endDate,
  }) = _DoseRecommendationInfo;
}

@freezed
sealed class VaccineDetailState with _$VaccineDetailState {
  const factory VaccineDetailState({
    @Default(false) bool isLoading,
    String? error,
    @Default(<int, DoseStatusInfo>{}) Map<int, DoseStatusInfo> doseStatuses,
    @Default(<int>[]) List<int> doseNumbers,
    int? activeDoseNumber,
    int? pendingDoseNumber,
    DoseRecommendationInfo? recommendation,
  }) = _VaccineDetailState;
}

@freezed
sealed class VaccineDetailParams with _$VaccineDetailParams {
  const factory VaccineDetailParams({
    required String vaccineId,
    required List<int> doseNumbers,
    required String householdId,
    required String childId,
    required DateTime? childBirthday,
  }) = _VaccineDetailParams;
}
