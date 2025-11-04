import 'package:meta/meta.dart';

@immutable
class ReservationGroupMember {
  const ReservationGroupMember({
    required this.vaccineId,
    required this.doseNumber,
  });

  final String vaccineId;
  final int doseNumber;
}

enum ReservationGroupStatus { scheduled, completed, cancelled }

@immutable
class VaccinationReservationGroup {
  const VaccinationReservationGroup({
    required this.id,
    required this.childId,
    required this.scheduledDate,
    required this.status,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
    this.completedDate,
  });

  final String id;
  final String childId;
  final DateTime scheduledDate;
  final ReservationGroupStatus status;
  final List<ReservationGroupMember> members;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedDate;

  VaccinationReservationGroup copyWith({
    String? id,
    String? childId,
    DateTime? scheduledDate,
    ReservationGroupStatus? status,
    List<ReservationGroupMember>? members,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedDate,
    bool clearCompletedDate = false,
  }) {
    return VaccinationReservationGroup(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      status: status ?? this.status,
      members: members ?? this.members,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedDate:
          clearCompletedDate ? null : (completedDate ?? this.completedDate),
    );
  }
}
