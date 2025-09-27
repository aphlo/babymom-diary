import 'package:cloud_firestore/cloud_firestore.dart';
import '../../baby_log.dart';

class LogFirestoreDataSource {
  LogFirestoreDataSource(this.db, this.householdId);
  final FirebaseFirestore db;
  final String householdId;

  static const collectionName = 'entries';

  CollectionReference<Map<String, dynamic>> get _col =>
      db.collection('households').doc(householdId).collection(collectionName);

  Future<List<Entry>> getForDay(DateTime day) async {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    final snap = await _col
        .where('at', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('at', isLessThan: Timestamp.fromDate(end))
        .orderBy('at', descending: true)
        .get();

    return snap.docs.map((d) {
      final data = d.data();
      EntryType type;
      final rawType = data['type'] as String?;
      try {
        type = rawType != null
            ? EntryType.values.byName(rawType)
            : EntryType.other;
      } catch (_) {
        // Backward compatibility: map old types to new ones
        switch (rawType) {
          case 'feeding':
            type = EntryType.formula;
            break;
          default:
            type = EntryType.other;
        }
      }
      ExcretionVolume? excretionVolume;
      final rawVolume = data['excretionVolume'] as String?;
      if (rawVolume != null) {
        try {
          excretionVolume = ExcretionVolume.values.byName(rawVolume);
        } catch (_) {
          excretionVolume = null;
        }
      }
      final tags = (data['tags'] as List?)
              ?.whereType<String>()
              .toList(growable: false) ??
          const [];
      return Entry(
        id: d.id,
        type: type,
        at: (data['at'] as Timestamp).toDate(),
        amount: (data['amount'] as num?)?.toDouble(),
        note: data['note'] as String?,
        durationSeconds: (data['durationSeconds'] as num?)?.toInt(),
        excretionVolume: excretionVolume,
        tags: tags,
      );
    }).toList();
  }

  Future<void> upsert(Entry entry) async {
    await _col.doc(entry.id).set({
      'type': entry.type.name,
      'at': Timestamp.fromDate(entry.at),
      'amount': entry.amount,
      'note': entry.note,
      'durationSeconds': entry.durationSeconds,
      'excretionVolume': entry.excretionVolume?.name,
      'tags': entry.tags,
    }, SetOptions(merge: true));
  }

  Future<void> delete(String id) => _col.doc(id).delete();
}
