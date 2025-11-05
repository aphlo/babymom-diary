import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/dose_record.dart';
import '../../../domain/entities/reservation_group.dart';
import '../../../domain/entities/vaccine_reservation_request.dart';
import '../../../domain/errors/vaccination_persistence_exception.dart';
import '../../models/reservation_group.dart';
import '../../models/vaccination_record.dart';
import 'vaccination_record_firestore_context.dart';

class ReservationGroupFirestoreCommands {
  ReservationGroupFirestoreCommands(this._ctx);

  final VaccinationRecordFirestoreContext _ctx;

  Future<String> createReservationGroup({
    required String householdId,
    required String childId,
    required DateTime scheduledDate,
    required List<VaccineReservationRequest> requests,
  }) async {
    if (requests.isEmpty) {
      throw ArgumentError('requests must not be empty');
    }

    _ctx.reservationGroupService.ensureSingleChildRequests(
      childId: childId,
      requests: requests,
    );

    final groupId = _ctx.uuid.v4();
    final scheduledDateUtc = scheduledDate.toUtc();
    final nowUtc = DateTime.now().toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final membersPayload = requests
              .map(
                (request) => <String, dynamic>{
                  'vaccineId': request.vaccineId,
                  'doseNumber': request.doseNumber,
                },
              )
              .toList();

          final pendingItems = <_ReservationTransactionItem>[];
          for (final request in requests) {
            final recordDto =
                await _ctx.readRecordDto(transaction, refs, request.vaccineId);
            pendingItems.add(
              _ReservationTransactionItem(
                request: request,
                recordDto: recordDto,
                docRef: refs.recordDoc(request.vaccineId),
              ),
            );
          }

          final groupDocRef = refs.reservationGroups.doc(groupId);
          transaction.set(groupDocRef, <String, dynamic>{
            'groupId': groupId,
            'childId': childId,
            'scheduledDate': Timestamp.fromDate(scheduledDateUtc),
            'status': 'scheduled',
            'members': membersPayload,
            'createdAt': Timestamp.fromDate(nowUtc),
            'updatedAt': Timestamp.fromDate(nowUtc),
          });

          for (final item in pendingItems) {
            final itemScheduledDateUtc = item.request.scheduledDate.toUtc();
            final doseEntry = _ctx.createDoseEntryFromRecordType(
              doseNumber: item.request.doseNumber,
              dateUtc: itemScheduledDateUtc,
              recordType: item.request.recordType.name,
              reservationGroupId: groupId,
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

            // vaccination_schedulesコレクションへの書き込み処理を削除
          }
        },
      );
    });

    return groupId;
  }

  Future<void> updateReservationGroupSchedule({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required DateTime scheduledDate,
  }) async {
    final scheduledDateUtc = scheduledDate.toUtc();
    final nowUtc = DateTime.now().toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final groupDto =
              await _ctx.readGroupDto(transaction, refs, reservationGroupId);
          if (groupDto == null) {
            throw ReservationGroupNotFoundException(reservationGroupId);
          }

          final memberRecords = await _ctx.loadGroupMemberRecords(
            transaction,
            refs,
            groupDto,
          );

          transaction.update(
            refs.reservationGroupDoc(reservationGroupId),
            <String, dynamic>{
              'scheduledDate': Timestamp.fromDate(scheduledDateUtc),
              'status': 'scheduled',
              'updatedAt': Timestamp.fromDate(nowUtc),
            },
          );

          for (final memberRecord in memberRecords) {
            final recordDto = memberRecord.recordDto;
            if (recordDto == null) {
              throw VaccinationRecordNotFoundException(
                memberRecord.vaccineId,
              );
            }

            final record = recordDto.toDomain();
            _ctx.reservationGroupService.ensureDoseBelongsToGroup(
              record: record,
              doseNumber: memberRecord.doseNumber,
              groupId: reservationGroupId,
            );

            final updatedDoses = Map<int, DoseEntryDto>.from(recordDto.doses);
            updatedDoses[memberRecord.doseNumber] = _ctx.scheduledDoseEntry(
              doseNumber: memberRecord.doseNumber,
              scheduledDateUtc: scheduledDateUtc,
              reservationGroupId: reservationGroupId,
            );

            transaction.update(
              memberRecord.docRef,
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

  Future<void> completeReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) async {
    final nowUtc = DateTime.now().toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final groupDto =
              await _ctx.readGroupDto(transaction, refs, reservationGroupId);
          if (groupDto == null) {
            throw ReservationGroupNotFoundException(reservationGroupId);
          }

          final memberRecords = await _ctx.loadGroupMemberRecords(
            transaction,
            refs,
            groupDto,
          );

          transaction.update(
            refs.reservationGroupDoc(reservationGroupId),
            <String, dynamic>{
              'status': 'completed',
              'updatedAt': Timestamp.fromDate(nowUtc),
            },
          );

          for (final memberRecord in memberRecords) {
            final recordDto = memberRecord.recordDto;
            if (recordDto == null) {
              throw VaccinationRecordNotFoundException(
                memberRecord.vaccineId,
              );
            }

            final record = recordDto.toDomain();
            _ctx.reservationGroupService.ensureDoseBelongsToGroup(
              record: record,
              doseNumber: memberRecord.doseNumber,
              groupId: reservationGroupId,
            );

            final existingDose = recordDto.doses[memberRecord.doseNumber];
            final updatedDoses = Map<int, DoseEntryDto>.from(recordDto.doses);
            updatedDoses[memberRecord.doseNumber] = DoseEntryDto(
              doseNumber: memberRecord.doseNumber,
              status: DoseStatus.completed,
              scheduledDate: existingDose?.scheduledDate,
              reservationGroupId: reservationGroupId,
            );

            transaction.update(
              memberRecord.docRef,
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

  Future<void> completeReservationGroupMember({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String vaccineId,
    required int doseNumber,
  }) async {
    final nowUtc = DateTime.now().toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final groupDto =
              await _ctx.readGroupDto(transaction, refs, reservationGroupId);
          if (groupDto == null) {
            throw ReservationGroupNotFoundException(reservationGroupId);
          }

          final groupDocRef = refs.reservationGroupDoc(reservationGroupId);
          final updatedMembers = groupDto.members
              .where(
                (member) => !(member.vaccineId == vaccineId &&
                    member.doseNumber == doseNumber),
              )
              .map((member) => <String, dynamic>{
                    'vaccineId': member.vaccineId,
                    'doseNumber': member.doseNumber,
                  })
              .toList();

          final memberExists = updatedMembers.length != groupDto.members.length;
          if (!memberExists) {
            throw ReservationGroupIntegrityException(
              'Group member not found for vaccine=$vaccineId dose=$doseNumber',
            );
          }

          final recordDto =
              await _ctx.readRecordDto(transaction, refs, vaccineId);
          if (recordDto == null) {
            throw VaccinationRecordNotFoundException(vaccineId);
          }

          final record = recordDto.toDomain();
          _ctx.reservationGroupService.ensureDoseBelongsToGroup(
            record: record,
            doseNumber: doseNumber,
            groupId: reservationGroupId,
          );

          final existingDose = recordDto.doses[doseNumber];
          final updatedDoses = Map<int, DoseEntryDto>.from(recordDto.doses);
          updatedDoses[doseNumber] = DoseEntryDto(
            doseNumber: doseNumber,
            status: DoseStatus.completed,
            scheduledDate: existingDose?.scheduledDate,
            reservationGroupId: reservationGroupId,
          );

          transaction.update(
            refs.recordDoc(vaccineId),
            <String, dynamic>{
              'doses': _ctx.serializeDoses(updatedDoses),
              'updatedAt': Timestamp.fromDate(nowUtc),
            },
          );

          if (updatedMembers.isEmpty) {
            transaction.delete(groupDocRef);
          } else {
            transaction.update(groupDocRef, <String, dynamic>{
              'members': updatedMembers,
              'status': 'scheduled',
              'updatedAt': Timestamp.fromDate(nowUtc),
            });
          }
        },
      );
    });
  }

  Future<void> deleteReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) async {
    final nowUtc = DateTime.now().toUtc();

    try {
      await _ctx.executeWithRetry(() async {
        await _ctx.transactionExecutor.runForChild(
          householdId: householdId,
          childId: childId,
          handler: (transaction, refs) async {
            final groupDto =
                await _ctx.readGroupDto(transaction, refs, reservationGroupId);
            if (groupDto == null) {
              throw ReservationGroupNotFoundException(reservationGroupId);
            }

            final memberRecords = await _ctx.loadGroupMemberRecords(
              transaction,
              refs,
              groupDto,
            );

            for (final memberRecord in memberRecords) {
              final recordDto = memberRecord.recordDto;
              if (recordDto == null) {
                // ワクチン記録が存在しない場合はスキップ（データ整合性の問題）
                continue;
              }

              final record = recordDto.toDomain();
              _ctx.reservationGroupService.ensureDoseBelongsToGroup(
                record: record,
                doseNumber: memberRecord.doseNumber,
                groupId: reservationGroupId,
              );

              final updatedDoses = Map<int, DoseEntryDto>.from(recordDto.doses);
              updatedDoses.remove(memberRecord.doseNumber);

              if (updatedDoses.isEmpty) {
                transaction.delete(memberRecord.docRef);
              } else {
                transaction.update(
                  memberRecord.docRef,
                  <String, dynamic>{
                    'doses': _ctx.serializeDoses(updatedDoses),
                    'updatedAt': Timestamp.fromDate(nowUtc),
                  },
                );
              }
            }

            transaction.delete(refs.reservationGroupDoc(reservationGroupId));
          },
        );
      });
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteReservationGroupMember({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String vaccineId,
    required int doseNumber,
  }) async {
    final nowUtc = DateTime.now().toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final groupDto =
              await _ctx.readGroupDto(transaction, refs, reservationGroupId);
          if (groupDto == null) {
            throw ReservationGroupNotFoundException(reservationGroupId);
          }

          final recordDto =
              await _ctx.readRecordDto(transaction, refs, vaccineId);
          if (recordDto == null) {
            throw VaccinationRecordNotFoundException(vaccineId);
          }

          final record = recordDto.toDomain();
          _ctx.reservationGroupService.ensureDoseBelongsToGroup(
            record: record,
            doseNumber: doseNumber,
            groupId: reservationGroupId,
          );

          // ワクチン記録から該当の回数を削除
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

          // スケジュールエントリを削除

          // グループから該当メンバーを削除
          final updatedMembers = groupDto.members
              .where((member) => !(member.vaccineId == vaccineId &&
                  member.doseNumber == doseNumber))
              .toList();

          if (updatedMembers.isEmpty) {
            // グループにメンバーがいなくなった場合はグループ自体を削除
            transaction.delete(refs.reservationGroupDoc(reservationGroupId));
          } else {
            // グループのメンバーリストを更新
            final membersPayload = updatedMembers
                .map((member) => <String, dynamic>{
                      'vaccineId': member.vaccineId,
                      'doseNumber': member.doseNumber,
                    })
                .toList();

            transaction.update(
              refs.reservationGroupDoc(reservationGroupId),
              <String, dynamic>{
                'members': membersPayload,
                'updatedAt': Timestamp.fromDate(nowUtc),
              },
            );
          }
        },
      );
    });
  }

  Future<VaccinationReservationGroup?> getReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  }) async {
    final docRef = _ctx
        .refs(householdId: householdId, childId: childId)
        .reservationGroupDoc(reservationGroupId);
    final snapshot = await docRef.get();
    if (!snapshot.exists) return null;
    return ReservationGroupDto.fromSnapshot(snapshot).toDomain();
  }

  Future<void> markReservationGroupAsScheduled({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required DateTime scheduledDate,
  }) async {
    final scheduledDateUtc = scheduledDate.toUtc();
    final nowUtc = DateTime.now().toUtc();

    await _ctx.executeWithRetry(() async {
      await _ctx.transactionExecutor.runForChild(
        householdId: householdId,
        childId: childId,
        handler: (transaction, refs) async {
          final groupDto =
              await _ctx.readGroupDto(transaction, refs, reservationGroupId);
          if (groupDto == null) {
            throw ReservationGroupNotFoundException(reservationGroupId);
          }

          final memberRecords = await _ctx.loadGroupMemberRecords(
            transaction,
            refs,
            groupDto,
          );

          transaction.update(
            refs.reservationGroupDoc(reservationGroupId),
            <String, dynamic>{
              'scheduledDate': Timestamp.fromDate(scheduledDateUtc),
              'status': 'scheduled',
              'updatedAt': Timestamp.fromDate(nowUtc),
            },
          );

          for (final memberRecord in memberRecords) {
            final recordDto = memberRecord.recordDto;
            if (recordDto == null) {
              throw VaccinationRecordNotFoundException(
                memberRecord.vaccineId,
              );
            }

            final record = recordDto.toDomain();
            _ctx.reservationGroupService.ensureDoseBelongsToGroup(
              record: record,
              doseNumber: memberRecord.doseNumber,
              groupId: reservationGroupId,
            );

            final updatedDoses = Map<int, DoseEntryDto>.from(recordDto.doses);
            updatedDoses[memberRecord.doseNumber] = _ctx.scheduledDoseEntry(
              doseNumber: memberRecord.doseNumber,
              scheduledDateUtc: scheduledDateUtc,
              reservationGroupId: reservationGroupId,
            );

            transaction.update(
              memberRecord.docRef,
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
}

class _ReservationTransactionItem {
  const _ReservationTransactionItem({
    required this.request,
    required this.recordDto,
    required this.docRef,
  });

  final VaccineReservationRequest request;
  final VaccinationRecordDto? recordDto;
  final DocumentReference<Map<String, dynamic>> docRef;
}
