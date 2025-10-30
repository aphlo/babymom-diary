import 'package:flutter/material.dart';

import '../models/vaccine_info.dart';

class VaccineTypeStyles {
  const VaccineTypeStyles({
    required this.label,
    required this.backgroundColor,
    required this.foregroundColor,
    required this.borderColor,
  });

  final String label;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
}

VaccineTypeStyles vaccineTypeStyles(
  VaccineCategory category,
  ColorScheme colorScheme,
) {
  switch (category) {
    case VaccineCategory.live:
      return VaccineTypeStyles(
        label: '生',
        backgroundColor: colorScheme.error.withOpacity(0.12),
        foregroundColor: colorScheme.error,
        borderColor: colorScheme.error.withOpacity(0.4),
      );
    case VaccineCategory.inactivated:
      return VaccineTypeStyles(
        label: '不活化',
        backgroundColor: colorScheme.primary.withOpacity(0.12),
        foregroundColor: colorScheme.primary,
        borderColor: colorScheme.primary.withOpacity(0.4),
      );
  }
}
