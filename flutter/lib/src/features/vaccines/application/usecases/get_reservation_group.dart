import '../../domain/entities/reservation_group.dart';
import '../../domain/repositories/vaccination_record_repository.dart';

class GetReservationGroup {
  const GetReservationGroup(this._repository);

  final VaccinationRecordRepository _repository;

  Future<VaccinationReservationGroup?> call({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) {
    return _repository.getReservationGroup(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
    );
  }
}
