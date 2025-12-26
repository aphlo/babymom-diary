import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../child_record/domain/value/excretion_volume.dart';
import '../../../child_record/domain/value/record_type.dart';

part 'widget_record.freezed.dart';

/// ウィジェットに表示する記録情報
@Freezed(toJson: false, fromJson: false)
sealed class WidgetRecord with _$WidgetRecord {
  const WidgetRecord._();

  const factory WidgetRecord({
    required String id,
    required RecordType type,
    required DateTime at,
    double? amount,
    ExcretionVolume? excretionVolume,
  }) = _WidgetRecord;

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'at': at.toUtc().toIso8601String(),
        if (amount != null) 'amount': amount,
        if (excretionVolume != null) 'excretionVolume': excretionVolume!.name,
      };

  factory WidgetRecord.fromJson(Map<String, dynamic> json) => WidgetRecord(
        id: json['id'] as String,
        type: RecordType.values.byName(json['type'] as String),
        at: DateTime.parse(json['at'] as String),
        amount: json['amount'] as double?,
        excretionVolume: json['excretionVolume'] != null
            ? ExcretionVolume.values.byName(json['excretionVolume'] as String)
            : null,
      );
}
