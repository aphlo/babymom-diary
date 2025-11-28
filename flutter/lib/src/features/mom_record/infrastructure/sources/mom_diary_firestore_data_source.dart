import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/mom_diary_dto.dart';

class MomDiaryFirestoreDataSource {
  MomDiaryFirestoreDataSource({
    required FirebaseFirestore firestore,
    required String householdId,
  })  : _firestore = firestore,
        _householdId = householdId;

  final FirebaseFirestore _firestore;
  final String _householdId;

  static const String collectionName = 'momDiary';

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('households').doc(_householdId).collection(
            collectionName,
          );

  Future<List<MomDiaryDto>> fetchMonthlyDiary({
    required int year,
    required int month,
  }) async {
    final start = DateTime(year, month, 1);
    final endExclusive = DateTime(year, month + 1, 1);

    final query = _collection
        .where(
          'date',
          isGreaterThanOrEqualTo: Timestamp.fromDate(start),
        )
        .where(
          'date',
          isLessThan: Timestamp.fromDate(endExclusive),
        )
        .orderBy('date');

    final snapshot = await query.get();
    if (snapshot.docs.isEmpty) {
      return const <MomDiaryDto>[];
    }
    return snapshot.docs.map(MomDiaryDto.fromFirestore).toList(growable: false);
  }

  /// 特定の日付の日記をリアルタイムで監視
  Stream<MomDiaryDto?> watchDiaryForDate({
    required DateTime date,
  }) {
    final docId = DateFormat('yyyy-MM-dd').format(date);
    return _collection.doc(docId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }
      return MomDiaryDto.fromFirestore(snapshot);
    });
  }

  Future<void> upsertDiary(MomDiaryDto dto) async {
    final docId = DateFormat('yyyy-MM-dd').format(dto.date);
    final data = dto.toFirestoreMap();
    await _collection.doc(docId).set(
          data,
          SetOptions(merge: true),
        );
  }
}
