import 'package:meta/meta.dart';

import '../value_objects/vaccine_category.dart';
import '../value_objects/vaccine_requirement.dart';

@immutable
class VaccinationSchedule {
  const VaccinationSchedule({
    required this.childId,
    required this.vaccineId,
    required this.vaccineName,
    required this.doseNumber,
    required this.scheduledDate,
    required this.category,
    required this.requirement,
  });

  final String childId;
  final String vaccineId;
  final String vaccineName;
  final int doseNumber;
  final DateTime scheduledDate;
  final VaccineCategory category;
  final VaccineRequirement requirement;

  /// カレンダー表示用のタイトルを生成
  String get displayTitle => '$vaccineName $doseNumber回目';

  /// カレンダー表示用のアイコンパスを取得
  String get iconPath => 'assets/icons/vaccination.png';

  /// ワクチン接種予定のコピーを作成
  VaccinationSchedule copyWith({
    String? childId,
    String? vaccineId,
    String? vaccineName,
    int? doseNumber,
    DateTime? scheduledDate,
    VaccineCategory? category,
    VaccineRequirement? requirement,
  }) {
    return VaccinationSchedule(
      childId: childId ?? this.childId,
      vaccineId: vaccineId ?? this.vaccineId,
      vaccineName: vaccineName ?? this.vaccineName,
      doseNumber: doseNumber ?? this.doseNumber,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      category: category ?? this.category,
      requirement: requirement ?? this.requirement,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccinationSchedule &&
          runtimeType == other.runtimeType &&
          childId == other.childId &&
          vaccineId == other.vaccineId &&
          vaccineName == other.vaccineName &&
          doseNumber == other.doseNumber &&
          scheduledDate == other.scheduledDate &&
          category == other.category &&
          requirement == other.requirement;

  @override
  int get hashCode =>
      childId.hashCode ^
      vaccineId.hashCode ^
      vaccineName.hashCode ^
      doseNumber.hashCode ^
      scheduledDate.hashCode ^
      category.hashCode ^
      requirement.hashCode;

  @override
  String toString() {
    return 'VaccinationSchedule(childId: $childId, vaccineId: $vaccineId, '
        'vaccineName: $vaccineName, doseNumber: $doseNumber, '
        'scheduledDate: $scheduledDate, category: $category, '
        'requirement: $requirement)';
  }
}
