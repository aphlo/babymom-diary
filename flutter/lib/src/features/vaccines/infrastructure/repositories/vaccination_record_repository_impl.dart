import '../../domain/entities/dose_record.dart';
import '../../domain/entities/vaccination_record.dart';
import '../../domain/entities/vaccine_reservation_request.dart';
import '../../domain/entities/reservation_group.dart';
import '../../domain/repositories/vaccination_record_repository.dart';
import '../../domain/services/vaccine_schedule_conflict_validator.dart';
import '../sources/vaccination_record_firestore_data_source.dart';

class VaccinationRecordRepositoryImpl implements VaccinationRecordRepository {
  VaccinationRecordRepositoryImpl(
    this._dataSource,
    this._conflictValidator,
  );

  final VaccinationRecordFirestoreDataSource _dataSource;
  final VaccineScheduleConflictValidator _conflictValidator;

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
  }) async {
    // 既存の接種記録を取得して重複チェック
    final existingRecord = await _dataSource.getVaccinationRecord(
      householdId: householdId,
      childId: request.childId,
      vaccineId: request.vaccineId,
    );

    _conflictValidator.validateSingleVaccine(
      record: existingRecord,
      scheduledDate: request.scheduledDate,
    );

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
  Future<String> createReservationGroup({
    required String householdId,
    required String childId,
    required DateTime scheduledDate,
    required List<VaccineReservationRequest> requests,
  }) async {
    // グループ内の全てのワクチンについて既存の接種記録を取得して重複チェック
    final existingRecords = <VaccinationRecord>[];
    for (final request in requests) {
      final record = await _dataSource.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: request.vaccineId,
      );
      if (record != null) {
        existingRecords.add(record);
      }
    }

    _conflictValidator.validateReservationGroup(
      records: existingRecords,
      scheduledDate: scheduledDate,
    );

    return _dataSource.createReservationGroup(
      householdId: householdId,
      childId: childId,
      scheduledDate: scheduledDate,
      requests: requests,
    );
  }

  @override
  Future<void> updateVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required String doseId,
    required DateTime scheduledDate,
  }) async {
    // 既存の接種記録を取得して重複チェック（更新対象のdoseは除外）
    final existingRecord = await _dataSource.getVaccinationRecord(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    );

    _conflictValidator.validateSingleVaccine(
      record: existingRecord,
      scheduledDate: scheduledDate,
      excludeDoseId: doseId,
    );

    return _dataSource.updateVaccineReservation(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseId: doseId,
      scheduledDate: scheduledDate,
    );
  }

  @override
  Future<void> updateReservationGroupSchedule({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required DateTime scheduledDate,
  }) async {
    // グループ情報を取得
    final group = await _dataSource.getReservationGroup(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
    );

    if (group == null) {
      throw Exception('Reservation group not found: $reservationGroupId');
    }

    // グループ内の全てのワクチンについて既存の接種記録を取得して重複チェック
    final existingRecords = <VaccinationRecord>[];
    final excludeDoseIds = <String, String>{};

    for (final member in group.members) {
      final record = await _dataSource.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: member.vaccineId,
      );
      if (record != null) {
        existingRecords.add(record);
        excludeDoseIds[member.vaccineId] = member.doseId;
      }
    }

    _conflictValidator.validateReservationGroup(
      records: existingRecords,
      scheduledDate: scheduledDate,
      excludeDoseIds: excludeDoseIds,
    );

    return _dataSource.updateReservationGroupSchedule(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
      scheduledDate: scheduledDate,
    );
  }

  @override
  Future<void> completeVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required String doseId,
  }) {
    return _dataSource.completeVaccination(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseId: doseId,
    );
  }

  @override
  Future<void> completeReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) {
    return _dataSource.completeReservationGroup(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
    );
  }

  @override
  Future<void> completeReservationGroupMember({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String vaccineId,
    required String doseId,
  }) {
    return _dataSource.completeReservationGroupMember(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
      vaccineId: vaccineId,
      doseId: doseId,
    );
  }

  @override
  Future<void> deleteVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required String doseId,
  }) {
    return _dataSource.deleteVaccineReservation(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseId: doseId,
    );
  }

  @override
  Future<void> deleteReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) {
    return _dataSource.deleteReservationGroup(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
    );
  }

  @override
  Future<void> deleteReservationGroupMember({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String vaccineId,
    required String doseId,
  }) {
    return _dataSource.deleteReservationGroupMember(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
      vaccineId: vaccineId,
      doseId: doseId,
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
      // 未完了の回数があるかチェック
      return record.doses.any((dose) => dose.status != DoseStatus.completed);
    }).toList();
  }

  @override
  Future<VaccinationReservationGroup?> getReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) {
    return _dataSource.getReservationGroup(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
    );
  }

  @override
  Future<void> markDoseAsScheduled({
    required String householdId,
    required String childId,
    required String vaccineId,
    required String doseId,
    required DateTime scheduledDate,
  }) async {
    // 既存の接種記録を取得して重複チェック（更新対象のdoseは除外）
    final existingRecord = await _dataSource.getVaccinationRecord(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    );

    _conflictValidator.validateSingleVaccine(
      record: existingRecord,
      scheduledDate: scheduledDate,
      excludeDoseId: doseId,
    );

    return _dataSource.markDoseAsScheduled(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseId: doseId,
      scheduledDate: scheduledDate,
    );
  }

  @override
  Future<void> markReservationGroupAsScheduled({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required DateTime scheduledDate,
  }) async {
    // グループ情報を取得
    final group = await _dataSource.getReservationGroup(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
    );

    if (group == null) {
      throw Exception('Reservation group not found: $reservationGroupId');
    }

    // グループ内の全てのワクチンについて既存の接種記録を取得して重複チェック
    final existingRecords = <VaccinationRecord>[];
    final excludeDoseIds = <String, String>{};

    for (final member in group.members) {
      final record = await _dataSource.getVaccinationRecord(
        householdId: householdId,
        childId: childId,
        vaccineId: member.vaccineId,
      );
      if (record != null) {
        existingRecords.add(record);
        excludeDoseIds[member.vaccineId] = member.doseId;
      }
    }

    _conflictValidator.validateReservationGroup(
      records: existingRecords,
      scheduledDate: scheduledDate,
      excludeDoseIds: excludeDoseIds,
    );

    return _dataSource.markReservationGroupAsScheduled(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
      scheduledDate: scheduledDate,
    );
  }
}
