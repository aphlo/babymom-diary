class VaccinationPersistenceException implements Exception {
  const VaccinationPersistenceException(this.message);

  final String message;

  @override
  String toString() => 'VaccinationPersistenceException: $message';
}

class VaccinationRecordNotFoundException
    extends VaccinationPersistenceException {
  const VaccinationRecordNotFoundException(String vaccineId)
      : super('Vaccination record not found for vaccineId=$vaccineId');
}

class ReservationGroupNotFoundException
    extends VaccinationPersistenceException {
  const ReservationGroupNotFoundException(String groupId)
      : super('Reservation group not found: $groupId');
}

class ReservationGroupIntegrityException
    extends VaccinationPersistenceException {
  const ReservationGroupIntegrityException(super.message);
}
