import 'package:flutter/material.dart';

/// ダークモード用の色定数
class AppDarkColors {
  const AppDarkColors._();

  // Primary (明るめに調整してダーク背景で映えるように)
  static const Color primary = Color(0xFFFFB4C2);
  static const Color onPrimary = Color(0xFF5D1126);

  // Surface / Background
  static const Color surface = Color(0xFF1C1B1F);
  static const Color surfaceVariant = Color(0xFF2B2930);
  static const Color onSurface = Color(0xFFE6E1E5);
  static const Color onSurfaceVariant = Color(0xFFCAC4D0);

  // Outline
  static const Color outline = Color(0xFF49454F);
  static const Color outlineVariant = Color(0xFF79747E);

  // Vaccine badge colors (ダーク用に調整)
  static const Color vaccineInactivated = Color(0xFF4AE54E);
  static const Color vaccineLive = Color(0xFFFFAB40);
  static const Color reserved = Color(0xFFFFEE58);
  static const Color vaccinated = Color(0xFF69F0AE);

  // Weekday colors (ダーク用に調整)
  static const Color sunday = Color(0xFFFF8A80);
  static const Color saturday = Color(0xFF82B1FF);
}
