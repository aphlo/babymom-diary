import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/repositories/record_tag_repository.dart';
import '../../infrastructure/repositories/record_tag_repository_impl.dart';

part 'record_tag_controller.g.dart';

/// RecordTagRepository の Provider
@riverpod
RecordTagRepository recordTagRepository(Ref ref) {
  return RecordTagRepositoryImpl(FirebaseFirestore.instance);
}

/// 世帯ごとのタグ一覧を管理する Controller
///
/// 使用例:
/// ```dart
/// final tagsAsync = ref.watch(recordTagControllerProvider(householdId));
/// final controller = ref.read(recordTagControllerProvider(householdId).notifier);
/// await controller.add('新しいタグ');
/// ```
@riverpod
class RecordTagController extends _$RecordTagController {
  @override
  Future<List<String>> build(String householdId) async {
    final repo = ref.read(recordTagRepositoryProvider);
    return repo.fetchTags(householdId);
  }

  /// タグを追加
  Future<void> add(String tag) async {
    final normalized = tag.trim();
    if (normalized.isEmpty) return;

    final current = [...(state.value ?? <String>[])];
    if (current.contains(normalized)) return;

    final repo = ref.read(recordTagRepositoryProvider);
    final householdId = this.householdId;

    await repo.addTag(householdId, normalized);
    current
      ..add(normalized)
      ..sort();
    state = AsyncData(List.unmodifiable(current));
  }

  /// タグを削除
  Future<void> remove(String tag) async {
    final current = [...(state.value ?? <String>[])];
    if (!current.contains(tag)) return;

    final repo = ref.read(recordTagRepositoryProvider);
    final householdId = this.householdId;

    await repo.removeTag(householdId, tag);
    current.remove(tag);
    state = AsyncData(List.unmodifiable(current));
  }

  /// タグ一覧を再読み込み
  Future<void> refresh() async {
    ref.invalidateSelf();
    await future;
  }
}
