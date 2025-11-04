import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/dose_record.dart';
import '../../../domain/entities/vaccination_schedule.dart';
import '../../../domain/entities/vaccine.dart' as vaccine_entity;
import '../../../domain/errors/vaccination_persistence_exception.dart';
import '../../../domain/repositories/vaccine_master_repository.dart';
import '../../../domain/services/reservation_group_domain_service.dart';
import '../../../domain/value_objects/vaccine_category.dart';
import '../../../domain/value_objects/vaccine_requirement.dart';
import '../../models/reservation_group.dart';
import '../../models/vaccination_record.dart';
import '../../firestore/helpers/vaccination_record_collection_ref.dart';
import '../../firestore/transactions/vaccination_transaction_executor.dart';

class VaccinationRecordFirestoreContext {
  VaccinationRecordFirestoreContext({
    required this.firestore,
    required this.vaccineMasterRepository,
    ReservationGroupDomainService reservationGroupDomainService =
        const ReservationGroupDomainService(),
  })  : reservationGroupService = reservationGroupDomainService,
        transactionExecutor = VaccinationTransactionExecutor(firestore),
        uuid = const Uuid();

  final FirebaseFirestore firestore;
  final VaccineMasterRepository vaccineMasterRepository;
  final ReservationGroupDomainService reservationGroupService;
  final VaccinationTransactionExecutor transactionExecutor;
  final Uuid uuid;

  VaccinationRecordCollectionRef refs({
    required String householdId,
    required String childId,
  }) {
    return VaccinationRecordCollectionRef(
      firestore: firestore,
      householdId: householdId,
      childId: childId,
    );
  }

  Future<T> executeWithRetry<T>(Future<T> Function() operation) async {
    const maxRetries = 3;
    var retryCount = 0;

    while (retryCount < maxRetries) {
      try {
        return await operation();
      } catch (_) {
        retryCount++;
        if (retryCount >= maxRetries) rethrow;
        await Future.delayed(Duration(milliseconds: 100 * (1 << retryCount)));
      }
    }

    throw StateError('Retry loop exited unexpectedly');
  }

  DoseEntryDto scheduledDoseEntry({
    required int doseNumber,
    required DateTime scheduledDateUtc,
    String? reservationGroupId,
  }) {
    return DoseEntryDto(
      doseNumber: doseNumber,
      status: DoseStatus.scheduled,
      scheduledDate: scheduledDateUtc,
      reservationGroupId: reservationGroupId,
    );
  }

  DoseEntryDto completedDoseEntry({
    required int doseNumber,
    required DateTime completedDateUtc,
    String? reservationGroupId,
  }) {
    return DoseEntryDto(
      doseNumber: doseNumber,
      status: DoseStatus.completed,
      completedDate: completedDateUtc,
      reservationGroupId: reservationGroupId,
    );
  }

  Map<String, dynamic> serializeDoses(Map<int, DoseEntryDto> doses) {
    return doses.map(
      (key, value) => MapEntry(key.toString(), value.toJson()),
    );
  }

  Future<VaccinationRecordDto?> readRecordDto(
    Transaction transaction,
    VaccinationRecordCollectionRef refs,
    String vaccineId,
  ) async {
    final snapshot = await transaction.get(refs.recordDoc(vaccineId));
    if (!snapshot.exists) return null;
    final data = snapshot.data();
    if (data == null) return null;
    return VaccinationRecordDto.fromFirestore(data, docId: snapshot.id);
  }

  Future<ReservationGroupDto?> readGroupDto(
    Transaction transaction,
    VaccinationRecordCollectionRef refs,
    String reservationGroupId,
  ) async {
    final snapshot =
        await transaction.get(refs.reservationGroupDoc(reservationGroupId));
    if (!snapshot.exists) return null;
    return ReservationGroupDto.fromSnapshot(snapshot);
  }

  Future<List<GroupMemberRecord>> loadGroupMemberRecords(
    Transaction transaction,
    VaccinationRecordCollectionRef refs,
    ReservationGroupDto group,
  ) async {
    final records = <GroupMemberRecord>[];
    for (final member in group.members) {
      final recordDto =
          await readRecordDto(transaction, refs, member.vaccineId);
      records.add(
        GroupMemberRecord(
          vaccineId: member.vaccineId,
          doseNumber: member.doseNumber,
          docRef: refs.recordDoc(member.vaccineId),
          recordDto: recordDto,
        ),
      );
    }
    return records;
  }

  void upsertScheduleEntry({
    required Transaction transaction,
    required VaccinationRecordCollectionRef refs,
    required String childId,
    required VaccinationRecordDto record,
    required int doseNumber,
    required DateTime scheduledDateUtc,
    required DateTime nowUtc,
  }) {
    final scheduleDoc = refs.scheduleDoc(
      vaccineId: record.vaccineId,
      doseNumber: doseNumber,
    );
    transaction.set(
      scheduleDoc,
      <String, dynamic>{
        'childId': childId,
        'vaccineId': record.vaccineId,
        'vaccineName': record.vaccineName,
        'doseNumber': doseNumber,
        'scheduledDate': Timestamp.fromDate(scheduledDateUtc),
        'category': record.category.name,
        'requirement': record.requirement.name,
        'updatedAt': Timestamp.fromDate(nowUtc),
      },
      SetOptions(merge: true),
    );
  }

