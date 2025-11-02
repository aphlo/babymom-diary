import '../entities/dose_record.dart';
import '../entities/vaccination_record.dart';
import '../entities/vaccine.dart';
import '../services/vaccination_period_calculator.dart';
import '../value_objects/vaccination_recommendation.dart';

class VaccinationSchedulePolicy {
  const VaccinationSchedulePolicy();

  VaccinationRecommendation? recommend({
    required Vaccine vaccine,
    required int doseNumber,
    required VaccinationRecord? record,
    required DateTime? childBirthday,
  }) {
    final Map<int, List<String>> periodsByDose = _collectPeriodsByDose(vaccine);
    final List<VaccineNote> notes = vaccine.notes;

    final _DoseIntervalRecommendation? intervalRecommendation =
        _resolveIntervalRecommendation(
      doseNumber: doseNumber,
      record: record,
      notes: notes,
    );

    if (intervalRecommendation != null) {
      return VaccinationRecommendation(
        doseNumber: doseNumber,
        source: RecommendationSource.noteConstraint,
        startDate: intervalRecommendation.start,
        endDate: intervalRecommendation.end,
        labels: periodsByDose[doseNumber] ?? const <String>[],
      );
    }

    final List<String> labels = periodsByDose[doseNumber] ?? const <String>[];
    if (labels.isEmpty) {
      return null;
    }

    final DateRange? range = VaccinationPeriodCalculator.dateRangeForLabels(
      birthday: childBirthday,
      labels: labels,
    );

    if (range == null || range.end.isBefore(range.start)) {
      return VaccinationRecommendation(
        doseNumber: doseNumber,
        source: RecommendationSource.masterSchedule,
        labels: labels,
      );
    }

    return VaccinationRecommendation(
      doseNumber: doseNumber,
      source: RecommendationSource.masterSchedule,
      startDate: range.start,
      endDate: range.end,
      labels: labels,
    );
  }

  Map<int, List<String>> _collectPeriodsByDose(Vaccine vaccine) {
    final Map<int, List<String>> result = <int, List<String>>{};
    for (final VaccineScheduleSlot slot in vaccine.schedule) {
      if (slot.doseNumbers.isEmpty) continue;
      for (final int dose in slot.doseNumbers) {
        final List<String> periods = result.putIfAbsent(dose, () => <String>[]);
        if (!periods.contains(slot.periodId)) {
          periods.add(slot.periodId);
        }
      }
    }
    return result;
  }

  _DoseIntervalRecommendation? _resolveIntervalRecommendation({
    required int doseNumber,
    required VaccinationRecord? record,
    required List<VaccineNote> notes,
  }) {
    if (record == null) {
      return null;
    }

    final List<_DoseIntervalConstraint> constraints =
        _parseDoseIntervalConstraints(notes);
    if (constraints.isEmpty) {
      return null;
    }

    final List<_DoseIntervalConstraint> candidates = constraints
        .where((constraint) => constraint.toDose == doseNumber)
        .toList(growable: false);
    if (candidates.isEmpty) {
      return null;
    }

    candidates.sort((a, b) => b.fromDose.compareTo(a.fromDose));

    for (final _DoseIntervalConstraint constraint in candidates) {
      final DoseRecord? baseRecord = record.getDose(constraint.fromDose);
      final DateTime? baseDate =
          baseRecord?.completedDate ?? baseRecord?.scheduledDate;
      if (baseDate == null) {
        continue;
      }

      final DateTime start =
          _applyIntervalValue(baseDate, constraint.minimumOffset);
      final DateTime? end = constraint.maximumOffset != null
          ? _applyIntervalValue(baseDate, constraint.maximumOffset!)
          : null;

      return _DoseIntervalRecommendation(start: start, end: end);
    }

    return null;
  }
}

class _DoseIntervalRecommendation {
  const _DoseIntervalRecommendation({
    required this.start,
    this.end,
  });

  final DateTime start;
  final DateTime? end;
}

class _DoseIntervalConstraint {
  const _DoseIntervalConstraint({
    required this.fromDose,
    required this.toDose,
    required this.minimumOffset,
    this.maximumOffset,
  });

  final int fromDose;
  final int toDose;
  final _IntervalValue minimumOffset;
  final _IntervalValue? maximumOffset;
}

class _IntervalValue {
  const _IntervalValue(this.amount, this.unit);

