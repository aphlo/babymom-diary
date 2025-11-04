import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_category.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_requirement.dart';

class DoseEntryDto {
  const DoseEntryDto({
    required this.doseNumber,
    required this.status,
    this.scheduledDate,
    this.completedDate,
    this.reservationGroupId,
  });

  final int doseNumber;
  final DoseStatus status;
  final DateTime? scheduledDate;
  final DateTime? completedDate;
  final String? reservationGroupId;

  factory DoseEntryDto.fromJson(int doseNumber, Map<String, dynamic> json) {
    final statusString = json['status'] as String?;
    return DoseEntryDto(
      doseNumber: doseNumber,
      status: _parseDoseStatus(statusString) ?? DoseStatus.scheduled,
      scheduledDate: (json['scheduledDate'] as Timestamp?)?.toDate(),
      completedDate: (json['completedDate'] as Timestamp?)?.toDate(),
      reservationGroupId: json['reservationGroupId'] as String?,
    );
  }

  static DoseStatus? _parseDoseStatus(String? value) {
    switch (value) {
      case 'scheduled':
        return DoseStatus.scheduled;
      case 'completed':
        return DoseStatus.completed;
      default:
        return null;
    }
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'status': status.name,
      if (scheduledDate != null)
        'scheduledDate': Timestamp.fromDate(scheduledDate!),
      if (completedDate != null)
        'completedDate': Timestamp.fromDate(completedDate!),
      if (reservationGroupId != null) 'reservationGroupId': reservationGroupId,
    };
  }

  DoseRecord toDomain() {
    return DoseRecord(
      doseNumber: doseNumber,
      status: status,
      scheduledDate: scheduledDate,
      completedDate: completedDate,
      reservationGroupId: reservationGroupId,
    );
  }
}

class VaccinationRecordDto {
  const VaccinationRecordDto({
    required this.id,
    required this.vaccineId,
    required this.vaccineName,
    required this.category,
    required this.requirement,
    required this.doses,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final String vaccineId;
  final String vaccineName;
  final VaccineCategory category;
  final VaccineRequirement requirement;
  final Map<int, DoseEntryDto> doses;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory VaccinationRecordDto.fromFirestore(
    Map<String, dynamic> data, {
    required String docId,
  }) {
    final rawDoses = Map<String, dynamic>.from(data['doses'] ?? {});
    final doses = <int, DoseEntryDto>{};
    for (final entry in rawDoses.entries) {
      final doseNumber = int.tryParse(entry.key);
      if (doseNumber == null) continue;
      final entryMap = Map<String, dynamic>.from(entry.value as Map);
      doses[doseNumber] = DoseEntryDto.fromJson(doseNumber, entryMap);
    }

    return VaccinationRecordDto(
      id: docId,
      vaccineId: data['vaccineId'] as String? ?? docId,
      vaccineName: data['vaccineName'] as String? ?? '',
      category: _parseVaccineCategory(data['category'] as String?) ??
          VaccineCategory.inactivated,
      requirement: _parseVaccineRequirement(data['requirement'] as String?) ??
          VaccineRequirement.optional,
      doses: doses,
      createdAt:
          (data['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now().toUtc(),
      updatedAt:
          (data['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now().toUtc(),
    );
  }

  VaccinationRecord toDomain() {
    return VaccinationRecord(
      vaccineId: vaccineId,
      vaccineName: vaccineName,
      category: category,
      requirement: requirement,
      doses: doses.map((key, value) => MapEntry(key, value.toDomain())),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'vaccineId': vaccineId,
      'vaccineName': vaccineName,
      'category': category.name,
      'requirement': requirement.name,
      'doses': doses.map(
        (key, value) => MapEntry(key.toString(), value.toJson()),
      ),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  VaccinationRecordDto copyWith({
    Map<int, DoseEntryDto>? doses,
    DateTime? updatedAt,
  }) {
    return VaccinationRecordDto(
      id: id,
      vaccineId: vaccineId,
      vaccineName: vaccineName,
      category: category,
      requirement: requirement,
      doses: Map<int, DoseEntryDto>.from(doses ?? this.doses),
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  VaccinationRecordDto upsertDose(DoseEntryDto entry, DateTime updatedAt) {
    final next = Map<int, DoseEntryDto>.from(doses);
    next[entry.doseNumber] = entry;
    return copyWith(
      doses: next,
      updatedAt: updatedAt,
    );
  }

  VaccinationRecordDto removeDose(int doseNumber, DateTime updatedAt) {
    final next = Map<int, DoseEntryDto>.from(doses);
    next.remove(doseNumber);
    return copyWith(
      doses: next,
      updatedAt: updatedAt,
    );
  }

  static VaccineCategory? _parseVaccineCategory(String? value) {
    switch (value) {
      case 'live':
        return VaccineCategory.live;
      case 'inactivated':
        return VaccineCategory.inactivated;
      default:
        return null;
    }
  }

  static VaccineRequirement? _parseVaccineRequirement(String? value) {
    switch (value) {
      case 'mandatory':
        return VaccineRequirement.mandatory;
      case 'optional':
        return VaccineRequirement.optional;
      default:
        return null;
    }
  }
}
