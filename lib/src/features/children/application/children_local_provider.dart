import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/child_summary.dart';

class ChildrenLocalNotifier
    extends StateNotifier<AsyncValue<List<ChildSummary>>> {
  ChildrenLocalNotifier(this._householdId) : super(const AsyncValue.loading()) {
    _restore();
  }

  ChildrenLocalNotifier.withInitial(
    this._householdId,
    List<ChildSummary> initial,
  ) : super(AsyncValue.data(initial));

  final String _householdId;

  static String prefsKey(String householdId) => 'cachedChildren/$householdId';

  Future<void> _restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(prefsKey(_householdId));
      final stored = raw == null ? const <ChildSummary>[] : decodeList(raw);
      if (!mounted) return;
      state = AsyncValue.data(stored);
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> replaceChildren(List<ChildSummary> children) async {
    final current = state.value;
    if (_listEquals(current, children)) {
      return;
    }
    state = AsyncValue.data(children);
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(children.map((e) => e.toJson()).toList());
      await prefs.setString(prefsKey(_householdId), encoded);
    } catch (_) {
      // 永続化に失敗しても UI 表示は維持したいので握りつぶす。
    }
  }

  Future<void> upsertChild(ChildSummary child) async {
    final current = List<ChildSummary>.from(state.value ?? <ChildSummary>[]);
    final index = current.indexWhere((c) => c.id == child.id);
    if (index >= 0) {
      current[index] = child;
    } else {
      current.add(child);
    }
    await replaceChildren(current);
  }

  static List<ChildSummary> decodeList(String raw) {
    final decoded = jsonDecode(raw);
    if (decoded is! List) return const <ChildSummary>[];
    return decoded
        .map((e) => e is Map
            ? ChildSummary.fromJson(Map<String, dynamic>.from(e))
            : null)
        .whereType<ChildSummary>()
        .toList();
  }

  bool _listEquals(
    List<ChildSummary>? a,
    List<ChildSummary> b,
  ) {
    if (a == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (!a[i].isSameAs(b[i])) return false;
    }
    return true;
  }
}

final childrenLocalProvider = StateNotifierProvider.family<
    ChildrenLocalNotifier, AsyncValue<List<ChildSummary>>, String>(
  (ref, householdId) => ChildrenLocalNotifier(householdId),
);
