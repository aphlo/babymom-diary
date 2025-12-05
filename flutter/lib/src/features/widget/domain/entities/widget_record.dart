import 'package:meta/meta.dart';

import '../../../child_record/domain/value/excretion_volume.dart';
import '../../../child_record/domain/value/record_type.dart';

/// ウィジェットに表示する記録情報
@immutable
class WidgetRecord {
  final String id;
  final RecordType type;
  final DateTime at;
  final double? amount;
  final ExcretionVolume? excretionVolume;

  const WidgetRecord({
    required this.id,
    required this.type,
    required this.at,
    this.amount,
    this.excretionVolume,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type.name,
        'at': at.toIso8601String(),
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WidgetRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          type == other.type &&
          at == other.at &&
          amount == other.amount &&
          excretionVolume == other.excretionVolume;

  @override
  int get hashCode => Object.hash(id, type, at, amount, excretionVolume);
}
