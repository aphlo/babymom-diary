import 'package:cloud_firestore/cloud_firestore.dart';

import '../../child_record.dart';

class GrowthRecordFirestoreDataSource {
  GrowthRecordFirestoreDataSource(this._db, this.householdId);

  final FirebaseFirestore _db;
  final String householdId;

  static const collectionName = 'growthRecords';

  CollectionReference<Map<String, dynamic>> _collection(String childId) {
    return _db
        .collection('households')
        .doc(householdId)
        .collection('children')
        .doc(childId)
        .collection(collectionName);
  }

  Stream<List<GrowthRecord>> watchRecords(String childId) {
    return _collection(childId)
        .orderBy('recordedAt')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => _fromDoc(doc))
          .whereType<GrowthRecord>()
          .toList(growable: false);
    });
  }

  Future<List<GrowthRecord>> fetchRecords(String childId) async {
    final snapshot = await _collection(childId).orderBy('recordedAt').get();
    return snapshot.docs
        .map((doc) => _fromDoc(doc))
        .whereType<GrowthRecord>()
        .toList(growable: false);
  }

  Future<GrowthRecord> addRecord(GrowthRecord record) async {
    final col = _collection(record.childId);
    await col.doc(record.id).set(_toMap(record));
    return record;
  }

  Future<GrowthRecord> updateRecord(GrowthRecord record) async {
    final doc = _collection(record.childId).doc(record.id);
    await doc.set(_toMap(record), SetOptions(merge: true));
    return record;
  }

  Future<void> deleteRecord(String childId, String recordId) async {
    await _collection(childId).doc(recordId).delete();
  }

  Map<String, dynamic> _toMap(GrowthRecord record) {
    return {
      'childId': record.childId,
      'recordedAt': Timestamp.fromDate(record.recordedAt.toUtc()),
      'height': record.height,
      'weight': record.weight,
      'note': record.note,
      'createdAt': record.createdAt != null
          ? Timestamp.fromDate(record.createdAt!)
          : null,
      'updatedAt': record.updatedAt != null
          ? Timestamp.fromDate(record.updatedAt!)
          : null,
    };
  }

  GrowthRecord? _fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    if (data == null) {
      return null;
    }

    DateTime? parseTimestamp(dynamic value) {
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is DateTime) {
        return value;
      }
      return null;
    }

    final recordedAt = parseTimestamp(data['recordedAt']);
    if (recordedAt == null) {
      return null;
    }

    final height = (data['height'] as num?)?.toDouble();
    final weight = (data['weight'] as num?)?.toDouble();

    if (height == null && weight == null) {
      return null;
    }

    return GrowthRecord(
      id: doc.id,
      childId: data['childId'] as String? ?? '',
      recordedAt: recordedAt,
      height: height,
      weight: weight,
      note: data['note'] as String?,
      createdAt: parseTimestamp(data['createdAt']),
      updatedAt: parseTimestamp(data['updatedAt']),
    );
  }
}
