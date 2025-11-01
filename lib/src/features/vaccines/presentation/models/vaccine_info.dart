import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;

class VaccineInfo {
  const VaccineInfo({
    required this.id,
    required this.name,
    required this.category,
    required this.requirement,
    this.doseSchedules = const <String, List<int>>{},
    this.periodHighlights = const <String, domain.VaccinationPeriodHighlight>{},
    this.highlightPalette = VaccineHighlightPalette.primary,
    this.notes = const <VaccineGuidelineNote>[],
  });

  final String id;
  final String name;
  final domain.VaccineCategory category;
  final domain.VaccineRequirement requirement;
  final Map<String, List<int>> doseSchedules;
  final Map<String, domain.VaccinationPeriodHighlight> periodHighlights;
  final VaccineHighlightPalette highlightPalette;
  final List<VaccineGuidelineNote> notes;
}

class VaccineGuidelineNote {
  const VaccineGuidelineNote({
    required this.message,
  });

  final String message;
}

enum VaccineHighlightPalette { primary, secondary }
