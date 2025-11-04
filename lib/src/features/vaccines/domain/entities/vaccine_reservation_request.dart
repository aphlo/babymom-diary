import 'package:meta/meta.dart';

@immutable
class VaccineReservationRequest {
  const VaccineReservationRequest({
    required this.childId,
    required this.vaccineId,
    required this.doseNumber,
    required this.scheduledDate,
    this.reservationGroupId,
  });

  final String childId;
  final String vaccineId;
  final int doseNumber;
  final DateTime scheduledDate;
  final String? reservationGroupId;

  /// 予約リクエストのコピーを作成
  VaccineReservationRequest copyWith({
    String? childId,
    String? vaccineId,
    int? doseNumber,
    DateTime? scheduledDate,
    String? reservationGroupId,
    bool clearReservationGroup = false,
  }) {
    return VaccineReservationRequest(
      childId: childId ?? this.childId,
      vaccineId: vaccineId ?? this.vaccineId,
      doseNumber: doseNumber ?? this.doseNumber,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      reservationGroupId: clearReservationGroup
          ? null
          : (reservationGroupId ?? this.reservationGroupId),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineReservationRequest &&
          runtimeType == other.runtimeType &&
          childId == other.childId &&
          vaccineId == other.vaccineId &&
          doseNumber == other.doseNumber &&
          scheduledDate == other.scheduledDate &&
          reservationGroupId == other.reservationGroupId;

  @override
  int get hashCode =>
      childId.hashCode ^
      vaccineId.hashCode ^
      doseNumber.hashCode ^
      scheduledDate.hashCode ^
      reservationGroupId.hashCode;

  @override
  String toString() {
    return 'VaccineReservationRequest(childId: $childId, vaccineId: $vaccineId, '
        'doseNumber: $doseNumber, scheduledDate: $scheduledDate, '
        'reservationGroupId: $reservationGroupId)';
  }
}
