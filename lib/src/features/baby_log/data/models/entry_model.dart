import '../../baby_log.dart';

class EntryModel {
  final String id;
  final String type; // enum name
  final String at;   // ISO8601
  final double? amount;
  final String? note;

  EntryModel({
    required this.id,
    required this.type,
    required this.at,
    this.amount,
    this.note,
  });

  factory EntryModel.fromEntity(Entry e) => EntryModel(
        id: e.id,
        type: e.type.name,
        at: e.at.toIso8601String(),
        amount: e.amount,
        note: e.note,
      );

  Entry toEntity() => Entry(
        id: id,
        type: EntryType.values.byName(type),
        at: DateTime.parse(at),
        amount: amount,
        note: note,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'at': at,
        'amount': amount,
        'note': note,
      };

  factory EntryModel.fromJson(Map<String, dynamic> json) => EntryModel(
        id: json['id'] as String,
        type: json['type'] as String,
        at: json['at'] as String,
        amount: (json['amount'] as num?)?.toDouble(),
        note: json['note'] as String?,
      );
}