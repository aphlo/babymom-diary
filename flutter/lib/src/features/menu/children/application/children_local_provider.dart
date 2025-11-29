import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/child_summary.dart';

part 'children_local_provider.g.dart';

@Riverpod(keepAlive: true)
class ChildrenLocal extends _$ChildrenLocal {
  String? _householdId;

  static String prefsKey(String householdId) => 'cachedChildren/$householdId';

  @override
  Future<List<ChildSummary>> build(String householdId) async {
    _householdId = householdId;
    return _restore();
  }

  Future<List<ChildSummary>> _restore() async {
    final householdId = _householdId;
    if (householdId == null) return const <ChildSummary>[];

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(prefsKey(householdId));
    return raw == null ? const <ChildSummary>[] : decodeList(raw);
  }

  Future<void> replaceChildren(List<ChildSummary> children) async {
    final householdId = _householdId;
    if (householdId == null) return;

    final current = state.value;
    if (_listEquals(current, children)) {
      return;
    }
    state = AsyncValue.data(children);
    try {
      final prefs = await SharedPreferences.getInstance();
      final encoded = jsonEncode(children.map((e) => e.toJson()).toList());
      await prefs.setString(prefsKey(householdId), encoded);
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
