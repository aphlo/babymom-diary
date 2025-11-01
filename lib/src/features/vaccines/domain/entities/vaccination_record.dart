import 'package:meta/meta.dart';

import 'dose_record.dart';
import '../value_objects/vaccine_category.dart';
import '../value_objects/vaccine_requirement.dart';

@immutable
class VaccinationRecord {
  const VaccinationRecord({
    required this.vaccineId,
    required this.vaccineName,
    required this.category,
    required this.requirement,
    required this.doses,
    required this.createdAt,
    required this.updatedAt,
  });

  final String vaccineId;
  final String vaccineName;
  final VaccineCategory category;
  final VaccineRequirement requirement;
  final Map<int, DoseRecord> doses;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// 次回接種可能な回数を取得
  int? get nextAvailableDose {
    final completedDoses = doses.values
        .where((dose) => dose.status == DoseStatus.completed)
        .length;

    // ワクチンの最大接種回数に基づいて判定
    final maxDoses = _getMaxDosesForVaccine(vaccineId);
    if (completedDoses >= maxDoses) return null;

    return completedDoses + 1;
  }

  /// 予約済みだが未完了の接種があるかチェック
  bool get hasScheduledDose {
    return doses.values.any((dose) => dose.status == DoseStatus.scheduled);
  }

  /// 指定された回数の接種が完了しているかチェック
  bool isDoseCompleted(int doseNumber) {
    final dose = doses[doseNumber];
    return dose?.status == DoseStatus.completed;
  }

  /// 指定された回数の接種が予約済みかチェック
  bool isDoseScheduled(int doseNumber) {
    final dose = doses[doseNumber];
    return dose?.status == DoseStatus.scheduled;
  }

  /// 指定された回数の接種記録を取得
  DoseRecord? getDose(int doseNumber) {
    return doses[doseNumber];
  }

  /// 新しい接種記録を追加したコピーを作成
  VaccinationRecord copyWithDose(int doseNumber, DoseRecord doseRecord) {
    final newDoses = Map<int, DoseRecord>.from(doses);
    newDoses[doseNumber] = doseRecord;

    return VaccinationRecord(
      vaccineId: vaccineId,
      vaccineName: vaccineName,
      category: category,
      requirement: requirement,
      doses: newDoses,
      createdAt: createdAt,
      updatedAt: DateTime.now(),
    );
  }

  /// ワクチン接種記録のコピーを作成
  VaccinationRecord copyWith({
    String? vaccineId,
    String? vaccineName,
    VaccineCategory? category,
    VaccineRequirement? requirement,
    Map<int, DoseRecord>? doses,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return VaccinationRecord(
      vaccineId: vaccineId ?? this.vaccineId,
      vaccineName: vaccineName ?? this.vaccineName,
      category: category ?? this.category,
      requirement: requirement ?? this.requirement,
      doses: doses ?? this.doses,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// ワクチンの最大接種回数を取得（仮実装）
  int _getMaxDosesForVaccine(String vaccineId) {
    // TODO: ワクチンマスタデータから取得するように実装
    switch (vaccineId) {
      case 'hib':
      case 'pneumococcal':
      case 'dpt_ipv':
        return 4;
      case 'bcg':
      case 'mr1':
      case 'mr2':
      case 'japanese_encephalitis_1':
      case 'japanese_encephalitis_2':
        return 1;
      case 'hepatitis_b':
        return 3;
      case 'rotavirus':
        return 2; // または3（ワクチンの種類による）
      default:
        return 1;
    }
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccinationRecord &&
          runtimeType == other.runtimeType &&
          vaccineId == other.vaccineId &&
          vaccineName == other.vaccineName &&
          category == other.category &&
          requirement == other.requirement &&
          _mapEquals(doses, other.doses) &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      vaccineId.hashCode ^
      vaccineName.hashCode ^
      category.hashCode ^
      requirement.hashCode ^
      doses.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'VaccinationRecord(vaccineId: $vaccineId, vaccineName: $vaccineName, '
        'category: $category, requirement: $requirement, doses: $doses, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  /// Mapの等価性をチェック
  bool _mapEquals(Map<int, DoseRecord> map1, Map<int, DoseRecord> map2) {
    if (map1.length != map2.length) return false;
    for (final key in map1.keys) {
      if (!map2.containsKey(key) || map1[key] != map2[key]) {
        return false;
      }
    }
    return true;
  }
}
