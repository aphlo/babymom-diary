import 'package:meta/meta.dart';

import 'dose_record.dart';
import '../value_objects/vaccine_category.dart';
import '../value_objects/vaccine_requirement.dart';
import '../../../calendar/domain/entities/calendar_event.dart';

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
    // 完了済みまたは予約済みの接種回数を取得
    final existingDoses = doses.values
        .where((dose) =>
            dose.status == DoseStatus.completed ||
            dose.status == DoseStatus.scheduled)
        .length;

    // ワクチンの最大接種回数に基づいて判定
    final maxDoses = _getMaxDosesForVaccine(vaccineId);
    if (existingDoses >= maxDoses) return null;

    return existingDoses + 1;
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

  /// ワクチンの最大接種回数を取得
  int _getMaxDosesForVaccine(String vaccineId) {
    switch (vaccineId) {
      // 4回接種
      case 'hib':
      case 'pneumococcal':
      case 'dpt_ipv':
      case 'pentavalent': // 5種混合
        return 4;

      // 3回接種
      case 'hepatitis_b': // B型肝炎
      case 'japanese_encephalitis': // 日本脳炎
      case 'rotavirus_pentavalent': // ロタウィルス(5価)
        return 3;

      // 2回接種
      case 'varicella': // 水痘
      case 'measles_rubella': // 麻疹風疹(MR)
      case 'mumps': // おたふくかぜ
      case 'rotavirus_monovalent': // ロタウィルス(1価)
        return 2;

      // 特殊：インフルエンザ（毎年2回×複数年）
      case 'influenza':
        return 14;

      // 1回接種
      case 'bcg':
      default:
        return 1;
    }
  }

  /// 予約済みの接種をカレンダーイベントに変換
  List<CalendarEvent> toCalendarEvents(String childId) {
    return doses.entries
        .where((entry) => entry.value.status == DoseStatus.scheduled)
        .map((entry) => CalendarEvent(
              id: 'vaccination_${childId}_${vaccineId}_${entry.key}',
              title: '$vaccineName ${entry.key}回目',
              memo: '$vaccineNameの${entry.key}回目の接種予定です',
              allDay: true,
              start: entry.value.scheduledDate!,
              end: entry.value.scheduledDate!,
              iconPath: 'assets/icons/vaccination.png',
            ))
        .toList();
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
