import '../entities/vaccination_record.dart';
import '../entities/vaccine_reservation_request.dart';
import '../entities/reservation_group.dart';

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

  /// 同時接種グループとして予約を作成
  Future<String> createReservationGroup({
    required String householdId,
    required String childId,
    required DateTime scheduledDate,
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

  /// 同時接種グループの予約日時を更新
  Future<void> updateReservationGroupSchedule({
    required String householdId,
    required String childId,
    required String reservationGroupId,
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

  /// 同時接種グループをまとめて完了状態に更新
  Future<void> completeReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required DateTime completedDate,
  });

  /// 同時接種グループの特定メンバーのみ完了状態に更新
  Future<void> completeReservationGroupMember({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String vaccineId,
    required int doseNumber,
    required DateTime completedDate,
  });

  /// ワクチン接種の予約を削除
  Future<void> deleteVaccineReservation({
    required String householdId,
    required String childId,
    required String vaccineId,
    required int doseNumber,
  });

  /// 同時接種グループの予約をまとめて削除
  Future<void> deleteReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  });

  /// 同時接種グループの特定メンバーのみ削除
  Future<void> deleteReservationGroupMember({
    required String householdId,
    required String childId,
    required String reservationGroupId,
    required String vaccineId,
    required int doseNumber,
  });

  /// 予約可能なワクチンの一覧を取得（同時接種選択用）
  Future<List<VaccinationRecord>> getAvailableVaccinesForReservation({
    required String householdId,
    required String childId,
  });

  /// 同時接種グループ情報を取得
  Future<VaccinationReservationGroup?> getReservationGroup({
    required String householdId,
    required String childId,
    required String reservationGroupId,
  });
}
