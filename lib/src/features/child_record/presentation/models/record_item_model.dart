import '../../child_record.dart';

/// UI-facing representation of a record shown on the table view.
class RecordItemModel {
  RecordItemModel({
    required this.id,
    required this.type,
    required this.at,
    this.amount,
    this.note,
    this.excretionVolume,
    List<String>? tags,
  }) : tags = List.unmodifiable(tags ?? const <String>[]);

  final String id;
  final RecordType type;
  final DateTime at;
  final double? amount;
  final String? note;
  final ExcretionVolume? excretionVolume;
  final List<String> tags;

  RecordItemModel copyWith({
    String? id,
    RecordType? type,
    DateTime? at,
    double? amount,
    String? note,
    ExcretionVolume? excretionVolume,
    List<String>? tags,
  }) {
    return RecordItemModel(
      id: id ?? this.id,
      type: type ?? this.type,
      at: at ?? this.at,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      excretionVolume: excretionVolume ?? this.excretionVolume,
      tags: tags ?? this.tags,
    );
  }
}
