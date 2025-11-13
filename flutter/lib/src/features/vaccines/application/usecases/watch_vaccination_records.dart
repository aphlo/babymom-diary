import '../../domain/entities/vaccination_record.dart';
import '../../domain/repositories/vaccination_record_repository.dart';

class WatchVaccinationRecords {
  const WatchVaccinationRecords(this._repository);

  final VaccinationRecordRepository _repository;

  Stream<List<VaccinationRecord>> call({
    required String householdId,
    required String childId,
  }) {
    return _repository.watchVaccinationRecords(
      householdId: householdId,
      childId: childId,
    );
  }
}
