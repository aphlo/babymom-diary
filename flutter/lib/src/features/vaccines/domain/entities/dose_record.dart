import 'package:freezed_annotation/freezed_annotation.dart';

part 'dose_record.freezed.dart';

enum DoseStatus { scheduled, completed }

@freezed
sealed class DoseRecord with _$DoseRecord {
  const DoseRecord._();

  const factory DoseRecord({
    required String doseId,
    required DoseStatus status,
    DateTime? scheduledDate,
    String? reservationGroupId,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _DoseRecord;

  /// reservationGroupIdをクリアしたコピーを作成
  DoseRecord clearReservationGroup() {
    return copyWith(
      reservationGroupId: null,
      updatedAt: DateTime.now(),
    );
  }

  /// 予約済み状態に変更
  DoseRecord markAsScheduled(DateTime scheduledDate) {
    return copyWith(
      status: DoseStatus.scheduled,
      scheduledDate: scheduledDate,
      updatedAt: DateTime.now(),
    );
  }

  /// 同時接種グループと結びつけた予約済み状態に変更
  DoseRecord markAsScheduledWithGroup({
    required DateTime scheduledDate,
    required String reservationGroupId,
  }) {
    return copyWith(
      status: DoseStatus.scheduled,
      scheduledDate: scheduledDate,
      reservationGroupId: reservationGroupId,
      updatedAt: DateTime.now(),
    );
  }

  /// 完了状態に変更
  DoseRecord markAsCompleted(DateTime scheduledDate) {
    return copyWith(
      status: DoseStatus.completed,
      scheduledDate: scheduledDate,
      updatedAt: DateTime.now(),
    );
  }
}
