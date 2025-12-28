import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/custom_ingredient.dart';
import '../../domain/value_objects/food_category.dart';
import '../models/custom_ingredient_dto.dart';

/// カスタム食材のFirestoreデータソース
class CustomIngredientFirestoreDataSource {
  CustomIngredientFirestoreDataSource({
    required this.householdId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final String householdId;
  final FirebaseFirestore _firestore;

  /// コレクションパス: households/{householdId}/custom_ingredients
  CollectionReference<Map<String, dynamic>> get _collectionRef {
    return _firestore
        .collection('households')
        .doc(householdId)
        .collection('custom_ingredients');
  }

  /// 全てのカスタム食材を取得
  Future<List<CustomIngredient>> getAll() async {
    final snapshot = await _collectionRef.orderBy('createdAt').get();

    return snapshot.docs.map((doc) {
      return CustomIngredientDto.fromFirestore(doc.data(), docId: doc.id)
          .toDomain();
    }).toList();
  }

  /// 全てのカスタム食材をストリームで監視
  Stream<List<CustomIngredient>> watchAll() {
    return _collectionRef.orderBy('createdAt').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CustomIngredientDto.fromFirestore(doc.data(), docId: doc.id)
            .toDomain();
      }).toList();
    });
  }

  /// カテゴリごとのカスタム食材を取得
  Future<List<CustomIngredient>> getByCategory(FoodCategory category) async {
    final snapshot = await _collectionRef
        .where('categoryId', isEqualTo: category.name)
        .orderBy('createdAt')
        .get();

    return snapshot.docs.map((doc) {
      return CustomIngredientDto.fromFirestore(doc.data(), docId: doc.id)
          .toDomain();
    }).toList();
  }

  /// カスタム食材を追加
  Future<void> add(CustomIngredient ingredient) async {
    final dto = CustomIngredientDto.fromDomain(ingredient);
    await _collectionRef.doc(ingredient.id).set(dto.toJson());
  }

  /// カスタム食材を削除
  Future<void> delete(String ingredientId) async {
    await _collectionRef.doc(ingredientId).delete();
  }
}
