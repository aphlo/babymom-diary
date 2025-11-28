import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/firebase/household_service.dart';
import '../domain/entities/child_summary.dart';
import 'children_stream_provider.dart';
import 'selected_child_provider.dart';
import 'selected_child_snapshot_provider.dart';

/// 子供コンテキストを表すイミュータブルなクラス
/// householdId、選択中の子供、子供リストを統合的に管理
class ChildContext {
  const ChildContext({
    required this.householdId,
    required this.selectedChildId,
    required this.children,
    this.selectedChildSummary,
  });

  /// 世帯ID
  final String householdId;

  /// 選択中の子供ID（null = 子供未選択）
  final String? selectedChildId;

  /// 世帯内の子供リスト
  final List<ChildSummary> children;

  /// 選択中の子供のスナップショット（誕生日等の詳細情報）
  final ChildSummary? selectedChildSummary;

  /// 子供が存在するかどうか
  bool get hasChildren => children.isNotEmpty;

  /// 子供が選択されているかどうか
  bool get hasSelectedChild =>
      selectedChildId != null && selectedChildId!.isNotEmpty;

  ChildContext copyWith({
    String? householdId,
    String? selectedChildId,
    List<ChildSummary>? children,
    ChildSummary? selectedChildSummary,
  }) {
    return ChildContext(
      householdId: householdId ?? this.householdId,
      selectedChildId: selectedChildId ?? this.selectedChildId,
      children: children ?? this.children,
      selectedChildSummary: selectedChildSummary ?? this.selectedChildSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChildContext) return false;
    if (householdId != other.householdId) return false;
    if (selectedChildId != other.selectedChildId) return false;
    if (children.length != other.children.length) return false;
    for (var i = 0; i < children.length; i++) {
      if (children[i] != other.children[i]) return false;
    }
    if (selectedChildSummary != other.selectedChildSummary) return false;
    return true;
  }

  @override
  int get hashCode => Object.hash(
        householdId,
        selectedChildId,
        Object.hashAll(children),
        selectedChildSummary,
      );
}

/// 子供コンテキストを一元管理するAsyncNotifier
///
/// このプロバイダは以下を統合的に監視し、リアクティブに更新します:
/// - householdId の変更
/// - selectedChildId の変更
/// - childrenList の変更（子供削除の検知含む）
/// - selectedChild のスナップショット（誕生日など）の変更
///
/// 子供が削除された場合、自動的に次の子供を選択します。
class ChildContextNotifier extends AsyncNotifier<ChildContext> {
  @override
  Future<ChildContext> build() async {
    // householdIdの取得
    final householdId = await ref.watch(currentHouseholdIdProvider.future);

    // 子供リストの監視を開始
    _listenToChildrenList(householdId);

    // スナップショットの監視を開始
    _listenToChildSnapshot(householdId);

    // 選択中の子供を取得
    final selectedChildId =
        await ref.watch(selectedChildControllerProvider.future);

    // 子供リストを取得
    final children =
        await ref.watch(childrenStreamProvider(householdId).future);

    // スナップショットを取得
    final snapshotAsync = ref.read(selectedChildSnapshotProvider(householdId));
    final snapshot = snapshotAsync.valueOrNull;

    return ChildContext(
      householdId: householdId,
      selectedChildId: selectedChildId,
      children: children,
      selectedChildSummary: snapshot,
    );
  }

  /// 子供リストの変更を監視（削除検知用）
  void _listenToChildrenList(String householdId) {
    ref.listen<AsyncValue<List<ChildSummary>>>(
      childrenStreamProvider(householdId),
      (previous, next) {
        final children = next.valueOrNull ?? const <ChildSummary>[];
        final currentContext = state.valueOrNull;
        final selectedId = currentContext?.selectedChildId;

        // 選択中の子供がリストに存在しない場合（削除された場合）
        if (selectedId != null &&
            selectedId.isNotEmpty &&
            !children.any((c) => c.id == selectedId)) {
          // 次の子供を選択（いなければnull）
          final nextChild = children.isNotEmpty ? children.first : null;
          ref
              .read(selectedChildControllerProvider.notifier)
              .select(nextChild?.id);

          // スナップショットも更新
          ref
              .read(selectedChildSnapshotProvider(householdId).notifier)
              .save(nextChild);
        }

        _emitContext();
      },
      fireImmediately: true,
    );
  }

  /// 選択中の子供のスナップショット（誕生日など）の変更を監視
  void _listenToChildSnapshot(String householdId) {
    ref.listen<AsyncValue<ChildSummary?>>(
      selectedChildSnapshotProvider(householdId),
      (previous, next) {
        next.whenData((summary) {
          final currentContext = state.valueOrNull;
          // 選択中の子供の情報が変わった場合のみ更新
          if (summary?.id == currentContext?.selectedChildId) {
            _emitContext();
          }
        });
      },
      fireImmediately: true,
    );
  }

  /// 現在の状態からChildContextを生成して発行
  void _emitContext() {
    final householdIdAsync = ref.read(currentHouseholdIdProvider);
    final householdId = householdIdAsync.valueOrNull;

    if (householdId == null) {
      // householdIdがまだ読み込まれていない
      return;
    }

    final selectedChildIdAsync = ref.read(selectedChildControllerProvider);
    final selectedChildId = selectedChildIdAsync.valueOrNull;

    final childrenAsync = ref.read(childrenStreamProvider(householdId));
    final children = childrenAsync.valueOrNull ?? const <ChildSummary>[];

    final snapshotAsync = ref.read(selectedChildSnapshotProvider(householdId));
    final snapshot = snapshotAsync.valueOrNull;

    state = AsyncValue.data(ChildContext(
      householdId: householdId,
      selectedChildId: selectedChildId,
      children: children,
      selectedChildSummary: snapshot,
    ));
  }
}

/// 子供コンテキストを一元管理するプロバイダ
///
/// 使用例:
/// ```dart
/// final contextAsync = ref.watch(childContextProvider);
/// contextAsync.when(
///   data: (context) {
///     // context.householdId, context.selectedChildId, etc.
///   },
///   loading: () => CircularProgressIndicator(),
///   error: (e, s) => Text('Error: $e'),
/// );
/// ```
final childContextProvider =
    AsyncNotifierProvider<ChildContextNotifier, ChildContext>(
        ChildContextNotifier.new);
