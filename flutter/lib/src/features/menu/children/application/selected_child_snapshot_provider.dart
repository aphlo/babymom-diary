import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/child_summary.dart';

class SelectedChildSnapshotNotifier
    extends StateNotifier<AsyncValue<ChildSummary?>> {
  SelectedChildSnapshotNotifier(this._householdId)
      : super(const AsyncValue.loading()) {
    _restore();
  }

  SelectedChildSnapshotNotifier.withInitial(
    this._householdId,
    ChildSummary? initial,
  ) : super(AsyncValue.data(initial));

  final String _householdId;

  static String prefsKey(String householdId) =>
      'selectedChildSnapshot/$householdId';

  Future<void> _restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(prefsKey(_householdId));
      if (!mounted) return;
      if (raw == null) {
        state = const AsyncValue.data(null);
        return;
      }
      state = AsyncValue.data(decodeSelectedChildSnapshot(raw));
    } catch (e, stack) {
      if (!mounted) return;
      state = AsyncValue.error(e, stack);
    }
  }

  Future<void> save(ChildSummary? summary) async {
    final current = state.value;
    if (current == summary) {
      return;
    }
    state = AsyncValue.data(summary);
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = prefsKey(_householdId);
      if (summary == null) {
        await prefs.remove(key);
      } else {
        await prefs.setString(key, jsonEncode(summary.toJson()));
      }
    } catch (_) {
      // 永続化に失敗してもアプリの表示を止めない
    }
  }
}

ChildSummary? decodeSelectedChildSnapshot(String raw) {
  final json = jsonDecode(raw);
  if (json is Map) {
    return ChildSummary.fromJson(Map<String, dynamic>.from(json));
  }
  return null;
}

final selectedChildSnapshotProvider = StateNotifierProvider.family<
    SelectedChildSnapshotNotifier, AsyncValue<ChildSummary?>, String>(
  (ref, householdId) => SelectedChildSnapshotNotifier(householdId),
);