  void deleteScheduleEntry({
    required Transaction transaction,
    required VaccinationRecordCollectionRef refs,
    required String vaccineId,
    required int doseNumber,
  }) {
    transaction.delete(
      refs.scheduleDoc(
        vaccineId: vaccineId,
        doseNumber: doseNumber,
      ),
    );
  }

  Future<vaccine_entity.Vaccine> requireVaccine(String vaccineId) async {
    final vaccine = await vaccineMasterRepository.getVaccineById(vaccineId);
    if (vaccine == null) {
      throw VaccinationPersistenceException('Vaccine not found: $vaccineId');
    }
    return vaccine;
  }

  VaccinationRecordDto buildNewRecordDto({
    required vaccine_entity.Vaccine vaccine,
    required DoseEntryDto doseEntry,
    required DateTime nowUtc,
  }) {
    return VaccinationRecordDto(
      id: vaccine.id,
      vaccineId: vaccine.id,
      vaccineName: vaccine.name,
      category: _mapCategoryFromEntity(vaccine.category),
      requirement: _mapRequirementFromEntity(vaccine.requirement),
      doses: {doseEntry.doseNumber: doseEntry},
      createdAt: nowUtc,
      updatedAt: nowUtc,
    );
  }

  VaccinationSchedule? mapScheduleDocument(
    QueryDocumentSnapshot<Map<String, dynamic>> doc,
    String childId,
  ) {
    final data = doc.data();
    final scheduledTimestamp = data['scheduledDate'] as Timestamp?;
    final vaccineId = data['vaccineId'] as String?;
    final vaccineName = data['vaccineName'] as String? ?? '';
    final doseNumber = data['doseNumber'] as int?;
    final category = categoryFromString(data['category'] as String?);
    final requirement = requirementFromString(data['requirement'] as String?);

    if (scheduledTimestamp == null ||
        vaccineId == null ||
        doseNumber == null ||
        category == null ||
        requirement == null) {
      return null;
    }

    return VaccinationSchedule(
      childId: childId,
      vaccineId: vaccineId,
      vaccineName: vaccineName,
      doseNumber: doseNumber,
      scheduledDate: scheduledTimestamp.toDate(),
      category: category,
      requirement: requirement,
    );
  }

  Future<List<VaccinationSchedule>> getLegacySchedules(
    String householdId,
    String childId,
    DateTime startUtc,
    DateTime endUtc,
  ) async {
    final snapshot = await refs(
      householdId: householdId,
      childId: childId,
    ).vaccinationRecords.get();

    final schedules = <VaccinationSchedule>[];
    for (final doc in snapshot.docs) {
      final recordDto =
          VaccinationRecordDto.fromFirestore(doc.data(), docId: doc.id);
      final record = recordDto.toDomain();

      for (final entry in record.doses.entries) {
        final doseNumber = entry.key;
        final doseRecord = entry.value;
        final scheduledDate = doseRecord.scheduledDate;
        if (doseRecord.status != DoseStatus.scheduled ||
            scheduledDate == null) {
          continue;
        }

        if (scheduledDate.isBefore(startUtc) ||
            !scheduledDate.isBefore(endUtc)) {
          continue;
        }

        schedules.add(
          VaccinationSchedule(
            childId: childId,
            vaccineId: record.vaccineId,
            vaccineName: record.vaccineName,
            doseNumber: doseNumber,
            scheduledDate: scheduledDate,
            category: record.category,
            requirement: record.requirement,
          ),
        );
      }
    }

    schedules.sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
    return schedules;
  }

  VaccineCategory? categoryFromString(String? value) {
    switch (value) {
      case 'live':
        return VaccineCategory.live;
      case 'inactivated':
        return VaccineCategory.inactivated;
      default:
        return null;
    }
  }

  VaccineRequirement? requirementFromString(String? value) {
    switch (value) {
      case 'mandatory':
        return VaccineRequirement.mandatory;
      case 'optional':
        return VaccineRequirement.optional;
      default:
        return null;
    }
  }

  VaccineCategory _mapCategoryFromEntity(
    vaccine_entity.VaccineCategory category,
  ) {
    switch (category) {
      case vaccine_entity.VaccineCategory.live:
        return VaccineCategory.live;
      case vaccine_entity.VaccineCategory.inactivated:
        return VaccineCategory.inactivated;
    }
  }

  VaccineRequirement _mapRequirementFromEntity(
    vaccine_entity.VaccineRequirement requirement,
  ) {
    switch (requirement) {
      case vaccine_entity.VaccineRequirement.mandatory:
        return VaccineRequirement.mandatory;
      case vaccine_entity.VaccineRequirement.optional:
        return VaccineRequirement.optional;
    }
  }
}

class GroupMemberRecord {
  const GroupMemberRecord({
    required this.vaccineId,
    required this.doseNumber,
    required this.docRef,
    required this.recordDto,
  });

  final String vaccineId;
  final int doseNumber;
  final DocumentReference<Map<String, dynamic>> docRef;
  final VaccinationRecordDto? recordDto;
}
