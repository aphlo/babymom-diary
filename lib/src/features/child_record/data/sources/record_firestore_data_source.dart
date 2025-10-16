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
      final type = _parseRecordType(data);
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

  RecordType _parseRecordType(Map<String, dynamic> data) {
    final rawType = data['type'] as String?;
    if (rawType == null) {
      return RecordType.other;
    }

    return _legacyRecordTypeMapping[rawType] ??
        RecordType.values.firstWhere(
          (value) => value.name == rawType,
          orElse: () => RecordType.other,
        );
  }

  static const Map<String, RecordType> _legacyRecordTypeMapping = {
    'feeding': RecordType.formula,
  };
}
