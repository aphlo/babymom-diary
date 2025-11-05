import '../entities/vaccination_record.dart';
import '../errors/vaccination_persistence_exception.dart';

/// ワクチンスケジュールの重複をチェックするドメインサービス
class VaccineScheduleConflictValidator {
  /// 単一のワクチン予約作成・更新時に重複をチェック
  ///
  /// [record] チェック対象のワクチン接種記録
  /// [scheduledDate] 設定しようとしている予定日
  /// [excludeDoseId] 更新時に除外するdoseId（更新対象のdose自身は除外）
  ///
  /// 同じ日付の予定が既に存在する場合は [DuplicateScheduleDateException] をスロー
  void validateSingleVaccine({
    required VaccinationRecord? record,
    required DateTime scheduledDate,
    String? excludeDoseId,
  }) {
    if (record == null) {
      return;
    }

    final normalizedDate = _normalizeDate(scheduledDate);

    // 既存のdoseで同じ日付を持つものがないかチェック
    for (final dose in record.doses) {
      // 更新時は対象のdose自身を除外
      if (excludeDoseId != null && dose.doseId == excludeDoseId) {
        continue;
      }

      if (dose.scheduledDate != null) {
        final existingDate = _normalizeDate(dose.scheduledDate!);
        if (existingDate.isAtSameMomentAs(normalizedDate)) {
          throw DuplicateScheduleDateException(
            vaccineId: record.vaccineId,
            vaccineName: record.vaccineName,
            scheduledDate: scheduledDate,
          );
        }
      }
    }
  }

  /// 同時接種グループ作成・更新時に、グループ内の全てのワクチンについて重複をチェック
  ///
  /// [records] チェック対象のワクチン接種記録リスト
  /// [scheduledDate] 設定しようとしている予定日
  /// [excludeDoseIds] 更新時に除外するdoseIdのマップ（vaccineId -> doseId）
  ///
  /// いずれかのワクチンで同じ日付の予定が既に存在する場合は [DuplicateScheduleDateException] をスロー
  void validateReservationGroup({
    required List<VaccinationRecord> records,
    required DateTime scheduledDate,
    Map<String, String>? excludeDoseIds,
  }) {
    final errors = <VaccineDuplicateError>[];

    for (final record in records) {
      final excludeDoseId = excludeDoseIds?[record.vaccineId];

      try {
        validateSingleVaccine(
          record: record,
          scheduledDate: scheduledDate,
          excludeDoseId: excludeDoseId,
        );
      } on DuplicateScheduleDateException catch (e) {
        // 個別のエラーを収集
        errors.addAll(e.vaccineErrors);
      }
    }

    // エラーがあった場合は全てまとめて投げる
    if (errors.isNotEmpty) {
      throw DuplicateScheduleDateException.multiple(errors: errors);
    }
  }

  /// 日付を正規化（時間をゼロにする）
  DateTime _normalizeDate(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }
}
