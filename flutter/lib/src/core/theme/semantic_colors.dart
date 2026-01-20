import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_dark_colors.dart';

/// テーマに応じた色を取得するためのextension
extension SemanticColorsExtension on BuildContext {
  /// 現在のテーマがダークモードかどうか
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  // ===================
  // プライマリカラー
  // ===================

  /// アプリのプライマリカラー（ボタン、リンク、強調色など）
  Color get primaryColor =>
      isDarkMode ? AppDarkColors.primary : AppColors.primary;

  /// プライマリカラー上のテキスト/アイコン色
  Color get onPrimaryColor =>
      isDarkMode ? AppDarkColors.onPrimary : Colors.white;

  /// セカンダリカラー（体重グラフなど）
  Color get secondaryColor => AppColors.secondary;

  /// アクセントピンク（タブのアクティブ色など、primaryより明るめ）
  Color get accentPink => isDarkMode ? const Color(0xFFFF8A9E) : Colors.pink;

  /// 非アクティブなタブやテキストの色
  Color get inactiveTabColor => isDarkMode ? Colors.grey.shade400 : Colors.grey;

  // ===================
  // 背景色
  // ===================

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

  // 空状態やサブセクションの背景色
  Color get subtleSurfaceBackground =>
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

  // 白背景ページ（オンボーディング、強制アップデートなど）
  Color get surfaceBackground =>
      isDarkMode ? AppDarkColors.surface : Colors.white;

  // メインテキスト色
  Color get textPrimary =>
      isDarkMode ? AppDarkColors.onSurface : const Color(0xFF333333);

  // サブテキスト色（subtextColorより少し濃い）
  Color get textSecondary =>
      isDarkMode ? AppDarkColors.onSurfaceVariant : Colors.grey.shade600;

  // ===================
  // 離乳食バッジ色
  // ===================

  /// 「食べた」バッジ背景色
  Color get eatenBadgeBackground =>
      isDarkMode ? const Color(0xFF1B5E20) : Colors.green.shade50;

  /// 「食べた」バッジボーダー色
  Color get eatenBadgeBorder =>
      isDarkMode ? const Color(0xFF4CAF50) : Colors.green.shade200;

  /// 「食べた」バッジテキスト色
  Color get eatenBadgeText =>
      isDarkMode ? const Color(0xFF81C784) : Colors.green.shade700;

  /// 「まだ」バッジ背景色
  Color get notEatenBadgeBackground =>
      isDarkMode ? const Color(0xFF424242) : Colors.grey.shade100;

  /// 「まだ」バッジボーダー色
  Color get notEatenBadgeBorder =>
      isDarkMode ? const Color(0xFF757575) : Colors.grey.shade300;

  /// 「まだ」バッジテキスト色
  Color get notEatenBadgeText =>
      isDarkMode ? const Color(0xFFBDBDBD) : Colors.grey.shade500;

  /// アレルギーバッジ背景色
  Color get allergyBadgeBackground =>
      isDarkMode ? const Color(0xFF7F1D1D) : Colors.red.shade50;

  /// アレルギーバッジボーダー色
  Color get allergyBadgeBorder =>
      isDarkMode ? const Color(0xFFEF5350) : Colors.red.shade200;

  /// アレルギーバッジテキスト色
  Color get allergyBadgeText =>
      isDarkMode ? const Color(0xFFEF9A9A) : Colors.red.shade700;
}
