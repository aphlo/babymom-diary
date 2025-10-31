class VaccineInfo {
  const VaccineInfo({
    required this.name,
    required this.category,
    required this.requirement,
    this.doseSchedules = const <String, List<int>>{},
    this.periodHighlights = const <String, VaccinePeriodHighlight>{},
    this.highlightPalette = VaccineHighlightPalette.primary,
  });

  final String name;
  final VaccineCategory category;
  final VaccineRequirement requirement;
  final Map<String, List<int>> doseSchedules;
  final Map<String, VaccinePeriodHighlight> periodHighlights;
  final VaccineHighlightPalette highlightPalette;
}

enum VaccineCategory { live, inactivated }

enum VaccineRequirement { mandatory, optional }

enum VaccinePeriodHighlight {
  recommended,
  available,
  academyRecommendation,
}

enum VaccineHighlightPalette { primary, secondary }
