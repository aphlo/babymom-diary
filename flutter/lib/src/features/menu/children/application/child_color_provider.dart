import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/preferences/shared_preferences_provider.dart';
import '../infrastructure/child_color_local_storage.dart';

final childColorLocalStorageProvider = Provider<ChildColorLocalStorage>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ChildColorLocalStorage(prefs);
});

/// 子供の色を管理するStateNotifier
class ChildColorNotifier extends StateNotifier<Map<String, Color>> {
  ChildColorNotifier(this._storage) : super({});

  final ChildColorLocalStorage _storage;

  /// 子供の色を取得（読み取り専用）
  Color getColor(String childId, {Color defaultColor = Colors.blueAccent}) {
    // メモリキャッシュから取得
    if (state.containsKey(childId)) {
      return state[childId]!;
    }
    // ストレージから取得（状態は更新しない）
    final savedColor = _storage.getColor(childId);
    return savedColor ?? defaultColor;
  }

  /// 子供の色を設定
  Future<void> setColor(String childId, Color color) async {
    await _storage.saveColor(childId, color);
    state = {...state, childId: color};
  }

  /// 子供の色を削除
  Future<void> removeColor(String childId) async {
    await _storage.removeColor(childId);
    state = {...state}..remove(childId);
  }

  /// 子供の色をメモリキャッシュにプリロード
  void preloadColor(String childId) {
    if (!state.containsKey(childId)) {
      final savedColor = _storage.getColor(childId);
      if (savedColor != null) {
        state = {...state, childId: savedColor};
      }
    }
  }
}

final childColorProvider =
    StateNotifierProvider<ChildColorNotifier, Map<String, Color>>((ref) {
  final storage = ref.watch(childColorLocalStorageProvider);
  return ChildColorNotifier(storage);
});
