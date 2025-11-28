import 'package:cloud_firestore/cloud_firestore.dart';

import '../../data/infrastructure/child_firestore_data_source.dart';

/// 有効な子どもを保証する UseCase
///
/// 選択中の子どもが世帯内に存在するか確認し、
/// 存在しない場合は最初の子どもを選択する。
class EnsureActiveChild {
  EnsureActiveChild(this._db);

  final FirebaseFirestore _db;

  /// 有効な子ども ID を返す
  ///
  /// - [householdId]: 世帯 ID
  /// - [currentSelectedId]: 現在選択中の子ども ID
  /// - [onSelect]: 子どもを選択したときのコールバック
  ///
  /// 戻り値:
  /// - 有効な子ども ID（存在する場合）
  /// - null（子どもが存在しない場合）
  Future<String?> call({
    required String householdId,
    required String? currentSelectedId,
    required Future<void> Function(String? childId) onSelect,
  }) async {
    final ds = ChildFirestoreDataSource(_db, householdId);

    // 選択されている子どもが現在の世帯に存在するか確認
    if (currentSelectedId != null && currentSelectedId.isNotEmpty) {
      final childDoc = await ds
          .childrenQuery()
          .where(FieldPath.documentId, isEqualTo: currentSelectedId)
          .limit(1)
          .get();
      if (childDoc.docs.isNotEmpty) {
        return currentSelectedId;
      }
      // 子どもが現在の世帯に存在しない場合はリセット
    }

    // 世帯内の最初の子どもを選択
    final snap = await ds.childrenQuery().limit(1).get();
    if (snap.docs.isEmpty) {
      await onSelect(null);
      return null;
    }

    final firstId = snap.docs.first.id;
    await onSelect(firstId);
    return firstId;
  }
}
