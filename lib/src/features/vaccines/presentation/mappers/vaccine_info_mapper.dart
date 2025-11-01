import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccination_period.dart';

import '../models/vaccine_info.dart';
import '../viewmodels/vaccines_view_data.dart';

VaccinesViewData mapGuidelineToViewData(VaccineMaster guideline) {
  final List<String> periodLabels = guideline.periods
      .map((VaccinationPeriod period) => period.label)
      .toList(growable: false);

  final List<VaccineInfo> vaccines = guideline.vaccines
      .map((domain.Vaccine vaccine) => _mapVaccine(vaccine))
      .toList(growable: false);

  return VaccinesViewData(
    periodLabels: periodLabels,
    vaccines: vaccines,
    version: guideline.version,
    publishedAt: guideline.publishedAt,
  );
}

VaccineInfo _mapVaccine(domain.Vaccine vaccine) {
  final Map<String, List<int>> doseSchedules = <String, List<int>>{};
  final Map<String, domain.VaccinationPeriodHighlight> periodHighlights =
      <String, domain.VaccinationPeriodHighlight>{};

  for (final domain.VaccineScheduleSlot slot in vaccine.schedule) {
    if (slot.doseNumbers.isNotEmpty) {
      doseSchedules[slot.periodId] = List<int>.from(slot.doseNumbers);
    }
    final domain.VaccinationPeriodHighlight? highlight = slot.highlight;
    if (highlight != null) {
      periodHighlights[slot.periodId] = highlight;
    }
  }

  final VaccineHighlightPalette palette =
      vaccine.priority == domain.VaccinePriority.highlight
          ? VaccineHighlightPalette.secondary
          : VaccineHighlightPalette.primary;

  final List<VaccineGuidelineNote> notes = vaccine.notes
      .map(
        (domain.VaccineNote note) => VaccineGuidelineNote(
          message: note.message,
          isAttention: note.severity == domain.VaccineNoteSeverity.attention,
        ),
      )
      .toList(growable: false);

  return VaccineInfo(
    id: vaccine.id,
    name: vaccine.name,
    category: vaccine.category,
    requirement: vaccine.requirement,
    doseSchedules: doseSchedules,
    periodHighlights: periodHighlights,
    highlightPalette: palette,
    notes: notes,
  );
}
