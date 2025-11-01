import '../entities/vaccination_record.dart';
import '../entities/vaccine_reservation_request.dart';
import '../entities/vaccination_schedule.dart';

abstract class VaccinationRecordRepository {
  /// 指定した子供のワクチン接種記録を監視
  Stream<List<VaccinationRecord>> watchVaccinationRecords({
    required String householdId,
    required String childId,
  });

  /// 指定した子供の特定のワクチン接種記録を監視
  Stream<VaccinationRecord?> watchVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  });

  /// 指定した子供の特定のワクチン接種記録を取得
  Future<VaccinationRecord?> getVaccinationRecord({
    required String householdId,
    required String childId,
    required String vaccineId,
  });

  /// ワクチン接種の予約を作成
  Future<void> createVaccineReservation({
    required String householdId,
    required VaccineReservationRequest request,
  });

  /// 複数のワクチン接種の予約を同時に作成（同時接種用）
  Future<void> createMultipleVaccineReservations({
    required String householdId,
    required List<VaccineReservationRequest> requests,
  });

  /// ワクチン接種の予約を更新
  Future<void> updateVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
    required DateTime scheduledDate,
  });

  /// ワクチン接種を完了状態に更新
  Future<void> completeVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
    required DateTime completedDate,
  });

  /// ワクチン接種をスキップ状態に更新
  Future<void> skipVaccination({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
  });

  /// ワクチン接種の予約を削除
  Future<void> deleteVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
  });

  /// 指定した期間のワクチン接種予定を取得（カレンダー表示用）
  Future<List<VaccinationSchedule>> getVaccinationSchedules({
    required String householdId,
    required String childId,
    required DateTime startDate,
    required DateTime endDate,
  });

  /// 指定した日付のワクチン接種予定を取得
  Future<List<VaccinationSchedule>> getVaccinationSchedulesForDate({
    required String householdId,
    required String childId,
    required DateTime date,
  });

  /// 予約可能なワクチンの一覧を取得（同時接種選択用）
  Future<List<VaccinationRecord>> getAvailableVaccinesForReservation({
    required String householdId,
    required String childId,
  });
}
