import 'package:flutter/material.dart';

ThemeData buildTheme() {
  final base = ThemeData(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6D8CFF)),
    inputDecorationTheme: const InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
  );
}