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

class DuplicateScheduleDateException extends VaccinationPersistenceException {
  DuplicateScheduleDateException({
    required String vaccineId,
    required String vaccineName,
    required DateTime scheduledDate,
  })  : vaccineErrors = [
          VaccineDuplicateError(
            vaccineId: vaccineId,
            vaccineName: vaccineName,
            scheduledDate: scheduledDate,
          )
        ],
        super(_buildMessage([
          VaccineDuplicateError(
            vaccineId: vaccineId,
            vaccineName: vaccineName,
            scheduledDate: scheduledDate,
          )
        ]));

  DuplicateScheduleDateException.multiple({
    required List<VaccineDuplicateError> errors,
  })  : vaccineErrors = errors,
        super(_buildMessage(errors));

  final List<VaccineDuplicateError> vaccineErrors;

  static String _buildMessage(List<VaccineDuplicateError> errors) {
    if (errors.isEmpty) {
      return '予定が重複しています';
    }

    final dateStr =
        '${errors.first.scheduledDate.year}年${errors.first.scheduledDate.month}月${errors.first.scheduledDate.day}日';

    final vaccineList = errors.map((e) => '・${e.vaccineName}').join('\n');
    return '以下のワクチンは既に$dateStrに予定されています\n\n$vaccineList\n\n他の日付を選択してください';
  }
}

class VaccineDuplicateError {
  const VaccineDuplicateError({
    required this.vaccineId,
    required this.vaccineName,
    required this.scheduledDate,
  });

  final String vaccineId;
  final String vaccineName;
  final DateTime scheduledDate;
}
