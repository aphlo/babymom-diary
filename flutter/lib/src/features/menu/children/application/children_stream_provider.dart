import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/firebase/household_service.dart';
import '../../../../core/types/child_icon.dart';
import '../../../../core/types/gender.dart';
import '../data/infrastructure/child_firestore_data_source.dart';
import '../domain/entities/child_summary.dart';

part 'children_stream_provider.g.dart';

/// Household 内の子ども一覧を監視する StreamProvider。
@riverpod
Stream<List<ChildSummary>> childrenStream(Ref ref, String householdId) {
  final firestore = ref.watch(firebaseFirestoreProvider);
  final ds = ChildFirestoreDataSource(firestore, householdId);
  return ds.childrenQuery().snapshots().map((snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data();
      final birthday =
          (data['birthday'] as Timestamp?)?.toDate() ?? DateTime.now();
      final dueDate = (data['dueDate'] as Timestamp?)?.toDate();
      return ChildSummary(
        id: doc.id,
        name: (data['name'] as String?) ?? '未設定',
        birthday: birthday,
        dueDate: dueDate,
        gender: genderFromKey(data['gender'] as String?),
        icon: childIconFromKey(data['icon'] as String?),
      );
    }).toList();
  });
}
