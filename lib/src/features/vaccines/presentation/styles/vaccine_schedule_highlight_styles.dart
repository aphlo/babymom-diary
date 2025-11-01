import 'package:flutter/material.dart';

import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;

import '../../../../core/theme/app_colors.dart';
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
  required domain.VaccinationPeriodHighlight highlight,
  required VaccineHighlightPalette palette,
}) {
  switch (highlight) {
    case domain.VaccinationPeriodHighlight.recommended:
      return _recommendedStyle(palette);
    case domain.VaccinationPeriodHighlight.available:
      return _availableStyle(palette);
    case domain.VaccinationPeriodHighlight.academyRecommendation:
      return _academyRecommendationStyle();
  }
}

VaccinePeriodHighlightStyle _recommendedStyle(
  VaccineHighlightPalette palette,
) {
  final Color base = _paletteBaseColor(palette);
  const _BadgeColors badgeColors = _BadgeColors(
    fill: Colors.white,
    text: _badgeNeutralColor,
    border: _badgeNeutralColor,
  );
  return VaccinePeriodHighlightStyle(
    cellColor: _mix(base, Colors.white, 0.35),
    badgeFillColor: badgeColors.fill,
    badgeTextColor: badgeColors.text,
    badgeBorderColor: badgeColors.border,
  );
}

VaccinePeriodHighlightStyle _availableStyle(
  VaccineHighlightPalette palette,
) {
  final Color base = _paletteBaseColor(palette);
  const _BadgeColors badgeColors = _BadgeColors(
    fill: Colors.white,
    text: _badgeNeutralColor,
    border: _badgeNeutralColor,
  );
  return VaccinePeriodHighlightStyle(
    cellColor: _mix(base, Colors.white, 0.82),
    badgeFillColor: badgeColors.fill,
    badgeTextColor: badgeColors.text,
    badgeBorderColor: badgeColors.border,
  );
}

VaccinePeriodHighlightStyle _academyRecommendationStyle() {
  const double blendRatio = 0.5;
  final Color base = _mix(AppColors.primary, AppColors.secondary, blendRatio);
  return VaccinePeriodHighlightStyle(
    cellColor: _mix(base, Colors.white, 0.4),
    badgeFillColor: Colors.white,
    badgeTextColor: _badgeNeutralColor,
    badgeBorderColor: _badgeNeutralColor,
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

const Color _badgeNeutralColor = Color(0xFF757575);

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
