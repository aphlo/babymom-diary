import '../../domain/entities/vaccine_reservation_request.dart';
import '../../domain/repositories/vaccination_record_repository.dart';

class CreateVaccineReservation {
  CreateVaccineReservation(this._repository);

  final VaccinationRecordRepository _repository;

  /// 単一のワクチン接種予約を作成
  Future<void> call({
    required String householdId,
    required VaccineReservationRequest request,
  }) async {
    await _repository.createVaccineReservation(
      householdId: householdId,
      request: request,
    );
  }

  /// 複数のワクチン接種予約を同時に作成（同時接種用）
  Future<void> createMultiple({
    required String householdId,
    required List<VaccineReservationRequest> requests,
  }) async {
    if (requests.isEmpty) return;

    await _repository.createMultipleVaccineReservations(
      householdId: householdId,
      requests: requests,
    );
  }
}
