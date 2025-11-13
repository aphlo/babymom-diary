import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/reservation_group.dart';

class ReservationGroupMemberDto {
  const ReservationGroupMemberDto({
    required this.vaccineId,
    required this.doseId,
  });

  final String vaccineId;
  final String doseId;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'vaccineId': vaccineId,
        'doseId': doseId,
      };

  ReservationGroupMember toDomain() {
    return ReservationGroupMember(
      vaccineId: vaccineId,
      doseId: doseId,
    );
  }
}

class ReservationGroupDto {
  const ReservationGroupDto({
    required this.id,
    required this.childId,
    required this.scheduledDate,
    required this.status,
    required this.members,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String childId;
  final DateTime scheduledDate;
  final ReservationGroupStatus status;
  final List<ReservationGroupMemberDto> members;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory ReservationGroupDto.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    if (data == null) {
      throw StateError('Reservation group snapshot has no data.');
    }

    final status = _parseStatus(data['status'] as String?);
    if (status == null) {
      throw StateError('Unknown reservation group status.');
    }

    final members = (data['members'] as List<dynamic>? ?? <dynamic>[])
        .map((dynamic item) {
          if (item is! Map<String, dynamic>) return null;
          final vaccineId = item['vaccineId'] as String?;
          final doseId = item['doseId'] as String?;
          if (vaccineId == null || doseId == null) return null;
          return ReservationGroupMemberDto(
            vaccineId: vaccineId,
            doseId: doseId,
          );
        })
        .whereType<ReservationGroupMemberDto>()
        .toList();

    return ReservationGroupDto(
      id: snapshot.id,
      childId: data['childId'] as String? ?? '',
      scheduledDate:
          (data['scheduledDate'] as Timestamp?)?.toDate() ?? DateTime.now(),
      status: status,
      members: members,
      createdAt: (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  VaccinationReservationGroup toDomain() {
    return VaccinationReservationGroup(
      id: id,
      childId: childId,
      scheduledDate: scheduledDate,
      status: status,
      members: members.map((member) => member.toDomain()).toList(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'groupId': id,
        'childId': childId,
        'scheduledDate': Timestamp.fromDate(scheduledDate),
        'status': status.name,
        'members': members.map((member) => member.toJson()).toList(),
        'createdAt': Timestamp.fromDate(createdAt),
        'updatedAt': Timestamp.fromDate(updatedAt),
      };

  ReservationGroupDto copyWith({
    DateTime? scheduledDate,
    ReservationGroupStatus? status,
    List<ReservationGroupMemberDto>? members,
    DateTime? updatedAt,
  }) {
    return ReservationGroupDto(
      id: id,
      childId: childId,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      status: status ?? this.status,
      members: members ?? this.members,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  static ReservationGroupStatus? _parseStatus(String? value) {
    switch (value) {
      case 'scheduled':
        return ReservationGroupStatus.scheduled;
      case 'completed':
        return ReservationGroupStatus.completed;
      default:
        return null;
    }
  }
}
