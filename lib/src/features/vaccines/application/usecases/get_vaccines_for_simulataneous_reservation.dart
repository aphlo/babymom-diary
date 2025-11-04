import '../../domain/entities/vaccine.dart';
import '../../domain/entities/vaccination_record.dart';
import '../../domain/repositories/vaccine_master_repository.dart';
import '../../domain/repositories/vaccination_record_repository.dart';
import '../../../children/domain/entities/child_summary.dart';
import '../../domain/value_objects/vaccine_category.dart' as vo_category;
import '../../domain/value_objects/vaccine_requirement.dart' as vo_requirement;

/// 子供の既存の接種記録に基づいて、予約可能なワクチンを取得するユースケース
class GetVaccinesForSimultaneousReservation {
  GetVaccinesForSimultaneousReservation({
    required VaccineMasterRepository vaccineMasterRepository,
    required VaccinationRecordRepository vaccinationRecordRepository,
  })  : _vaccineMasterRepository = vaccineMasterRepository,
        _vaccinationRecordRepository = vaccinationRecordRepository;

  final VaccineMasterRepository _vaccineMasterRepository;
  final VaccinationRecordRepository _vaccinationRecordRepository;

  /// 指定した子供の年齢と接種履歴に基づいて、接種可能なワクチンの一覧を取得
  Future<List<VaccinationRecord>> call({
    required String householdId,
    required String childId,
    required ChildSummary child,
    DateTime? referenceDate,
  }) async {
    final currentDate = referenceDate ?? DateTime.now();
    final birthday = child.birthday;

    if (birthday == null) {
      return [];
    }

    // 全てのワクチンマスタデータを取得
    final allVaccines = await _vaccineMasterRepository.getAllVaccines();

    // 既存の接種記録を取得
    final existingRecords = await _vaccinationRecordRepository
        .watchVaccinationRecords(
          householdId: householdId,
          childId: childId,
        )
        .first;

    final availableVaccines = <VaccinationRecord>[];

    for (final vaccine in allVaccines) {
      // 既存の接種記録を検索
      final matchingRecords =
          existingRecords.where((record) => record.vaccineId == vaccine.id);
      final existingRecord =
          matchingRecords.isNotEmpty ? matchingRecords.first : null;

      if (existingRecord != null) {
        // 既存記録がある場合、次回接種可能かチェック
        final nextDose = existingRecord.nextAvailableDose;

        if (nextDose != null) {
          // 次回接種が可能な場合は、予約済みの接種があっても同時接種の選択肢に表示
          // ただし、次回接種自体が既に予約済みでないことを確認
          final isNextDoseScheduled = existingRecord.isDoseScheduled(nextDose);

          if (!isNextDoseScheduled) {
            availableVaccines.add(existingRecord);
          }
        }
      } else {
        // 新規のワクチンの場合、年齢に関係なく全て表示
        final newRecord = VaccinationRecord(
          vaccineId: vaccine.id,
          vaccineName: vaccine.name,
          category: _mapVaccineCategory(vaccine.category),
          requirement: _mapVaccineRequirement(vaccine.requirement),
          doses: const {},
          createdAt: currentDate,
          updatedAt: currentDate,
        );
        availableVaccines.add(newRecord);
      }
    }

    return availableVaccines;
  }

  /// ドメインのVaccineCategoryを値オブジェクトにマップ
  vo_category.VaccineCategory _mapVaccineCategory(VaccineCategory category) {
    switch (category) {
      case VaccineCategory.live:
        return vo_category.VaccineCategory.live;
      case VaccineCategory.inactivated:
        return vo_category.VaccineCategory.inactivated;
    }
  }

  /// ドメインのVaccineRequirementを値オブジェクトにマップ
  vo_requirement.VaccineRequirement _mapVaccineRequirement(
      VaccineRequirement requirement) {
    switch (requirement) {
      case VaccineRequirement.mandatory:
        return vo_requirement.VaccineRequirement.mandatory;
      case VaccineRequirement.optional:
        return vo_requirement.VaccineRequirement.optional;
    }
  }
}
