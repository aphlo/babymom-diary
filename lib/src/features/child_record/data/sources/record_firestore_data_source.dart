import 'package:cloud_firestore/cloud_firestore.dart';
import '../../child_record.dart';

class RecordFirestoreDataSource {
  RecordFirestoreDataSource(this.db, this.householdId);
  final FirebaseFirestore db;
  final String householdId;

  static const collectionName = 'records';

  CollectionReference<Map<String, dynamic>> _col(String childId) => db
      .collection('households')
      .doc(householdId)
      .collection('children')
      .doc(childId)
      .collection(collectionName);

  Future<List<Record>> getForDay(String childId, DateTime day) async {
    final start = DateTime(day.year, day.month, day.day);
    final end = start.add(const Duration(days: 1));
    final snap = await _col(childId)
        .where('at', isGreaterThanOrEqualTo: Timestamp.fromDate(start))
        .where('at', isLessThan: Timestamp.fromDate(end))
        .orderBy('at', descending: true)
        .get();

    return snap.docs.map((d) {
      final data = d.data();
      RecordType type;
      final rawType = data['type'] as String?;
      try {
        type = rawType != null
            ? RecordType.values.byName(rawType)
            : RecordType.other;
      } catch (_) {
        // Backward compatibility: map old types to new ones
        switch (rawType) {
          case 'feeding':
            type = RecordType.formula;
            break;
          default:
            type = RecordType.other;
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
      return Record(
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

  Future<void> upsert(String childId, Record record) async {
    await _col(childId).doc(record.id).set({
      'type': record.type.name,
      'at': Timestamp.fromDate(record.at),
      'amount': record.amount,
      'note': record.note,
      'durationSeconds': record.durationSeconds,
      'excretionVolume': record.excretionVolume?.name,
      'tags': record.tags,
    }, SetOptions(merge: true));
  }

  Future<void> delete(String childId, String id) =>
      _col(childId).doc(id).delete();
}
