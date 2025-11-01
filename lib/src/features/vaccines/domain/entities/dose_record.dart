import 'package:meta/meta.dart';

enum DoseStatus { scheduled, completed, skipped }

@immutable
class DoseRecord {
  const DoseRecord({
    required this.doseNumber,
    required this.status,
    this.scheduledDate,
    this.completedDate,
  });

  final int doseNumber;
  final DoseStatus status;
  final DateTime? scheduledDate;
  final DateTime? completedDate;

  /// 接種記録のコピーを作成
  DoseRecord copyWith({
    int? doseNumber,
    DoseStatus? status,
    DateTime? scheduledDate,
    DateTime? completedDate,
  }) {
    return DoseRecord(
      doseNumber: doseNumber ?? this.doseNumber,
      status: status ?? this.status,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      completedDate: completedDate ?? this.completedDate,
    );
  }

  /// 予約済み状態に変更
  DoseRecord markAsScheduled(DateTime scheduledDate) {
    return copyWith(
      status: DoseStatus.scheduled,
      scheduledDate: scheduledDate,
    );
  }

  /// 完了状態に変更
  DoseRecord markAsCompleted(DateTime completedDate) {
    return copyWith(
      status: DoseStatus.completed,
      completedDate: completedDate,
    );
  }

  /// スキップ状態に変更
  DoseRecord markAsSkipped() {
    return copyWith(
      status: DoseStatus.skipped,
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
          completedDate == other.completedDate;

  @override
  int get hashCode =>
      doseNumber.hashCode ^
      status.hashCode ^
      scheduledDate.hashCode ^
      completedDate.hashCode;

  @override
  String toString() {
    return 'DoseRecord(doseNumber: $doseNumber, status: $status, '
        'scheduledDate: $scheduledDate, completedDate: $completedDate)';
  }
}
