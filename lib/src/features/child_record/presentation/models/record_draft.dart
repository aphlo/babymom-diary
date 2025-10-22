import '../../child_record.dart';

/// Mutable representation used when creating or editing a record from the UI.
class RecordDraft {
  RecordDraft({
    this.id,
    required this.type,
    required this.at,
    this.amount,
    this.note,
    this.excretionVolume,
    Iterable<String>? tags,
  }) : tags = List.unmodifiable(
          (tags ?? const <String>[])
              .map((tag) => tag.trim())
              .where((tag) => tag.isNotEmpty),
        );

  final String? id;
  final RecordType type;
  final DateTime at;
  final double? amount;
  final String? note;
  final ExcretionVolume? excretionVolume;
  final List<String> tags;

  RecordDraft copyWith({
    String? id,
    RecordType? type,
    DateTime? at,
    double? amount,
    String? note,
    ExcretionVolume? excretionVolume,
    Iterable<String>? tags,
  }) {
    return RecordDraft(
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
