import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// 子供の色設定をローカルに保存・読み込みするクラス
class ChildColorLocalStorage {
  ChildColorLocalStorage(this._prefs);

  final SharedPreferences _prefs;

  static const _keyPrefix = 'child_color_';

  /// 子供の色を保存
  Future<void> saveColor(String childId, Color color) async {
    final colorHex = _toHex(color);
    await _prefs.setString('$_keyPrefix$childId', colorHex);
  }

  /// 子供の色を取得
  Color? getColor(String childId) {
    final colorHex = _prefs.getString('$_keyPrefix$childId');
    if (colorHex == null) return null;
    return _parseColor(colorHex);
  }

  /// 子供の色を削除
  Future<void> removeColor(String childId) async {
    await _prefs.remove('$_keyPrefix$childId');
  }

  String _toHex(Color c) =>
      '#${c.toARGB32().toRadixString(16).padLeft(8, '0').substring(2)}';

  Color _parseColor(String hex) {
    final cleaned = hex.replaceFirst('#', '');
    final value = int.tryParse(cleaned, radix: 16);
    if (value == null) return Colors.blueAccent;
    return Color(0xFF000000 | value);
  }
}
