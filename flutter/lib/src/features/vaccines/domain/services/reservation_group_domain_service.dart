import 'package:babymom_diary/src/features/vaccines/domain/entities/reservation_group.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_reservation_request.dart';
import 'package:babymom_diary/src/features/vaccines/domain/errors/vaccination_persistence_exception.dart';

class ReservationGroupDomainService {
  const ReservationGroupDomainService();

  void ensureSingleChildRequests({
    required String childId,
    required Iterable<VaccineReservationRequest> requests,
  }) {
    final isDifferentChild =
        requests.any((request) => request.childId != childId);
    if (isDifferentChild) {
      throw const ReservationGroupIntegrityException(
        'Reservation requests must belong to the same child.',
      );
    }
  }

  void ensureDoseBelongsToGroup({
    required VaccinationRecord record,
    required String doseId,
    required String groupId,
  }) {
    final dose = record.getDose(doseId);
    if (dose == null) {
      throw ReservationGroupIntegrityException(
        'Dose $doseId not found for vaccine ${record.vaccineId}',
      );
    }

    if (dose.reservationGroupId != groupId) {
      throw ReservationGroupIntegrityException(
        'Dose $doseId is not linked to reservation group $groupId',
      );
    }
  }

  List<ReservationGroupMember> toMembers(
    Iterable<VaccineReservationRequest> requests,
  ) {
    return requests
        .map(
          (request) => ReservationGroupMember(
            vaccineId: request.vaccineId,
            doseId: request.doseId ?? '',
          ),
        )
        .toList();
  }
}
