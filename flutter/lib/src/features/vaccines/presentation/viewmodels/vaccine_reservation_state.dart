import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/vaccination_record.dart';
import '../../domain/entities/vaccine_reservation_request.dart';
import '../../domain/value_objects/vaccine_record_type.dart';
import '../models/vaccine_info.dart';

part 'vaccine_reservation_state.freezed.dart';

@freezed
sealed class VaccineReservationState with _$VaccineReservationState {
  const VaccineReservationState._();

  const factory VaccineReservationState({
    @Default(false) bool isLoading,
    String? error,
    @Default(false) bool isDuplicateError,
    VaccineInfo? primaryVaccine,
    int? primaryDoseNumber,
    DateTime? scheduledDate,
    @Default(<VaccinationRecord>[]) List<VaccinationRecord> availableVaccines,
    @Default(<VaccinationRecord>[])
    List<VaccinationRecord> selectedAdditionalVaccines,
    @Default(false) bool isAccordionExpanded,
    @Default(false) bool isSubmitting,
    @Default(VaccineRecordType.scheduled) VaccineRecordType recordType,
  }) = _VaccineReservationState;

  /// 予約可能かどうか
  bool get canSubmit =>
      primaryVaccine != null &&
      primaryDoseNumber != null &&
      scheduledDate != null &&
      !isSubmitting;

  /// 同時接種が選択されているかどうか
  bool get hasConcurrentVaccines => selectedAdditionalVaccines.isNotEmpty;

  /// 予約リクエストのリストを生成
  List<VaccineReservationRequest> generateReservationRequests(String childId) {
    if (primaryVaccine == null ||
        primaryDoseNumber == null ||
        scheduledDate == null) {
      return [];
    }

    final requests = <VaccineReservationRequest>[];

    // メインのワクチン予約
    requests.add(VaccineReservationRequest(
      childId: childId,
      vaccineId: primaryVaccine!.id,
      doseId: null, // 新規作成時はnull
      scheduledDate: scheduledDate!,
      recordType: recordType,
    ));

    // 同時接種のワクチン予約
    for (final vaccine in selectedAdditionalVaccines) {
      final bool hasAvailableDose = vaccine.canScheduleNextDose;

      if (hasAvailableDose) {
        requests.add(VaccineReservationRequest(
          childId: childId,
          vaccineId: vaccine.vaccineId,
          doseId: null, // 新規作成時はnull
          scheduledDate: scheduledDate!,
          recordType: recordType,
        ));
      }
    }

    return requests;
  }

  VaccineReservationState clearError() {
    return copyWith(
      error: null,
      isDuplicateError: false,
    );
  }
}

@freezed
sealed class VaccineReservationParams with _$VaccineReservationParams {
  const factory VaccineReservationParams({
    required VaccineInfo vaccine,
    required int doseNumber,
  }) = _VaccineReservationParams;
}
