import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/firebase/household_service.dart' as fbcore;
import '../../domain/repositories/record_tag_repository.dart';
import '../../infrastructure/repositories/record_tag_repository_impl.dart';

/// RecordTagRepository の Provider
final recordTagRepositoryProvider = Provider<RecordTagRepository>((ref) {
  final db = ref.watch(fbcore.firebaseFirestoreProvider);
  return RecordTagRepositoryImpl(db);
});

/// 世帯ごとのタグ一覧を管理する Controller
///
/// 使用例:
/// ```dart
/// final tagsAsync = ref.watch(recordTagControllerProvider(householdId));
/// final controller = ref.read(recordTagControllerProvider(householdId).notifier);
/// await controller.add('新しいタグ');
/// ```
final recordTagControllerProvider = StateNotifierProvider.family<
    RecordTagController, AsyncValue<List<String>>, String>(
  (ref, householdId) => RecordTagController(ref, householdId),
);

class RecordTagController extends StateNotifier<AsyncValue<List<String>>> {
  RecordTagController(this._ref, this._householdId)
      : super(const AsyncValue.loading()) {
    _load();
  }

  final Ref _ref;
  final String _householdId;

  Future<void> _load() async {
    final repo = _ref.read(recordTagRepositoryProvider);
    try {
      final tags = await repo.fetchTags(_householdId);
      if (!mounted) return;
      state = AsyncValue.data(tags);
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncValue.error(e, st);
    }
  }

  /// タグを追加
  Future<void> add(String tag) async {
    final normalized = tag.trim();
    if (normalized.isEmpty) return;

    final current = [...(state.value ?? <String>[])];
    if (current.contains(normalized)) return;

    final repo = _ref.read(recordTagRepositoryProvider);
    try {
      await repo.addTag(_householdId, normalized);
      if (!mounted) return;
      current
        ..add(normalized)
        ..sort();
      state = AsyncValue.data(List.unmodifiable(current));
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncValue.error(e, st);
    }
  }

  /// タグを削除
  Future<void> remove(String tag) async {
    final current = [...(state.value ?? <String>[])];
    if (!current.contains(tag)) return;

    final repo = _ref.read(recordTagRepositoryProvider);
    try {
      await repo.removeTag(_householdId, tag);
      if (!mounted) return;
      current.remove(tag);
      state = AsyncValue.data(List.unmodifiable(current));
    } catch (e, st) {
      if (!mounted) return;
      state = AsyncValue.error(e, st);
    }
  }

  /// タグ一覧を再読み込み
  Future<void> refresh() async {
    if (!mounted) return;
    state = const AsyncValue<List<String>>.loading();
    await _load();
  }
}
