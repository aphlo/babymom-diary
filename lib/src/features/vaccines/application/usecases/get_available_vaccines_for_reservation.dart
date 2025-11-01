import '../../domain/entities/vaccination_record.dart';
import '../../domain/repositories/vaccination_record_repository.dart';

class GetAvailableVaccinesForReservation {
  GetAvailableVaccinesForReservation(this._repository);

  final VaccinationRecordRepository _repository;

  /// 予約可能なワクチンの一覧を取得
  Future<List<VaccinationRecord>> call({
    required String householdId,
    required String childId,
  }) async {
    return await _repository.getAvailableVaccinesForReservation(
      householdId: householdId,
      childId: childId,
    );
  }
}
