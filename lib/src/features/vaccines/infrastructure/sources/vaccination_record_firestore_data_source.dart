import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/reservation_group.dart';
import '../../domain/entities/vaccination_record.dart';
import '../../domain/entities/vaccine_reservation_request.dart';
import '../../domain/repositories/vaccine_master_repository.dart';
import '../../domain/services/reservation_group_domain_service.dart';
import 'vaccination_record_firestore/reservation_group_firestore_commands.dart';
import 'vaccination_record_firestore/vaccination_record_firestore_context.dart';
import 'vaccination_record_firestore/vaccination_record_firestore_queries.dart';
import 'vaccination_record_firestore/vaccine_reservation_firestore_commands.dart';

class VaccinationRecordFirestoreDataSource {
  VaccinationRecordFirestoreDataSource(
    FirebaseFirestore firestore,
    VaccineMasterRepository vaccineMasterRepository, {
    ReservationGroupDomainService reservationGroupDomainService =
        const ReservationGroupDomainService(),
  }) {
    final context = VaccinationRecordFirestoreContext(
      firestore: firestore,
      vaccineMasterRepository: vaccineMasterRepository,
      reservationGroupDomainService: reservationGroupDomainService,
    );
    _queries = VaccinationRecordFirestoreQueries(context);
    _reservationCommands = VaccineReservationFirestoreCommands(context);
    _groupCommands = ReservationGroupFirestoreCommands(context);
  }

  late final VaccinationRecordFirestoreQueries _queries;
  late final VaccineReservationFirestoreCommands _reservationCommands;
  late final ReservationGroupFirestoreCommands _groupCommands;

  Stream<List<VaccinationRecord>> watchVaccinationRecords({
    required String householdId,
    required String childId,
  }) {
    return _queries.watchVaccinationRecords(
      householdId: householdId,
      childId: childId,
    );
  }

  Stream<VaccinationRecord?> watchVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) {
    return _queries.watchVaccinationRecord(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    );
  }

  Future<VaccinationRecord?> getVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  }) {
    return _queries.getVaccinationRecord(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
    );
  }

  Future<void> createVaccineReservation({
    required String householdId,
    required VaccineReservationRequest request,
  }) {
    return _reservationCommands.createVaccineReservation(
      householdId: householdId,
      request: request,
    );
  }

  Future<void> createMultipleVaccineReservations({
    required String householdId,
    required List<VaccineReservationRequest> requests,
  }) {
    return _reservationCommands.createMultipleVaccineReservations(
      householdId: householdId,
      requests: requests,
    );
  }

  Future<String> createReservationGroup({
    required String householdId,
    required String childId,
    required DateTime scheduledDate,
    required List<VaccineReservationRequest> requests,
  }) {
    return _groupCommands.createReservationGroup(
      householdId: householdId,
      childId: childId,
      scheduledDate: scheduledDate,
      requests: requests,
    );
  }

  Future<void> updateReservationGroupSchedule({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required DateTime scheduledDate,
  }) {
    return _groupCommands.updateReservationGroupSchedule(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
      scheduledDate: scheduledDate,
    );
  }

  Future<void> completeReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) {
    return _groupCommands.completeReservationGroup(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
    );
  }

  Future<void> completeReservationGroupMember({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String vaccineId,
    required int doseNumber,
  }) {
    return _groupCommands.completeReservationGroupMember(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
    );
  }

  Future<void> deleteReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) {
    return _groupCommands.deleteReservationGroup(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
    );
  }

  Future<void> deleteReservationGroupMember({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String vaccineId,
    required int doseNumber,
  }) {
    return _groupCommands.deleteReservationGroupMember(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
    );
  }

  Future<VaccinationReservationGroup?> getReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) {
    return _groupCommands.getReservationGroup(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
    );
  }

  Future<void> updateVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
    required DateTime scheduledDate,
  }) {
    return _reservationCommands.updateVaccineReservation(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
      scheduledDate: scheduledDate,
    );
  }

  Future<void> completeVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
  }) {
    return _reservationCommands.completeVaccination(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
    );
  }

  Future<void> deleteVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
  }) {
    return _reservationCommands.deleteVaccineReservation(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
    );
  }

  Future<void> markDoseAsScheduled({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
    required DateTime scheduledDate,
  }) {
    return _reservationCommands.markDoseAsScheduled(
      householdId: householdId,
      childId: childId,
      vaccineId: vaccineId,
      doseNumber: doseNumber,
      scheduledDate: scheduledDate,
    );
  }

  Future<void> markReservationGroupAsScheduled({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required DateTime scheduledDate,
  }) {
    return _groupCommands.markReservationGroupAsScheduled(
      householdId: householdId,
      childId: childId,
      reservationGroupId: reservationGroupId,
      scheduledDate: scheduledDate,
    );
  }
}
