import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_category.dart'
    as vo;
import 'package:flutter/material.dart';

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

VaccineTypeStyles vaccineTypeStyles(domain.VaccineCategory category) {
  switch (category) {
    case domain.VaccineCategory.live:
      const Color baseColor = AppColors.vaccineLive;
      return VaccineTypeStyles(
        label: '生',
        backgroundColor: baseColor.withOpacity(0.12),
        foregroundColor: baseColor,
        borderColor: baseColor.withOpacity(0.4),
      );
    case domain.VaccineCategory.inactivated:
      const Color baseColor = AppColors.vaccineInactivated;
      return VaccineTypeStyles(
        label: '不活化',
        backgroundColor: baseColor.withOpacity(0.12),
        foregroundColor: baseColor,
        borderColor: baseColor.withOpacity(0.4),
      );
  }
}

VaccineTypeStyles vaccineTypeStylesFromValueObject(
    vo.VaccineCategory category) {
  switch (category) {
    case vo.VaccineCategory.live:
      return vaccineTypeStyles(domain.VaccineCategory.live);
    case vo.VaccineCategory.inactivated:
      return vaccineTypeStyles(domain.VaccineCategory.inactivated);
  }
}
