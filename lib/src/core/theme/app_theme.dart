import 'package:flutter/material.dart';

ThemeData buildTheme() {
  const fontFamily = 'MPLUSRounded1c';
  const primaryColor = Color(0xFFE54F80);
  final base = ThemeData(useMaterial3: true, fontFamily: fontFamily);
  final scheme = ColorScheme.fromSeed(seedColor: primaryColor).copyWith(
    primary: primaryColor,
  );
  final textTheme = base.textTheme.apply(fontFamily: fontFamily);
  final primaryTextTheme =
      base.primaryTextTheme.apply(fontFamily: fontFamily);

  return base.copyWith(
    colorScheme: scheme,
    textTheme: textTheme,
    primaryTextTheme: primaryTextTheme,
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) return scheme.primary;
        if (states.contains(WidgetState.disabled)) {
          return scheme.onSurface.withOpacity(0.38);
        }
        return scheme.onSurfaceVariant;
      }),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: primaryColor,
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
      backgroundColor: primaryColor,
      surfaceTintColor: Colors.transparent,
      indicatorColor: scheme.onPrimary.withOpacity(0.20),
      iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
          color: scheme.onPrimary.withOpacity(states.contains(WidgetState.selected) ? 1.0 : 0.85),
        ),
      ),
      labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
          color: scheme.onPrimary.withOpacity(states.contains(WidgetState.selected) ? 1.0 : 0.85),
          fontWeight: states.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w500,
          fontSize: 11, // slightly smaller labels
        ),
      ),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}
