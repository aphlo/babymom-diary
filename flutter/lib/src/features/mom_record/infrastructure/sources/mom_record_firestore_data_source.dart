import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

import '../models/mom_record_dto.dart';

class MomRecordFirestoreDataSource {
  MomRecordFirestoreDataSource({
    required FirebaseFirestore firestore,
    required String householdId,
  })  : _firestore = firestore,
        _householdId = householdId;

  final FirebaseFirestore _firestore;
  final String _householdId;

  static const String collectionName = 'momRecords';

  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection('households').doc(_householdId).collection(
            collectionName,
          );

  Future<List<MomRecordDto>> fetchMonthlyRecords({
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
      return const <MomRecordDto>[];
    }
    return snapshot.docs
        .map(MomRecordDto.fromFirestore)
        .toList(growable: false);
  }

  /// 特定の日付の記録をリアルタイムで監視
  Stream<MomRecordDto?> watchRecordForDate({
    required DateTime date,
  }) {
    final docId = DateFormat('yyyy-MM-dd').format(date);
    return _collection.doc(docId).snapshots().map((snapshot) {
      if (!snapshot.exists) {
        return null;
      }
      return MomRecordDto.fromFirestore(snapshot);
    });
  }

  Future<void> upsertRecord(MomRecordDto dto) async {
    final docId = DateFormat('yyyy-MM-dd').format(dto.date);
    final data = dto.toFirestoreMap();
    await _collection.doc(docId).set(
          data,
          SetOptions(merge: true),
        );
  }
}
