import 'package:cloud_firestore/cloud_firestore.dart';

/// 非表示にしたデフォルト食材を管理するデータソース
class HiddenIngredientsFirestoreDataSource {
  HiddenIngredientsFirestoreDataSource({required this.householdId});

  final String householdId;

  DocumentReference<Map<String, dynamic>> get _docRef =>
      FirebaseFirestore.instance
          .collection('households')
          .doc(householdId)
          .collection('settings')
          .doc('hidden_ingredients');

  /// 非表示食材IDのリストを監視
  Stream<Set<String>> watch() {
    return _docRef.snapshots().map((snapshot) {
      if (!snapshot.exists) return <String>{};
      final data = snapshot.data();
      if (data == null) return <String>{};
      final ids = data['ingredient_ids'] as List<dynamic>?;
      if (ids == null) return <String>{};
      return ids.cast<String>().toSet();
    });
  }

  /// 非表示食材IDのリストを取得
  Future<Set<String>> get() async {
    final snapshot = await _docRef.get();
    if (!snapshot.exists) return <String>{};
    final data = snapshot.data();
    if (data == null) return <String>{};
    final ids = data['ingredient_ids'] as List<dynamic>?;
    if (ids == null) return <String>{};
    return ids.cast<String>().toSet();
  }

  /// 食材を非表示にする
  Future<void> hide(String ingredientId) async {
    await _docRef.set({
      'ingredient_ids': FieldValue.arrayUnion([ingredientId]),
    }, SetOptions(merge: true));
  }

  /// 食材の非表示を解除する
  Future<void> unhide(String ingredientId) async {
    await _docRef.set({
      'ingredient_ids': FieldValue.arrayRemove([ingredientId]),
    }, SetOptions(merge: true));
  }
}
