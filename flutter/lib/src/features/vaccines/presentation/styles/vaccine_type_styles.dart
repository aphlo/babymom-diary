import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_category.dart';
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

VaccineTypeStyles vaccineTypeStyles(
  VaccineCategory category, {
  required BuildContext context,
}) {
  switch (category) {
    case VaccineCategory.live:
      return VaccineTypeStyles(
        label: '生',
        backgroundColor: context.liveBadgeBackground,
        foregroundColor: context.liveBadgeForeground,
        borderColor: context.liveBadgeBorder,
      );
    case VaccineCategory.inactivated:
      return VaccineTypeStyles(
        label: '不活化',
        backgroundColor: context.inactivatedBadgeBackground,
        foregroundColor: context.inactivatedBadgeForeground,
        borderColor: context.inactivatedBadgeBorder,
      );
  }
}
