import 'package:meta/meta.dart';

import '../value_objects/vaccination_period.dart';

enum VaccineCategory { live, inactivated }

enum VaccineRequirement { mandatory, optional }

enum VaccinationPeriodHighlight {
  recommended,
  available,
  academyRecommendation,
}

@immutable
class Vaccine {
  const Vaccine({
    required this.id,
    required this.name,
    required this.category,
    required this.requirement,
    required this.schedule,
    this.notes = const <VaccineNote>[],
    this.priority = VaccinePriority.standard,
  });

  final String id;
  final String name;
  final VaccineCategory category;
  final VaccineRequirement requirement;
  final List<VaccineScheduleSlot> schedule;
  final List<VaccineNote> notes;
  final VaccinePriority priority;
}

enum VaccinePriority { standard, highlight }

@immutable
class VaccineScheduleSlot {
  const VaccineScheduleSlot({
    required this.periodId,
    this.doseNumbers = const <int>[],
    this.highlight,
  });

  final String periodId;
  final List<int> doseNumbers;
  final VaccinationPeriodHighlight? highlight;

  bool get hasDose => doseNumbers.isNotEmpty;

  VaccinationPeriod resolvePeriod(Iterable<VaccinationPeriod> periods) {
    return periods.firstWhere(
      (period) => period.id == periodId,
      orElse: () => VaccinationPeriod(
        id: periodId,
        label: periodId,
        order: 0,
      ),
    );
  }
}

@immutable
class VaccineNote {
  const VaccineNote({
    required this.message,
    this.severity = VaccineNoteSeverity.standard,
  });

  final String message;
  final VaccineNoteSeverity severity;
}

enum VaccineNoteSeverity { standard, attention }
