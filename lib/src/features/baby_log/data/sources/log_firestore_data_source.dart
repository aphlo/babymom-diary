import 'package:cloud_firestore/cloud_firestore.dart';
import '../../baby_log.dart';

class LogFirestoreDataSource {
  LogFirestoreDataSource(this.db, this.householdId);
  final FirebaseFirestore db;
  final String householdId;

  static const collectionName = 'entries';

  CollectionReference<Map<String, dynamic>> get _col => db
      .collection('households')
      .doc(householdId)
      .collection(collectionName);

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
      return Entry(
        id: d.id,
        type: EntryType.values.byName(data['type'] as String),
        at: (data['at'] as Timestamp).toDate(),
        amount: (data['amount'] as num?)?.toDouble(),
        note: data['note'] as String?,
      );
    }).toList();
  }

  Future<void> upsert(Entry entry) async {
    await _col.doc(entry.id).set({
      'type': entry.type.name,
      'at': Timestamp.fromDate(entry.at),
      'amount': entry.amount,
      'note': entry.note,
    }, SetOptions(merge: true));
  }

  Future<void> delete(String id) => _col.doc(id).delete();
}
