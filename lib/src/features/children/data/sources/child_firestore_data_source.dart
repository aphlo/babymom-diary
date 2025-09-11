import 'package:cloud_firestore/cloud_firestore.dart';

class ChildFirestoreDataSource {
  ChildFirestoreDataSource(this.db, this.householdId);

  final FirebaseFirestore db;
  final String householdId;

  static const collectionName = 'children';

  CollectionReference<Map<String, dynamic>> get _col => db
      .collection('households')
      .doc(householdId)
      .collection(collectionName);

  Query<Map<String, dynamic>> childrenQuery() => _col.orderBy('birthday');

  Future<void> addChild({
    required String name,
    required String gender,
    required DateTime birthday,
    double? birthWeight,
    double? height,
    double? headCircumference,
    double? chestCircumference,
    required String color,
  }) async {
    await _col.add({
      'name': name,
      'gender': gender,
      'birthday': Timestamp.fromDate(birthday),
      'birthWeight': birthWeight,
      'height': height,
      'headCircumference': headCircumference,
      'chestCircumference': chestCircumference,
      'color': color, // hex string like #RRGGBB
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getChild(String id) => _col.doc(id).get();

  Future<void> updateChild({
    required String id,
    required String name,
    required String gender,
    required DateTime birthday,
    double? birthWeight,
    double? height,
    double? headCircumference,
    double? chestCircumference,
    required String color,
  }) async {
    await _col.doc(id).set({
      'name': name,
      'gender': gender,
      'birthday': Timestamp.fromDate(birthday),
      'birthWeight': birthWeight,
      'height': height,
      'headCircumference': headCircumference,
      'chestCircumference': chestCircumference,
      'color': color,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
