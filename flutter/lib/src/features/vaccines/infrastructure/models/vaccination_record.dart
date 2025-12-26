import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_category.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_requirement.dart';

part 'vaccination_record.freezed.dart';

@freezed
sealed class DoseEntryDto with _$DoseEntryDto {
  const DoseEntryDto._();

  const factory DoseEntryDto({
    required String doseId,
    required DoseStatus status,
    DateTime? scheduledDate,
    String? reservationGroupId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DoseEntryDto;

  factory DoseEntryDto.fromJson(String doseId, Map<String, dynamic> json) {
    final statusString = json['status'] as String?;
    return DoseEntryDto(
      doseId: doseId,
      status: _parseDoseStatus(statusString) ?? DoseStatus.scheduled,
      scheduledDate: (json['scheduledDate'] as Timestamp?)?.toDate(),
      reservationGroupId: json['reservationGroupId'] as String?,
      createdAt: (json['createdAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
      updatedAt: (json['updatedAt'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'doseId': doseId,
      'status': status.name,
      if (scheduledDate != null)
        'scheduledDate': Timestamp.fromDate(scheduledDate!),
      if (reservationGroupId != null) 'reservationGroupId': reservationGroupId,
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  DoseRecord toDomain() {
    return DoseRecord(
      doseId: doseId,
      status: status,
      scheduledDate: scheduledDate,
      reservationGroupId: reservationGroupId,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

DoseStatus? _parseDoseStatus(String? value) {
  switch (value) {
    case 'scheduled':
      return DoseStatus.scheduled;
    case 'completed':
      return DoseStatus.completed;
    default:
      return null;
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
  final Map<String, DoseEntryDto> doses;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory VaccinationRecordDto.fromFirestore(
    Map<String, dynamic> data, {
    required String docId,
  }) {
    final rawDoses = Map<String, dynamic>.from(data['doses'] ?? {});
    final doses = <String, DoseEntryDto>{};
    for (final entry in rawDoses.entries) {
      final doseId = entry.key;
      final entryMap = Map<String, dynamic>.from(entry.value as Map);
      doses[doseId] = DoseEntryDto.fromJson(doseId, entryMap);
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
      doses: doses.values.map((value) => value.toDomain()).toList(),
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
        (key, value) => MapEntry(key, value.toJson()),
      ),
      'createdAt': Timestamp.fromDate(createdAt),
      'updatedAt': Timestamp.fromDate(updatedAt),
    };
  }

  VaccinationRecordDto copyWith({
    Map<String, DoseEntryDto>? doses,
    DateTime? updatedAt,
  }) {
    return VaccinationRecordDto(
      id: id,
      vaccineId: vaccineId,
      vaccineName: vaccineName,
      category: category,
      requirement: requirement,
      doses: Map<String, DoseEntryDto>.from(doses ?? this.doses),
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  VaccinationRecordDto upsertDose(DoseEntryDto entry, DateTime updatedAt) {
    final next = Map<String, DoseEntryDto>.from(doses);
    next[entry.doseId] = entry;
    return copyWith(
      doses: next,
      updatedAt: updatedAt,
    );
  }

  VaccinationRecordDto removeDose(String doseId, DateTime updatedAt) {
    final next = Map<String, DoseEntryDto>.from(doses);
    next.remove(doseId);
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
