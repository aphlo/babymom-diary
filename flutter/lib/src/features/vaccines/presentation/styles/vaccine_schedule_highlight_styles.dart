import 'package:flutter/material.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccination_period_highlight.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/semantic_colors.dart';
import '../models/vaccine_info.dart';

class VaccinePeriodHighlightStyle {
  const VaccinePeriodHighlightStyle({
    required this.cellColor,
    required this.badgeFillColor,
    required this.badgeTextColor,
    required this.badgeBorderColor,
  });

  final Color cellColor;
  final Color badgeFillColor;
  final Color badgeTextColor;
  final Color badgeBorderColor;
}

VaccinePeriodHighlightStyle vaccinePeriodHighlightStyle({
  required VaccinationPeriodHighlight highlight,
  required VaccineHighlightPalette palette,
  required BuildContext context,
}) {
  switch (highlight) {
    case VaccinationPeriodHighlight.recommended:
      return _recommendedStyle(palette, context);
    case VaccinationPeriodHighlight.available:
      return _availableStyle(palette, context);
    case VaccinationPeriodHighlight.academyRecommendation:
      return _academyRecommendationStyle(context);
  }
}

VaccinePeriodHighlightStyle _recommendedStyle(
  VaccineHighlightPalette palette,
  BuildContext context,
) {
  final Color base = _paletteBaseColor(palette);
  final badgeColors = _BadgeColors(
    fill: context.badgeBackground,
    text: context.badgeNeutralColor,
    border: context.badgeNeutralColor,
  );
  return VaccinePeriodHighlightStyle(
    cellColor: _mix(base, context.highlightMixBase, 0.35),
    badgeFillColor: badgeColors.fill,
    badgeTextColor: badgeColors.text,
    badgeBorderColor: badgeColors.border,
  );
}

VaccinePeriodHighlightStyle _availableStyle(
  VaccineHighlightPalette palette,
  BuildContext context,
) {
  final Color base = _paletteBaseColor(palette);
  final badgeColors = _BadgeColors(
    fill: context.badgeBackground,
    text: context.badgeNeutralColor,
    border: context.badgeNeutralColor,
  );
  return VaccinePeriodHighlightStyle(
    cellColor: _mix(base, context.highlightMixBase, 0.82),
    badgeFillColor: badgeColors.fill,
    badgeTextColor: badgeColors.text,
    badgeBorderColor: badgeColors.border,
  );
}

VaccinePeriodHighlightStyle _academyRecommendationStyle(BuildContext context) {
  const double blendRatio = 0.5;
  final Color base = _mix(AppColors.primary, AppColors.secondary, blendRatio);
  return VaccinePeriodHighlightStyle(
    cellColor: _mix(base, context.highlightMixBase, 0.4),
    badgeFillColor: context.badgeBackground,
    badgeTextColor: context.badgeNeutralColor,
    badgeBorderColor: context.badgeNeutralColor,
  );
}

Color _paletteBaseColor(VaccineHighlightPalette palette) {
  switch (palette) {
    case VaccineHighlightPalette.primary:
      return AppColors.primary;
    case VaccineHighlightPalette.secondary:
      return AppColors.secondary;
  }
}

Color _mix(Color a, Color b, double t) {
  return Color.lerp(a, b, t) ?? a;
}

class _BadgeColors {
  const _BadgeColors({
    required this.fill,
    required this.text,
    required this.border,
  });

  final Color fill;
  final Color text;
  final Color border;
}
