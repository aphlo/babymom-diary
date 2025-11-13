import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';

ThemeData buildTheme({Color? childColor}) {
  const fontFamily = 'MPLUSRounded1c';

  // ColorSchemeは常にAppColors.primaryをベースにする
  final base = ThemeData(useMaterial3: true, fontFamily: fontFamily);
  final scheme = ColorScheme.fromSeed(seedColor: AppColors.primary).copyWith(
    primary: AppColors.primary,
  );

  // AppBar/NavigationBar用の色（子どもの色 or デフォルト）
  final appBarColor = childColor ?? AppColors.primary;

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
          return scheme.onSurface.withOpacity(0.38);
        }
        return scheme.onSurfaceVariant;
      }),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: appBarColor, // 子どもの色を使用
      foregroundColor: scheme.onPrimary, // text & icons
      surfaceTintColor: Colors.transparent,
      elevation: 8,
      scrolledUnderElevation: 12,
      shadowColor: Colors.black.withOpacity(0.35),
      shape: Border(
        bottom: BorderSide(color: Colors.black.withOpacity(0.12), width: 1),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: appBarColor, // 子どもの色を使用
      surfaceTintColor: Colors.transparent,
      indicatorColor: scheme.onPrimary.withOpacity(0.20),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: scheme.onPrimary
              .withOpacity(states.contains(WidgetState.selected) ? 1.0 : 0.85),
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          color: scheme.onPrimary
              .withOpacity(states.contains(WidgetState.selected) ? 1.0 : 0.85),
          fontWeight: states.contains(WidgetState.selected)
              ? FontWeight.w600
              : FontWeight.w500,
          fontSize: 11, // slightly smaller labels
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
