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

  // ===================
  // 日付セクション色（離乳食詳細など）
  // ===================

  /// 日付セクションヘッダー背景色
  Color get dateSectionHeaderBackground =>
      isDarkMode ? const Color(0xFF3D2A3A) : Colors.pink.shade50;

  /// 日付セクションボーダー色
  Color get dateSectionBorder =>
      isDarkMode ? const Color(0xFFE87086) : Colors.pink.shade200;

  /// 日付セクションテキスト色
  Color get dateSectionText =>
      isDarkMode ? const Color(0xFFFFB4C2) : Colors.pink.shade700;

  // ===================
  // 予防接種ガイドラインバッジ色
  // ===================

  /// ガイドラインバッジ背景色（一般的な接種時期の①②③）
  Color get guidelineBadgeBackground =>
      isDarkMode ? AppDarkColors.surfaceVariant : Colors.white;

  /// ガイドラインバッジボーダー色
  Color get guidelineBadgeBorder =>
      isDarkMode ? const Color(0xFF9E9E9E) : Colors.grey.shade600;

  /// ガイドラインバッジテキスト色
  Color get guidelineBadgeText =>
      isDarkMode ? const Color(0xFFBDBDBD) : Colors.grey.shade600;

  /// 矢印線の色
  Color get guidelineArrowColor =>
      isDarkMode ? const Color(0xFF9E9E9E) : Colors.grey.shade600;

  // ===================
  // 予防接種ステータスバッジ色
  // ===================

  /// 接種予定バッジ背景色
  Color get scheduledBadgeBackground =>
      isDarkMode ? AppDarkColors.reserved : AppColors.reserved;

  /// 接種予定バッジボーダー色
  Color get scheduledBadgeBorder =>
      isDarkMode ? AppDarkColors.reserved : AppColors.reserved;

  /// 接種予定バッジテキスト色
  Color get scheduledBadgeText =>
      isDarkMode ? AppDarkColors.reservedText : Colors.white;

  /// 接種済みバッジ背景色
  Color get completedBadgeBackground =>
      isDarkMode ? AppDarkColors.vaccinated : AppColors.vaccinated;

  /// 接種済みバッジボーダー色
  Color get completedBadgeBorder =>
      isDarkMode ? AppDarkColors.vaccinated : AppColors.vaccinated;

  /// 接種済みバッジテキスト色
  Color get completedBadgeText =>
      isDarkMode ? AppDarkColors.vaccinatedText : Colors.white;

  // ===================
  // 定期接種・任意接種バッジ色
  // ===================

  /// 定期接種バッジ背景色
  Color get mandatoryBadgeBackground =>
      isDarkMode ? const Color(0xFF8B3A4A) : AppColors.primary;

  /// 定期接種バッジテキスト色
  Color get mandatoryBadgeText => Colors.white;

  /// 任意接種バッジ背景色
  Color get optionalBadgeBackground =>
      isDarkMode ? const Color(0xFF1565C0) : AppColors.secondary;

  /// 任意接種バッジテキスト色
  Color get optionalBadgeText => Colors.white;

  // ===================
  // ワクチン種別バッジ色（生/不活化）
  // ===================

  /// 生ワクチンバッジ背景色
  Color get liveBadgeBackground => isDarkMode
      ? AppDarkColors.vaccineLive.withValues(alpha: 0.25)
      : AppColors.vaccineLive.withValues(alpha: 0.12);

  /// 生ワクチンバッジテキスト色
  Color get liveBadgeForeground =>
      isDarkMode ? AppDarkColors.vaccineLive : AppColors.vaccineLive;

  /// 生ワクチンバッジボーダー色
  Color get liveBadgeBorder => isDarkMode
      ? AppDarkColors.vaccineLive.withValues(alpha: 0.6)
      : AppColors.vaccineLive.withValues(alpha: 0.4);

  /// 不活化ワクチンバッジ背景色
  Color get inactivatedBadgeBackground => isDarkMode
      ? AppDarkColors.vaccineInactivated.withValues(alpha: 0.25)
      : AppColors.vaccineInactivated.withValues(alpha: 0.12);

  /// 不活化ワクチンバッジテキスト色
  Color get inactivatedBadgeForeground => isDarkMode
      ? AppDarkColors.vaccineInactivated
      : AppColors.vaccineInactivated;

  /// 不活化ワクチンバッジボーダー色
  Color get inactivatedBadgeBorder => isDarkMode
      ? AppDarkColors.vaccineInactivated.withValues(alpha: 0.6)
      : AppColors.vaccineInactivated.withValues(alpha: 0.4);
}
