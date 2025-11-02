import 'package:flutter/material.dart';

/// App-wide color constants
class AppColors {
  const AppColors._();

  // Primary colors
  static const Color primary = Color(0xFFE87086);

  // Secondary colors
  static const Color secondary = Color(0xFF2196F3);

  // Surfaces / backgrounds
  static const Color pageBackground = Color(0xFFF5F5F5);

  // Vaccine badge colors
  static const Color vaccineInactivated = Color.fromARGB(255, 0, 211, 4);
  static const Color vaccineLive = Color.fromARGB(255, 255, 111, 0);
  static const Color reserved = Color.fromARGB(255, 230, 211, 0);
  static const Color vaccinated = Color.fromARGB(255, 1, 162, 6);
}
