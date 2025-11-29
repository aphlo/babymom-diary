import 'dart:convert';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/child_summary.dart';

part 'selected_child_snapshot_provider.g.dart';

@Riverpod(keepAlive: true)
class SelectedChildSnapshot extends _$SelectedChildSnapshot {
  String? _householdId;

  static String prefsKey(String householdId) =>
      'selectedChildSnapshot/$householdId';

  @override
  Future<ChildSummary?> build(String householdId) async {
    _householdId = householdId;
    return _restore();
  }

  Future<ChildSummary?> _restore() async {
    final householdId = _householdId;
    if (householdId == null) return null;

    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(prefsKey(householdId));
    if (raw == null) return null;
    return decodeSnapshot(raw);
  }

  Future<void> save(ChildSummary? summary) async {
    final householdId = _householdId;
    if (householdId == null) return;

    final current = state.value;
    if (current == summary) {
      return;
    }
    state = AsyncValue.data(summary);
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = prefsKey(householdId);
      if (summary == null) {
        await prefs.remove(key);
      } else {
        await prefs.setString(key, jsonEncode(summary.toJson()));
      }
    } catch (_) {
      // 永続化に失敗してもアプリの表示を止めない
    }
  }

  static ChildSummary? decodeSnapshot(String raw) {
    final json = jsonDecode(raw);
    if (json is Map) {
      return ChildSummary.fromJson(Map<String, dynamic>.from(json));
    }
    return null;
  }
}
