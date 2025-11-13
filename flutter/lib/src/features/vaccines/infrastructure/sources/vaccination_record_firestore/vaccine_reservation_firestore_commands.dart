import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/vaccine_reservation_request.dart';
import '../../../domain/errors/vaccination_persistence_exception.dart';
import '../../models/vaccination_record.dart';
import 'vaccination_record_firestore_context.dart';

class VaccineReservationFirestoreCommands {
  VaccineReservationFirestoreCommands(this._ctx);

  final VaccinationRecordFirestoreContext _ctx;

  Future<void> createVaccineReservation({
    required String householdId,
    required VaccineReservationRequest request,
  }) async {
    final nowUtc = DateTime.now().toUtc();
    final scheduledDateUtc = request.scheduledDate.toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: request.childId,
        handler: (transaction, refs) async {
          final existing =
              await _ctx.readRecordDto(transaction, refs, request.vaccineId);

          // doseIdを生成（新規の場合）または既存のものを使用
          final doseId = request.doseId ?? _ctx.uuid.v4();

          final doseEntry = _ctx.createDoseEntryFromRecordType(
            doseId: doseId,
            dateUtc: scheduledDateUtc,
            recordType: request.recordType.name,
            reservationGroupId: request.reservationGroupId,
          );

          VaccinationRecordDto recordDto;
          if (existing == null) {
            final vaccine = await _ctx.requireVaccine(request.vaccineId);
            recordDto = _ctx.buildNewRecordDto(
              vaccine: vaccine,
              doseEntry: doseEntry,
              nowUtc: nowUtc,
            );
            transaction.set(
              refs.recordDoc(request.vaccineId),
              recordDto.toJson(),
            );
          } else {
            final updatedDoses = Map<String, DoseEntryDto>.from(existing.doses);
            updatedDoses[doseId] = doseEntry;
            recordDto = existing.copyWith(
              doses: updatedDoses,
              updatedAt: nowUtc,
            );
            transaction.update(
              refs.recordDoc(request.vaccineId),
              <String, dynamic>{
                'doses': _ctx.serializeDoses(updatedDoses),
                'updatedAt': Timestamp.fromDate(nowUtc),
              },
            );
          }
        },
      );
    });
  }

  Future<void> createMultipleVaccineReservations({
    required String householdId,
    required List<VaccineReservationRequest> requests,
  }) async {
    if (requests.isEmpty) return;

    final nowUtc = DateTime.now().toUtc();
    final childId = requests.first.childId;
    _ctx.reservationGroupService.ensureSingleChildRequests(
      childId: childId,
      requests: requests,
    );

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final pendingItems = <_ReservationTransactionItem>[];
          for (final request in requests) {
            final recordDto =
                await _ctx.readRecordDto(transaction, refs, request.vaccineId);
            pendingItems.add(
              _ReservationTransactionItem(
                request: request,
                docRef: refs.recordDoc(request.vaccineId),
                recordDto: recordDto,
              ),
            );
          }

          for (final item in pendingItems) {
            final scheduledDateUtc = item.request.scheduledDate.toUtc();

            // doseIdを生成（新規の場合）または既存のものを使用
            final doseId = item.request.doseId ?? _ctx.uuid.v4();

            final doseEntry = _ctx.createDoseEntryFromRecordType(
              doseId: doseId,
              dateUtc: scheduledDateUtc,
              recordType: item.request.recordType.name,
              reservationGroupId: item.request.reservationGroupId,
            );

            VaccinationRecordDto recordDto;
            if (item.recordDto == null) {
              final vaccine = await _ctx.requireVaccine(item.request.vaccineId);
              recordDto = _ctx.buildNewRecordDto(
                vaccine: vaccine,
                doseEntry: doseEntry,
                nowUtc: nowUtc,
              );
              transaction.set(item.docRef, recordDto.toJson());
            } else {
              final updatedDoses =
                  Map<String, DoseEntryDto>.from(item.recordDto!.doses);
              updatedDoses[doseId] = doseEntry;
              recordDto = item.recordDto!.copyWith(
                doses: updatedDoses,
                updatedAt: nowUtc,
              );
              transaction.update(
                item.docRef,
                <String, dynamic>{
                  'doses': _ctx.serializeDoses(updatedDoses),
                  'updatedAt': Timestamp.fromDate(nowUtc),
                },
              );
            }
          }
        },
      );
    });
  }

  Future<void> updateVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required String doseId,
    required DateTime scheduledDate,
  }) async {
    final nowUtc = DateTime.now().toUtc();
    final scheduledDateUtc = scheduledDate.toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final recordDto =
              await _ctx.readRecordDto(transaction, refs, vaccineId);
          if (recordDto == null) {
            throw VaccinationRecordNotFoundException(vaccineId);
          }

          final existingDose = recordDto.doses[doseId];
          if (existingDose == null) {
            throw VaccinationPersistenceException(
              'Dose record not found: $doseId',
            );
          }

          final updatedDoses = Map<String, DoseEntryDto>.from(recordDto.doses);
          updatedDoses[doseId] = _ctx.createDoseEntryFromRecordType(
            doseId: doseId,
            dateUtc: scheduledDateUtc,
            recordType: 'scheduled',
            reservationGroupId: existingDose.reservationGroupId,
          );

          transaction.update(
            refs.recordDoc(vaccineId),
            <String, dynamic>{
              'doses': _ctx.serializeDoses(updatedDoses),
              'updatedAt': Timestamp.fromDate(nowUtc),
            },
          );
        },
      );
    });
  }

  Future<void> completeVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required String doseId,
  }) async {
    final nowUtc = DateTime.now().toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final recordDto =
              await _ctx.readRecordDto(transaction, refs, vaccineId);
          if (recordDto == null) {
            throw VaccinationRecordNotFoundException(vaccineId);
          }

          final existingDose = recordDto.doses[doseId];
          if (existingDose == null) {
            throw VaccinationPersistenceException(
              'Dose record not found: $doseId',
            );
          }

          final updatedDoses = Map<String, DoseEntryDto>.from(recordDto.doses);
          updatedDoses[doseId] = _ctx.createDoseEntryFromRecordType(
            doseId: doseId,
            dateUtc: existingDose.scheduledDate ?? nowUtc,
            recordType: 'completed',
            reservationGroupId: existingDose.reservationGroupId,
          );

          transaction.update(
            refs.recordDoc(vaccineId),
            <String, dynamic>{
              'doses': _ctx.serializeDoses(updatedDoses),
              'updatedAt': Timestamp.fromDate(nowUtc),
            },
          );
        },
      );
    });
  }

  Future<void> deleteVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required String doseId,
  }) async {
    final nowUtc = DateTime.now().toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final recordDto =
              await _ctx.readRecordDto(transaction, refs, vaccineId);
          if (recordDto == null) {
            throw VaccinationRecordNotFoundException(vaccineId);
          }

          if (!recordDto.doses.containsKey(doseId)) {
            throw VaccinationPersistenceException(
              'Dose record not found: $doseId',
            );
          }

          final updatedDoses = Map<String, DoseEntryDto>.from(recordDto.doses);
          updatedDoses.remove(doseId);

          if (updatedDoses.isEmpty) {
            transaction.delete(refs.recordDoc(vaccineId));
          } else {
            transaction.update(
              refs.recordDoc(vaccineId),
              <String, dynamic>{
                'doses': _ctx.serializeDoses(updatedDoses),
                'updatedAt': Timestamp.fromDate(nowUtc),
              },
            );
          }
        },
      );
    });
  }

  Future<void> markDoseAsScheduled({
    required String householdId,
    required String childId,
    required String vaccineId,
    required String doseId,
    required DateTime scheduledDate,
  }) async {
    final nowUtc = DateTime.now().toUtc();
    final scheduledDateUtc = scheduledDate.toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final recordDto =
              await _ctx.readRecordDto(transaction, refs, vaccineId);
          if (recordDto == null) {
            throw VaccinationRecordNotFoundException(vaccineId);
          }

          final existingDose = recordDto.doses[doseId];
          if (existingDose == null) {
            throw VaccinationPersistenceException(
              'Dose record not found: $doseId',
            );
          }

          final updatedDoses = Map<String, DoseEntryDto>.from(recordDto.doses);
          updatedDoses[doseId] = _ctx.createDoseEntryFromRecordType(
            doseId: doseId,
            dateUtc: scheduledDateUtc,
            recordType: 'scheduled',
            reservationGroupId: existingDose.reservationGroupId,
          );

          transaction.update(
            refs.recordDoc(vaccineId),
            <String, dynamic>{
              'doses': _ctx.serializeDoses(updatedDoses),
              'updatedAt': Timestamp.fromDate(nowUtc),
            },
          );
        },
      );
    });
  }
}

class _ReservationTransactionItem {
  const _ReservationTransactionItem({
    required this.request,
    required this.docRef,
    required this.recordDto,
  });

  final VaccineReservationRequest request;
  final DocumentReference<Map<String, dynamic>> docRef;
  final VaccinationRecordDto? recordDto;
}
