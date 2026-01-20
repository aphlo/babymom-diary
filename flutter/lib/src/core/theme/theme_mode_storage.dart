import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// テーマモード設定の永続化を担当するStorage
class ThemeModeStorage {
  ThemeModeStorage(this._prefs);

  final SharedPreferences _prefs;
  static const _key = 'theme_mode';

  /// 保存されたテーマモードを取得
  /// 未設定の場合はシステム設定に追従
  ThemeMode getThemeMode() {
    final value = _prefs.getString(_key);
    return switch (value) {
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system,
    };
  }

  /// テーマモードを保存
  Future<void> setThemeMode(ThemeMode mode) async {
    final value = switch (mode) {
      ThemeMode.light => 'light',
      ThemeMode.dark => 'dark',
      ThemeMode.system => 'system',
    };
    await _prefs.setString(_key, value);
  }
}
