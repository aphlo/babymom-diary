import 'package:flutter/material.dart';

import 'app_dark_colors.dart';

/// テーマに応じた色を取得するためのextension
extension SemanticColorsExtension on BuildContext {
  /// 現在のテーマがダークモードかどうか
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // 背景色
  Color get menuSectionBackground =>
      isDarkMode ? AppDarkColors.surfaceVariant : Colors.white;

  Color get menuSectionBorder =>
      isDarkMode ? AppDarkColors.outline : const Color(0xFFE0E0E0);

  // テーブル行背景
  Color get tableRowEven => isDarkMode ? AppDarkColors.surface : Colors.white;

  Color get tableRowOdd =>
      isDarkMode ? AppDarkColors.surfaceVariant : Colors.pink.shade50;

  // 曜日色
  Color get saturdayColor => isDarkMode ? AppDarkColors.saturday : Colors.blue;

  Color get sundayColor => isDarkMode ? AppDarkColors.sunday : Colors.red;

  // サブテキスト
  Color get subtextColor =>
      isDarkMode ? AppDarkColors.onSurfaceVariant : Colors.black54;

  // ページ背景
  Color get pageBackground =>
      isDarkMode ? AppDarkColors.surface : const Color(0xFFF5F5F5);

  // テーブルボーダー
  Color get tableBorderColor =>
      isDarkMode ? AppDarkColors.outline : Colors.grey.shade400;

  // テーブルヘッダー背景
  Color get tableHeaderBackground =>
      isDarkMode ? AppDarkColors.surfaceVariant : Colors.grey.shade100;

  // 合計行の背景
  Color get tableTotalsBackground =>
      isDarkMode ? AppDarkColors.surfaceVariant : Colors.grey.shade200;

  // 土曜日の行背景色
  Color get saturdayRowBackground => isDarkMode
      ? const Color(0xFF1A237E).withValues(alpha: 0.3)
      : const Color(0xFFE3F2FD);

  // 日曜日の行背景色
  Color get sundayRowBackground => isDarkMode
      ? const Color(0xFFB71C1C).withValues(alpha: 0.2)
      : const Color(0xFFFFEBEE);

  // バッジ中立色
  Color get badgeNeutralColor =>
      isDarkMode ? const Color(0xFFB0B0B0) : const Color(0xFF757575);

  // バッジ背景色（白/ダーク）
  Color get badgeBackground =>
      isDarkMode ? AppDarkColors.surfaceVariant : Colors.white;

  // ワクチンハイライト用の混合ベース色
  Color get highlightMixBase =>
      isDarkMode ? AppDarkColors.surface : Colors.white;
}
