import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/core/theme/app_dark_colors.dart';

ThemeData buildTheme({
  Color? childColor,
  Brightness brightness = Brightness.light,
}) {
  const fontFamily = 'MPLUSRounded1c';
  final isDark = brightness == Brightness.dark;

  // ColorSchemeをライト/ダークモードに応じて生成
  final base = ThemeData(
    useMaterial3: true,
    fontFamily: fontFamily,
    brightness: brightness,
  );

  final scheme = isDark
      ? ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.dark,
        ).copyWith(
          primary: AppDarkColors.primary,
          onPrimary: AppDarkColors.onPrimary,
          surface: AppDarkColors.surface,
          onSurface: AppDarkColors.onSurface,
          surfaceContainerHighest: AppDarkColors.surfaceVariant,
          outline: AppDarkColors.outline,
        )
      : ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
          primary: AppColors.primary,
        );

  // AppBar/NavigationBar用の色（子どもの色 or デフォルト）
  final childColorOrDefault = childColor ?? AppColors.primary;

  // ダークモード: 背景黒、文字が子どもの色
  // ライトモード: 背景が子どもの色、文字白
  final appBarBackgroundColor =
      isDark ? AppDarkColors.surface : childColorOrDefault;
  final appBarForegroundColor = isDark ? childColorOrDefault : Colors.white;

  final textTheme = base.textTheme.apply(fontFamily: fontFamily);
  final primaryTextTheme = base.primaryTextTheme.apply(fontFamily: fontFamily);

  return base.copyWith(
    colorScheme: scheme,
    textTheme: textTheme,
    primaryTextTheme: primaryTextTheme,
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return AppColors.primary;
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withValues(alpha: 0.38);
        }
        return scheme.onSurfaceVariant;
      }),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: appBarBackgroundColor,
      foregroundColor: appBarForegroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: isDark ? 0 : 8,
      scrolledUnderElevation: isDark ? 0 : 12,
      shadowColor:
          isDark ? Colors.transparent : Colors.black.withValues(alpha: 0.35),
      shape: Border(
        bottom: BorderSide(
          color: isDark
              ? AppDarkColors.outline
              : Colors.black.withValues(alpha: 0.12),
          width: 1,
        ),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: appBarBackgroundColor,
      surfaceTintColor: Colors.transparent,
      indicatorColor: appBarForegroundColor.withValues(alpha: 0.20),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: appBarForegroundColor.withValues(
              alpha: states.contains(WidgetState.selected) ? 1.0 : 0.65),
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          color: appBarForegroundColor.withValues(
              alpha: states.contains(WidgetState.selected) ? 1.0 : 0.65),
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w600
              : FontWeight.w500,
          fontSize: 11,
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    scaffoldBackgroundColor: isDark ? AppDarkColors.surface : null,
    datePickerTheme: DatePickerThemeData(
      backgroundColor: isDark ? AppDarkColors.surfaceVariant : Colors.white,
      surfaceTintColor: Colors.transparent,
      headerBackgroundColor: AppColors.primary,
      headerForegroundColor: Colors.white,
    ),
    dialogTheme: DialogThemeData(
      backgroundColor: isDark ? AppDarkColors.surfaceVariant : Colors.white,
      surfaceTintColor: Colors.transparent,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: isDark ? AppDarkColors.surfaceVariant : Colors.white,
    ),
  );
}
