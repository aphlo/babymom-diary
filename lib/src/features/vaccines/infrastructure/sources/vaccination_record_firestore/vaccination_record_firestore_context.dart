import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../domain/entities/dose_record.dart';
import '../../../domain/entities/vaccine.dart';
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
    required String doseId,
    required DateTime scheduledDateUtc,
    String? reservationGroupId,
  }) {
    final now = DateTime.now();
    return DoseEntryDto(
      doseId: doseId,
      status: DoseStatus.scheduled,
      scheduledDate: scheduledDateUtc,
      reservationGroupId: reservationGroupId,
      createdAt: now,
      updatedAt: now,
    );
  }

  DoseEntryDto completedDoseEntry({
    required String doseId,
    required DateTime scheduledDateUtc,
    String? reservationGroupId,
  }) {
    final now = DateTime.now();
    return DoseEntryDto(
      doseId: doseId,
      status: DoseStatus.completed,
      scheduledDate: scheduledDateUtc,
      reservationGroupId: reservationGroupId,
      createdAt: now,
      updatedAt: now,
    );
  }

  /// recordTypeに基づいてDoseEntryDtoを作成
  DoseEntryDto createDoseEntryFromRecordType({
    required String doseId,
    required DateTime dateUtc,
    required String recordType,
    String? reservationGroupId,
  }) {
    switch (recordType) {
      case 'scheduled':
        return scheduledDoseEntry(
          doseId: doseId,
          scheduledDateUtc: dateUtc,
          reservationGroupId: reservationGroupId,
        );
      case 'completed':
        return completedDoseEntry(
          doseId: doseId,
          scheduledDateUtc: dateUtc,
          reservationGroupId: reservationGroupId,
        );
      default:
        return scheduledDoseEntry(
          doseId: doseId,
          scheduledDateUtc: dateUtc,
          reservationGroupId: reservationGroupId,
        );
    }
  }

  Map<String, dynamic> serializeDoses(Map<String, DoseEntryDto> doses) {
    return doses.map(
      (key, value) => MapEntry(key, value.toJson()),
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
          doseId: member.doseId,
          docRef: refs.recordDoc(member.vaccineId),
          recordDto: recordDto,
        ),
      );
    }
    return records;
  }

  Future<Vaccine> requireVaccine(String vaccineId) async {
    final vaccine = await vaccineMasterRepository.getVaccineById(vaccineId);
    if (vaccine == null) {
      throw VaccinationPersistenceException('Vaccine not found: $vaccineId');
    }
    return vaccine;
  }

  VaccinationRecordDto buildNewRecordDto({
    required Vaccine vaccine,
    required DoseEntryDto doseEntry,
    required DateTime nowUtc,
  }) {
    return VaccinationRecordDto(
      id: vaccine.id,
      vaccineId: vaccine.id,
      vaccineName: vaccine.name,
      category: _mapCategoryFromEntity(vaccine.category),
      requirement: _mapRequirementFromEntity(vaccine.requirement),
      doses: {doseEntry.doseId: doseEntry},
      createdAt: nowUtc,
      updatedAt: nowUtc,
    );
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
    VaccineCategory category,
  ) {
    switch (category) {
      case VaccineCategory.live:
        return VaccineCategory.live;
      case VaccineCategory.inactivated:
        return VaccineCategory.inactivated;
    }
  }

  VaccineRequirement _mapRequirementFromEntity(
    VaccineRequirement requirement,
  ) {
    switch (requirement) {
      case VaccineRequirement.mandatory:
        return VaccineRequirement.mandatory;
      case VaccineRequirement.optional:
        return VaccineRequirement.optional;
    }
  }
}

class GroupMemberRecord {
  const GroupMemberRecord({
    required this.vaccineId,
    required this.doseId,
    required this.docRef,
    required this.recordDto,
  });

  final String vaccineId;
  final String doseId;
  final DocumentReference<Map<String, dynamic>> docRef;
  final VaccinationRecordDto? recordDto;
}
