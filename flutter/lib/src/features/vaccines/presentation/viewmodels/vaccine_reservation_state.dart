import 'package:meta/meta.dart';

import '../../domain/entities/vaccination_record.dart';
import '../../domain/entities/vaccine_reservation_request.dart';
import '../../domain/value_objects/vaccine_record_type.dart';
import '../models/vaccine_info.dart';

@immutable
class VaccineReservationState {
  const VaccineReservationState({
    this.isLoading = false,
    this.error,
    this.isDuplicateError = false,
    this.primaryVaccine,
    this.primaryDoseNumber,
    this.scheduledDate,
    this.availableVaccines = const [],
    this.selectedAdditionalVaccines = const [],
    this.isAccordionExpanded = false,
    this.isSubmitting = false,
    this.recordType = VaccineRecordType.scheduled,
  });

  final bool isLoading;
  final String? error;
  final bool isDuplicateError;
  final VaccineInfo? primaryVaccine;
  final int? primaryDoseNumber;
  final DateTime? scheduledDate;
  final List<VaccinationRecord> availableVaccines;
  final List<VaccinationRecord> selectedAdditionalVaccines;
  final bool isAccordionExpanded;
  final bool isSubmitting;
  final VaccineRecordType recordType;

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

  VaccineReservationState copyWith({
    bool? isLoading,
    String? error,
    bool? isDuplicateError,
    VaccineInfo? primaryVaccine,
    int? primaryDoseNumber,
    DateTime? scheduledDate,
    List<VaccinationRecord>? availableVaccines,
    List<VaccinationRecord>? selectedAdditionalVaccines,
    bool? isAccordionExpanded,
    bool? isSubmitting,
    VaccineRecordType? recordType,
  }) {
    return VaccineReservationState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isDuplicateError: isDuplicateError ?? false,
      primaryVaccine: primaryVaccine ?? this.primaryVaccine,
      primaryDoseNumber: primaryDoseNumber ?? this.primaryDoseNumber,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      availableVaccines: availableVaccines ?? this.availableVaccines,
      selectedAdditionalVaccines:
          selectedAdditionalVaccines ?? this.selectedAdditionalVaccines,
      isAccordionExpanded: isAccordionExpanded ?? this.isAccordionExpanded,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      recordType: recordType ?? this.recordType,
    );
  }

  VaccineReservationState clearError() {
    return copyWith(error: null, isDuplicateError: false);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineReservationState &&
          runtimeType == other.runtimeType &&
          isLoading == other.isLoading &&
          error == other.error &&
          isDuplicateError == other.isDuplicateError &&
          primaryVaccine == other.primaryVaccine &&
          primaryDoseNumber == other.primaryDoseNumber &&
          scheduledDate == other.scheduledDate &&
          _listEquals(availableVaccines, other.availableVaccines) &&
          _listEquals(
              selectedAdditionalVaccines, other.selectedAdditionalVaccines) &&
          isAccordionExpanded == other.isAccordionExpanded &&
          isSubmitting == other.isSubmitting &&
          recordType == other.recordType;

  @override
  int get hashCode =>
      isLoading.hashCode ^
      error.hashCode ^
      isDuplicateError.hashCode ^
      primaryVaccine.hashCode ^
      primaryDoseNumber.hashCode ^
      scheduledDate.hashCode ^
      availableVaccines.hashCode ^
      selectedAdditionalVaccines.hashCode ^
      isAccordionExpanded.hashCode ^
      isSubmitting.hashCode ^
      recordType.hashCode;

  bool _listEquals<T>(List<T> list1, List<T> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  @override
  String toString() {
    return 'VaccineReservationState('
        'isLoading: $isLoading, '
        'error: $error, '
        'primaryVaccine: $primaryVaccine, '
        'primaryDoseNumber: $primaryDoseNumber, '
        'scheduledDate: $scheduledDate, '
        'availableVaccines: ${availableVaccines.length}, '
        'selectedAdditionalVaccines: ${selectedAdditionalVaccines.length}, '
        'isAccordionExpanded: $isAccordionExpanded, '
        'isSubmitting: $isSubmitting, '
        'recordType: $recordType)';
  }
}

// Parameters class
class VaccineReservationParams {
  const VaccineReservationParams({
    required this.vaccine,
    required this.doseNumber,
  });

  final VaccineInfo vaccine;
  final int doseNumber;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineReservationParams &&
          runtimeType == other.runtimeType &&
          vaccine == other.vaccine &&
          doseNumber == other.doseNumber;

  @override
  int get hashCode => vaccine.hashCode ^ doseNumber.hashCode;
}
