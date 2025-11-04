import 'package:meta/meta.dart';

enum DoseStatus { scheduled, completed }

@immutable
class DoseRecord {
  const DoseRecord({
    required this.doseNumber,
    required this.status,
    this.scheduledDate,
    this.completedDate,
    this.reservationGroupId,
  });

  final int doseNumber;
  final DoseStatus status;
  final DateTime? scheduledDate;
  final DateTime? completedDate;
  final String? reservationGroupId;

  /// 接種記録のコピーを作成
  DoseRecord copyWith({
    int? doseNumber,
    DoseStatus? status,
    DateTime? scheduledDate,
    DateTime? completedDate,
    String? reservationGroupId,
    bool clearReservationGroup = false,
  }) {
    return DoseRecord(
      doseNumber: doseNumber ?? this.doseNumber,
      status: status ?? this.status,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      completedDate: completedDate ?? this.completedDate,
      reservationGroupId: clearReservationGroup
          ? null
          : (reservationGroupId ?? this.reservationGroupId),
    );
  }

  /// 予約済み状態に変更
  DoseRecord markAsScheduled(DateTime scheduledDate) {
    return copyWith(
      status: DoseStatus.scheduled,
      scheduledDate: scheduledDate,
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
    );
  }

  /// 完了状態に変更
  DoseRecord markAsCompleted(DateTime completedDate) {
    return copyWith(
      status: DoseStatus.completed,
      completedDate: completedDate,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoseRecord &&
          runtimeType == other.runtimeType &&
          doseNumber == other.doseNumber &&
          status == other.status &&
          scheduledDate == other.scheduledDate &&
          completedDate == other.completedDate &&
          reservationGroupId == other.reservationGroupId;

  @override
  int get hashCode =>
      doseNumber.hashCode ^
      status.hashCode ^
      scheduledDate.hashCode ^
      completedDate.hashCode ^
      reservationGroupId.hashCode;

  @override
  String toString() {
    return 'DoseRecord(doseNumber: $doseNumber, status: $status, '
        'scheduledDate: $scheduledDate, completedDate: $completedDate, '
        'reservationGroupId: $reservationGroupId)';
  }
}
