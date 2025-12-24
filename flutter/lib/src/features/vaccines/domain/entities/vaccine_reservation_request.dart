import 'package:freezed_annotation/freezed_annotation.dart';

import '../value_objects/vaccine_record_type.dart';

part 'vaccine_reservation_request.freezed.dart';

@freezed
sealed class VaccineReservationRequest with _$VaccineReservationRequest {
  const VaccineReservationRequest._();

  const factory VaccineReservationRequest({
    required String childId,
    required String vaccineId,
    String? doseId, // 新規作成時はnull、更新時は必須
    required DateTime scheduledDate,
    required VaccineRecordType recordType,
    String? reservationGroupId,
  }) = _VaccineReservationRequest;

  /// reservationGroupIdをクリアしたコピーを作成
  VaccineReservationRequest clearReservationGroup() {
    return copyWith(reservationGroupId: null);
  }
}
