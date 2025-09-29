import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/entities/child_summary.dart';

class SelectedChildSnapshotNotifier
    extends StateNotifier<AsyncValue<ChildSummary?>> {
  SelectedChildSnapshotNotifier(this._householdId)
      : super(const AsyncValue.loading()) {
    _restore();
  }

  final String _householdId;

  static String _prefsKey(String householdId) =>
      'selectedChildSnapshot/$householdId';

  Future<void> _restore() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_prefsKey(_householdId));
      if (!mounted) return;
      if (raw == null) {
        state = const AsyncValue.data(null);
        return;
      }
      final json = jsonDecode(raw);
      if (json is Map<String, dynamic>) {
        state = AsyncValue.data(ChildSummary.fromJson(json));
      } else {
        state = const AsyncValue.data(null);
      }
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
      final key = _prefsKey(_householdId);
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

final selectedChildSnapshotProvider = StateNotifierProvider.family<
    SelectedChildSnapshotNotifier, AsyncValue<ChildSummary?>, String>(
  (ref, householdId) => SelectedChildSnapshotNotifier(householdId),
);
