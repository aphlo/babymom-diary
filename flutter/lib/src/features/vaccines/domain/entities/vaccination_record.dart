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
  final List<DoseRecord> doses;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// scheduledDate → createdAt 順でソートされた接種記録を取得
  List<DoseRecord> get orderedDoses {
    final sortedDoses = List<DoseRecord>.from(doses);
    sortedDoses.sort((a, b) {
      // scheduledDate が null の場合は末尾に配置
      if (a.scheduledDate == null && b.scheduledDate == null) {
        return a.createdAt.compareTo(b.createdAt);
      }
      if (a.scheduledDate == null) return 1;
      if (b.scheduledDate == null) return -1;

      final dateComparison = a.scheduledDate!.compareTo(b.scheduledDate!);
      if (dateComparison != 0) return dateComparison;

      return a.createdAt.compareTo(b.createdAt);
    });
    return sortedDoses;
  }

  /// 次回接種可能かどうかを判定
  bool get canScheduleNextDose {
    // 完了済みまたは予約済みの接種回数を取得
    final existingDoses = doses
        .where((dose) =>
            dose.status == DoseStatus.completed ||
            dose.status == DoseStatus.scheduled)
        .length;

    // ワクチンの最大接種回数に基づいて判定
    final maxDoses = _getMaxDosesForVaccine(vaccineId);
    return existingDoses < maxDoses;
  }

  /// 予約済みだが未完了の接種があるかチェック
  bool get hasScheduledDose {
    return doses.any((dose) => dose.status == DoseStatus.scheduled);
  }

  /// 指定されたdoseIdの接種が完了しているかチェック
  bool isDoseCompleted(String doseId) {
    final dose = doses.firstWhere((d) => d.doseId == doseId,
        orElse: () => throw ArgumentError('Dose not found: $doseId'));
    return dose.status == DoseStatus.completed;
  }

  /// 指定されたdoseIdの接種が予約済みかチェック
  bool isDoseScheduled(String doseId) {
    final dose = doses.firstWhere((d) => d.doseId == doseId,
        orElse: () => throw ArgumentError('Dose not found: $doseId'));
    return dose.status == DoseStatus.scheduled;
  }

  /// 指定されたdoseIdの接種記録を取得
  DoseRecord? getDose(String doseId) {
    try {
      return doses.firstWhere((d) => d.doseId == doseId);
    } catch (e) {
      return null;
    }
  }

  /// 指定された回数の接種記録を取得（UI互換性のため）
  /// orderedDosesから指定された回数（1ベース）の記録を取得
  DoseRecord? getDoseByNumber(int doseNumber) {
    final ordered = orderedDoses;
    if (doseNumber < 1 || doseNumber > ordered.length) {
      return null;
    }
    return ordered[doseNumber - 1];
  }

  /// 新しい接種記録を追加したコピーを作成
  VaccinationRecord copyWithDose(DoseRecord doseRecord) {
    final newDoses = List<DoseRecord>.from(doses);
    final existingIndex =
        newDoses.indexWhere((d) => d.doseId == doseRecord.doseId);

    if (existingIndex >= 0) {
      newDoses[existingIndex] = doseRecord;
    } else {
      newDoses.add(doseRecord);
    }

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

  /// 接種記録を削除したコピーを作成
  VaccinationRecord copyWithoutDose(String doseId) {
    final newDoses = doses.where((d) => d.doseId != doseId).toList();

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
    List<DoseRecord>? doses,
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
  /// ワクチンマスタのIDに基づいて最大接種回数を返す
  int _getMaxDosesForVaccine(String vaccineId) {
    switch (vaccineId) {
      // 4回接種
      case 'hib': // ヒブ
      case 'pneumococcal': // 肺炎球菌
      case 'tetravalent': // 4種混合
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

      // 特殊：インフルエンザ注射（毎年2回×複数年）
      case 'influenza_injection':
        return 14;

      // インフルエンザ経鼻（5回）
      case 'influenza_nasal':
        return 5;

      // 1回接種
      case 'bcg':
      default:
        return 1;
    }
  }

  /// 予約済みおよび接種済みの接種をカレンダーイベントに変換
  List<CalendarEvent> toCalendarEvents(String childId) {
    final ordered = orderedDoses;
    return doses
        .where((dose) =>
            dose.scheduledDate != null &&
            (dose.status == DoseStatus.scheduled ||
                dose.status == DoseStatus.completed))
        .map((dose) {
      final sequence = ordered.indexOf(dose) + 1;
      final isCompleted = dose.status == DoseStatus.completed;
      return CalendarEvent(
        id: 'vaccination_${childId}_${vaccineId}_${dose.doseId}',
        title: '$vaccineName $sequence回目${isCompleted ? '（接種済）' : ''}',
        memo: '$vaccineNameの$sequence回目${isCompleted ? 'の接種記録' : 'の接種予定'}です',
        allDay: true,
        start: dose.scheduledDate!,
        end: dose.scheduledDate!,
        iconPath: 'assets/icons/vaccination.png',
      );
    }).toList();
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
          _listEquals(doses, other.doses) &&
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

  /// Listの等価性をチェック
  bool _listEquals(List<DoseRecord> list1, List<DoseRecord> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }
}
