import 'package:uuid/uuid.dart';
import '../value/entry_type.dart';
import '../value/excretion_volume.dart';

class Entry {
  final String id;
  final EntryType type;
  final DateTime at; // When the event happened
  final double? amount; // ml for feeding, hours for sleep (optional)
  final String? note;
  final int? durationSeconds; // Extra resolution for breastfeeding duration
  final ExcretionVolume? excretionVolume; // Pee/poop intensity
  final List<String> tags; // Misc tags for "other" entries

  Entry({
    String? id,
    required this.type,
    required this.at,
    this.amount,
    this.note,
    this.durationSeconds,
    this.excretionVolume,
    List<String>? tags,
  })  : id = id ?? const Uuid().v4(),
        tags = List.unmodifiable(tags ?? const []);

  Entry copyWith({
    EntryType? type,
    DateTime? at,
    double? amount,
    String? note,
    int? durationSeconds,
    ExcretionVolume? excretionVolume,
    List<String>? tags,
  }) {
    return Entry(
      id: id,
      type: type ?? this.type,
      at: at ?? this.at,
      amount: amount ?? this.amount,
      note: note ?? this.note,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      excretionVolume: excretionVolume ?? this.excretionVolume,
      tags: tags ?? this.tags,
    );
  }
}
