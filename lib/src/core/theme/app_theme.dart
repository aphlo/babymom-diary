import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final base = ThemeData(useMaterial3: true);
  final scheme = ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 219, 13, 81));

  return base.copyWith(
    colorScheme: scheme,
    appBarTheme: AppBarTheme(
      backgroundColor: scheme.primary,
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
      backgroundColor: scheme.primary,
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