  final int amount;
  final _IntervalUnit unit;
}

enum _IntervalUnit { days, weeks, months, years }

List<_DoseIntervalConstraint> _parseDoseIntervalConstraints(
  List<VaccineNote> notes,
) {
  final List<_DoseIntervalConstraint> constraints = <_DoseIntervalConstraint>[];

  for (final VaccineNote note in notes) {
    final String message = note.message;

    for (final RegExpMatch match in _doseRangePattern.allMatches(message)) {
      final int? fromDose = _parseCircledDigit(match.group(1));
      final int? toDose = _parseCircledDigit(match.group(2));
      final _IntervalValue? minimum =
          _parseIntervalValue(match.group(3), match.group(5));
      final _IntervalValue? maximum =
          _parseIntervalValue(match.group(4), match.group(5));

      if (fromDose != null &&
          toDose != null &&
          minimum != null &&
          maximum != null) {
        constraints.add(
          _DoseIntervalConstraint(
            fromDose: fromDose,
            toDose: toDose,
            minimumOffset: minimum,
            maximumOffset: maximum,
          ),
        );
      }
    }

    for (final RegExpMatch match in _doseMinimumPattern.allMatches(message)) {
      final int? fromDose = _parseCircledDigit(match.group(1));
      final int? toDose = _parseCircledDigit(match.group(2));
      final _IntervalValue? minimum =
          _parseIntervalValue(match.group(3), match.group(4));

      if (fromDose != null && toDose != null && minimum != null) {
        constraints.add(
          _DoseIntervalConstraint(
            fromDose: fromDose,
            toDose: toDose,
            minimumOffset: minimum,
          ),
        );
      }
    }
  }

  return constraints;
}

_IntervalValue? _parseIntervalValue(String? amountText, String? unitText) {
  if (amountText == null || unitText == null) {
    return null;
  }

  final int? amount = int.tryParse(amountText);
  if (amount == null) {
    return null;
  }

  switch (unitText) {
    case '日':
      return _IntervalValue(amount, _IntervalUnit.days);
    case '週間':
    case '週':
      return _IntervalValue(amount, _IntervalUnit.weeks);
    case 'ヶ月':
    case 'か月':
      return _IntervalValue(amount, _IntervalUnit.months);
    case '年':
      return _IntervalValue(amount, _IntervalUnit.years);
    default:
      return null;
  }
}

int? _parseCircledDigit(String? text) =>
    text == null ? null : _circledDigitMap[text];

DateTime _applyIntervalValue(DateTime base, _IntervalValue value) {
  switch (value.unit) {
    case _IntervalUnit.days:
      return base.add(Duration(days: value.amount));
    case _IntervalUnit.weeks:
      return base.add(Duration(days: value.amount * 7));
    case _IntervalUnit.months:
      return _addMonthsClamped(base, value.amount);
    case _IntervalUnit.years:
      return _addMonthsClamped(base, value.amount * 12);
  }
}

DateTime _addMonthsClamped(DateTime date, int monthsToAdd) {
  final int yearOffset = (date.month - 1 + monthsToAdd) ~/ 12;
  final int targetYear = date.year + yearOffset;
  final int targetMonth = ((date.month - 1 + monthsToAdd) % 12) + 1;
  final int lastDay = _lastDayOfMonth(targetYear, targetMonth);
  final int targetDay = date.day > lastDay ? lastDay : date.day;
  return DateTime(targetYear, targetMonth, targetDay);
}

int _lastDayOfMonth(int year, int month) {
  final DateTime firstDayNextMonth =
      month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
  return firstDayNextMonth.subtract(const Duration(days: 1)).day;
}

const Map<String, int> _circledDigitMap = <String, int>{
  '①': 1,
  '②': 2,
  '③': 3,
  '④': 4,
  '⑤': 5,
  '⑥': 6,
  '⑦': 7,
  '⑧': 8,
  '⑨': 9,
  '⑩': 10,
  '⑪': 11,
  '⑫': 12,
};

final RegExp _doseRangePattern = RegExp(
  r'([①-⑫])と([①-⑫])[はも]([0-9]+)〜([0-9]+)(日|週間|週|ヶ月|か月|年)',
);

final RegExp _doseMinimumPattern = RegExp(
  r'([①-⑫])と([①-⑫])[はも]([0-9]+)(日|週間|週|ヶ月|か月|年)(?:以上)?',
);
