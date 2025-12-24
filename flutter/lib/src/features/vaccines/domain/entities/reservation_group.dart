import 'package:freezed_annotation/freezed_annotation.dart';

part 'reservation_group.freezed.dart';

@freezed
sealed class ReservationGroupMember with _$ReservationGroupMember {
  const factory ReservationGroupMember({
    required String vaccineId,
    required String doseId,
  }) = _ReservationGroupMember;
}

enum ReservationGroupStatus { scheduled, completed }

@freezed
sealed class VaccinationReservationGroup with _$VaccinationReservationGroup {
  const factory VaccinationReservationGroup({
    required String id,
    required String childId,
    required DateTime scheduledDate,
    required ReservationGroupStatus status,
    required List<ReservationGroupMember> members,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _VaccinationReservationGroup;
}
