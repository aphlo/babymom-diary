import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../../core/types/gender.dart';

class ChildFirestoreDataSource {
  ChildFirestoreDataSource(this.db, this.householdId);

  final FirebaseFirestore db;
  final String householdId;

  static const collectionName = 'children';

  CollectionReference<Map<String, dynamic>> get _col =>
      db.collection('households').doc(householdId).collection(collectionName);

  Query<Map<String, dynamic>> childrenQuery() => _col.orderBy('birthday');

  Future<String> addChild({
    required String name,
    required Gender gender,
    required DateTime birthday,
    DateTime? dueDate,
  }) async {
    final docRef = await _col.add({
      'name': name,
      'gender': gender.key,
      'birthday': Timestamp.fromDate(birthday),
      if (dueDate != null) 'dueDate': Timestamp.fromDate(dueDate),
      'createdAt': FieldValue.serverTimestamp(),
    });
    return docRef.id;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getChild(String id) =>
      _col.doc(id).get();

  Future<void> updateChild({
    required String id,
    required String name,
    required Gender gender,
    required DateTime birthday,
    DateTime? dueDate,
  }) async {
    await _col.doc(id).set({
      'name': name,
      'gender': gender.key,
      'birthday': Timestamp.fromDate(birthday),
      if (dueDate != null) 'dueDate': Timestamp.fromDate(dueDate),
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
