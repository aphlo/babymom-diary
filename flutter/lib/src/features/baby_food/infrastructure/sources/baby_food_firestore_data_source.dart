import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/entities/baby_food_record.dart';
import '../models/baby_food_record_dto.dart';

/// 離乳食記録のFirestoreデータソース
class BabyFoodFirestoreDataSource {
  BabyFoodFirestoreDataSource({
    required this.householdId,
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final String householdId;
  final FirebaseFirestore _firestore;

  /// コレクションパス: households/{householdId}/children/{childId}/babyFoodRecords
  CollectionReference<Map<String, dynamic>> _collectionRef(String childId) {
    return _firestore
        .collection('households')
        .doc(householdId)
        .collection('children')
        .doc(childId)
        .collection('babyFoodRecords');
  }

  /// 指定した日の離乳食記録を取得
  Future<List<BabyFoodRecord>> getForDay(String childId, DateTime day) async {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final snapshot = await _collectionRef(childId)
        .where('recordedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('recordedAt', isLessThan: Timestamp.fromDate(endOfDay))
        .orderBy('recordedAt')
        .get();

    return snapshot.docs.map((doc) {
      return BabyFoodRecordDto.fromFirestore(doc.data(), docId: doc.id)
          .toDomain();
    }).toList();
  }

  /// 指定した日の離乳食記録をストリームで監視
  Stream<List<BabyFoodRecord>> watchForDay(String childId, DateTime day) {
    final startOfDay = DateTime(day.year, day.month, day.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return _collectionRef(childId)
        .where('recordedAt',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay))
        .where('recordedAt', isLessThan: Timestamp.fromDate(endOfDay))
        .orderBy('recordedAt')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BabyFoodRecordDto.fromFirestore(doc.data(), docId: doc.id)
            .toDomain();
      }).toList();
    });
  }

  /// 全ての離乳食記録をストリームで監視
  Stream<List<BabyFoodRecord>> watchAll(String childId) {
    return _collectionRef(childId)
        .orderBy('recordedAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return BabyFoodRecordDto.fromFirestore(doc.data(), docId: doc.id)
            .toDomain();
      }).toList();
    });
  }

  /// 離乳食記録を追加
  Future<void> add(String childId, BabyFoodRecord record) async {
    final dto = BabyFoodRecordDto.fromDomain(record);
    await _collectionRef(childId).doc(record.id).set(dto.toJson());
  }

  /// 離乳食記録を更新
  Future<void> update(String childId, BabyFoodRecord record) async {
    final dto = BabyFoodRecordDto.fromDomain(record);
    await _collectionRef(childId).doc(record.id).update(dto.toJson());
  }

  /// 離乳食記録を削除
  Future<void> delete(String childId, String recordId) async {
    await _collectionRef(childId).doc(recordId).delete();
  }
}
