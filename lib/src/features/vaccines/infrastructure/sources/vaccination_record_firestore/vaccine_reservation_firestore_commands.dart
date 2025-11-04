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
          final doseEntry = _ctx.scheduledDoseEntry(
            doseNumber: request.doseNumber,
            scheduledDateUtc: scheduledDateUtc,
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
            final updatedDoses = Map<int, DoseEntryDto>.from(existing.doses);
            updatedDoses[request.doseNumber] = doseEntry;
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

          _ctx.upsertScheduleEntry(
            transaction: transaction,
            refs: refs,
            childId: request.childId,
            record: recordDto,
            doseNumber: request.doseNumber,
            scheduledDateUtc: scheduledDateUtc,
            nowUtc: nowUtc,
          );
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
            final doseEntry = _ctx.scheduledDoseEntry(
              doseNumber: item.request.doseNumber,
              scheduledDateUtc: scheduledDateUtc,
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
                  Map<int, DoseEntryDto>.from(item.recordDto!.doses);
              updatedDoses[item.request.doseNumber] = doseEntry;
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

            _ctx.upsertScheduleEntry(
              transaction: transaction,
              refs: refs,
              childId: childId,
              record: recordDto,
              doseNumber: item.request.doseNumber,
              scheduledDateUtc: scheduledDateUtc,
              nowUtc: nowUtc,
            );
          }
        },
      );
    });
  }

  Future<void> updateVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
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

          final existingDose = recordDto.doses[doseNumber];
          if (existingDose == null) {
            throw VaccinationPersistenceException(
              'Dose record not found: $doseNumber',
            );
          }

          final updatedDoses = Map<int, DoseEntryDto>.from(recordDto.doses);
          updatedDoses[doseNumber] = _ctx.scheduledDoseEntry(
            doseNumber: doseNumber,
            scheduledDateUtc: scheduledDateUtc,
            reservationGroupId: existingDose.reservationGroupId,
          );

          transaction.update(
            refs.recordDoc(vaccineId),
            <String, dynamic>{
              'doses': _ctx.serializeDoses(updatedDoses),
              'updatedAt': Timestamp.fromDate(nowUtc),
            },
          );

          _ctx.upsertScheduleEntry(
            transaction: transaction,
            refs: refs,
            childId: childId,
            record: recordDto.copyWith(
              doses: updatedDoses,
              updatedAt: nowUtc,
            ),
            doseNumber: doseNumber,
            scheduledDateUtc: scheduledDateUtc,
            nowUtc: nowUtc,
          );
        },
      );
    });
  }

  Future<void> completeVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
    required DateTime completedDate,
  }) async {
    final nowUtc = DateTime.now().toUtc();
    final completedDateUtc = completedDate.toUtc();

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

          final existingDose = recordDto.doses[doseNumber];
          if (existingDose == null) {
            throw VaccinationPersistenceException(
              'Dose record not found: $doseNumber',
            );
          }

          final updatedDoses = Map<int, DoseEntryDto>.from(recordDto.doses);
          updatedDoses[doseNumber] = _ctx.completedDoseEntry(
            doseNumber: doseNumber,
            completedDateUtc: completedDateUtc,
            reservationGroupId: existingDose.reservationGroupId,
          );

          transaction.update(
            refs.recordDoc(vaccineId),
            <String, dynamic>{
              'doses': _ctx.serializeDoses(updatedDoses),
              'updatedAt': Timestamp.fromDate(nowUtc),
            },
          );

          _ctx.deleteScheduleEntry(
            transaction: transaction,
            refs: refs,
            vaccineId: vaccineId,
            doseNumber: doseNumber,
          );
        },
      );
    });
  }

  Future<void> deleteVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
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

          if (!recordDto.doses.containsKey(doseNumber)) {
            throw VaccinationPersistenceException(
              'Dose record not found: $doseNumber',
            );
          }

          final updatedDoses = Map<int, DoseEntryDto>.from(recordDto.doses);
          updatedDoses.remove(doseNumber);

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

          _ctx.deleteScheduleEntry(
            transaction: transaction,
            refs: refs,
            vaccineId: vaccineId,
            doseNumber: doseNumber,
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
