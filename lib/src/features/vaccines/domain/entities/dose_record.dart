import 'package:meta/meta.dart';

enum DoseStatus { scheduled, completed }

@immutable
class DoseRecord {
  const DoseRecord({
    required this.doseId,
    required this.status,
    this.scheduledDate,
    this.reservationGroupId,
    required this.createdAt,
    required this.updatedAt,
  });

  final String doseId;
  final DoseStatus status;
  final DateTime? scheduledDate;
  final String? reservationGroupId;
  final DateTime createdAt;
  final DateTime updatedAt;

  /// 接種記録のコピーを作成
  DoseRecord copyWith({
    String? doseId,
    DoseStatus? status,
    DateTime? scheduledDate,
    String? reservationGroupId,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool clearReservationGroup = false,
  }) {
    return DoseRecord(
      doseId: doseId ?? this.doseId,
      status: status ?? this.status,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      reservationGroupId: clearReservationGroup
          ? null
          : (reservationGroupId ?? this.reservationGroupId),
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? DateTime.now(),
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DoseRecord &&
          runtimeType == other.runtimeType &&
          doseId == other.doseId &&
          status == other.status &&
          scheduledDate == other.scheduledDate &&
          reservationGroupId == other.reservationGroupId &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt;

  @override
  int get hashCode =>
      doseId.hashCode ^
      status.hashCode ^
      scheduledDate.hashCode ^
      reservationGroupId.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode;

  @override
  String toString() {
    return 'DoseRecord(doseId: $doseId, status: $status, '
        'scheduledDate: $scheduledDate, '
        'reservationGroupId: $reservationGroupId, '
        'createdAt: $createdAt, updatedAt: $updatedAt)';
  }
}
