import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/household_service.dart';
import '../../../../core/types/gender.dart';
import '../data/infrastructure/child_firestore_data_source.dart';
import '../domain/entities/child_summary.dart';

/// Household 内の子ども一覧を監視する StreamProvider。
final childrenStreamProvider = StreamProvider.autoDispose
    .family<List<ChildSummary>, String>((ref, householdId) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final ds = ChildFirestoreDataSource(firestore, householdId);
  return ds.childrenQuery().snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      final birthday = (data['birthday'] as Timestamp?)?.toDate() ?? DateTime.now();
      final dueDate = (data['dueDate'] as Timestamp?)?.toDate() ?? DateTime.now();
      return ChildSummary(
        id: doc.id,
        name: (data['name'] as String?) ?? '未設定',
        birthday: birthday,
        dueDate: dueDate,
        gender: genderFromKey(data['gender'] as String?),
        color: data['color'] as String?,
      );
    }).toList();
  });
});
