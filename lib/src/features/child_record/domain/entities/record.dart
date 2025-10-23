import '../value/record_type.dart';
import '../value/excretion_volume.dart';

class Record {
  final String id;
  final RecordType type;
  final DateTime at; // When the event happened
  final double? amount; // ml for feeding, hours for sleep (optional)
  final String? note;
  final ExcretionVolume? excretionVolume; // Pee/poop intensity
  final List<String> tags; // Misc tags for "other" records

  Record({
    String? id,
    required this.type,
    required this.at,
    this.amount,
    this.note,
    this.excretionVolume,
    List<String>? tags,
  })  : id = id ?? _generateId(type, at),
        tags = List.unmodifiable(tags ?? const []);

  Record copyWith({
    RecordType? type,
    DateTime? at,
    double? amount,
    String? note,
    ExcretionVolume? excretionVolume,
    List<String>? tags,
  }) {
    return Record(
      id: id,
      type: type ?? this.type,
      at: at ?? this.at,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      excretionVolume: excretionVolume ?? this.excretionVolume,
      tags: tags ?? this.tags,
    );
  }
}

String _formatTwoDigits(int value) => value.toString().padLeft(2, '0');

String _generateId(RecordType type, DateTime at) {
  final datePart =
      '${at.year.toString().padLeft(4, '0')}-${_formatTwoDigits(at.month)}-${_formatTwoDigits(at.day)}';
  final hourPart = _formatTwoDigits(at.hour);
  final unique =
      DateTime.now().microsecondsSinceEpoch.toRadixString(36).padLeft(8, '0');
  return '$datePart-$hourPart-${type.name}-$unique';
}
