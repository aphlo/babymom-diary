import 'package:babymom_diary/src/core/theme/app_colors.dart';
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

VaccineTypeStyles vaccineTypeStyles(VaccineCategory category) {
  switch (category) {
    case VaccineCategory.live:
      const Color baseColor = AppColors.vaccineLive;
      return VaccineTypeStyles(
        label: '生',
        backgroundColor: baseColor.withOpacity(0.12),
        foregroundColor: baseColor,
        borderColor: baseColor.withOpacity(0.4),
      );
    case VaccineCategory.inactivated:
      const Color baseColor = AppColors.vaccineInactivated;
      return VaccineTypeStyles(
        label: '不活化',
        backgroundColor: baseColor.withOpacity(0.12),
        foregroundColor: baseColor,
        borderColor: baseColor.withOpacity(0.4),
      );
  }
}
