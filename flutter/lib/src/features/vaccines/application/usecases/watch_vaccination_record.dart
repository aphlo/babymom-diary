import '../../domain/entities/vaccination_record.dart';
import '../../domain/repositories/vaccination_record_repository.dart';

class WatchVaccinationRecord {
  WatchVaccinationRecord(this._repository);

  final VaccinationRecordRepository _repository;

  Stream<VaccinationRecord?> call({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) {
    return _repository.watchVaccinationRecord(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    );
  }
}
