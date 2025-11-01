import '../../domain/entities/vaccination_record.dart';
import '../../domain/entities/vaccine_reservation_request.dart';
import '../../domain/entities/vaccination_schedule.dart';
import '../../domain/repositories/vaccination_record_repository.dart';
import '../sources/vaccination_record_firestore_data_source.dart';

class VaccinationRecordRepositoryImpl implements VaccinationRecordRepository {
  VaccinationRecordRepositoryImpl(
    this._dataSource,
  );

  final VaccinationRecordFirestoreDataSource _dataSource;

  @override
  Stream<List<VaccinationRecord>> watchVaccinationRecords({
    required String householdId,
    required String childId,
  }) {
    return _dataSource.watchVaccinationRecords(
      householdId: householdId,
      childId: childId,
    );
  }

  @override
  Stream<VaccinationRecord?> watchVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) {
    return _dataSource.watchVaccinationRecord(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    );
  }

  @override
  Future<VaccinationRecord?> getVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) {
    return _dataSource.getVaccinationRecord(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    );
  }

  @override
  Future<void> createVaccineReservation({
    required String householdId,
    required VaccineReservationRequest request,
  }) {
    return _dataSource.createVaccineReservation(
      householdId: householdId,
      request: request,
    );
  }

  @override
  Future<void> createMultipleVaccineReservations({
    required String householdId,
    required List<VaccineReservationRequest> requests,
  }) {
    return _dataSource.createMultipleVaccineReservations(
      householdId: householdId,
      requests: requests,
    );
  }

  @override
  Future<void> updateVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
    required DateTime scheduledDate,
  }) {
    return _dataSource.updateVaccineReservation(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
      scheduledDate: scheduledDate,
    );
  }

  @override
  Future<void> completeVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
    required DateTime completedDate,
  }) {
    return _dataSource.completeVaccination(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
      completedDate: completedDate,
    );
  }

  @override
  Future<void> skipVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
  }) {
    return _dataSource.skipVaccination(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
    );
  }

  @override
  Future<void> deleteVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
  }) {
    return _dataSource.deleteVaccineReservation(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
    );
  }

  @override
  Future<List<VaccinationSchedule>> getVaccinationSchedules({
    required String householdId,
    required String childId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return _dataSource.getVaccinationSchedules(
      householdId: householdId,
      childId: childId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<List<VaccinationSchedule>> getVaccinationSchedulesForDate({
    required String householdId,
    required String childId,
    required DateTime date,
  }) {
    return _dataSource.getVaccinationSchedulesForDate(
      householdId: householdId,
      childId: childId,
      date: date,
    );
  }

  @override
  Future<List<VaccinationRecord>> getAvailableVaccinesForReservation({
    required String householdId,
    required String childId,
  }) async {
    // 全てのワクチン接種記録を取得
    final allRecords = await _dataSource
        .watchVaccinationRecords(
          householdId: householdId,
          childId: childId,
        )
        .first;

    // 予約可能なワクチンをフィルタリング
    return allRecords.where((record) {
      // 次回接種可能な回数があるかチェック
      final nextDose = record.nextAvailableDose;
      return nextDose != null && !record.hasScheduledDose;
    }).toList();
  }
}
