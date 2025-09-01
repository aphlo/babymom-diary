import 'package:uuid/uuid.dart';
import '../value/entry_type.dart';

class Entry {
  final String id;
  final EntryType type;
  final DateTime at;       // When the event happened
  final double? amount;    // ml for feeding, hours for sleep (optional)
  final String? note;

  Entry({
    String? id,
    required this.type,
    required this.at,
    this.amount,
    this.note,
  }) : id = id ?? const Uuid().v4();

  Entry copyWith({EntryType? type, DateTime? at, double? amount, String? note}) {
    return Entry(
      id: id,
      type: type ?? this.type,
      at: at ?? this.at,
      amount: amount ?? this.amount,
      note: note ?? this.note,
    );
  }
}