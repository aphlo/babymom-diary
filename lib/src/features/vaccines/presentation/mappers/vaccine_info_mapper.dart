import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccination_period_highlight.dart'
    as domain;
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_priority.dart'
    as domain;
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccination_period.dart';

import '../models/vaccine_info.dart';
import '../viewmodels/vaccines_view_data.dart';

VaccinesViewData mapGuidelineToViewData(
  VaccineMaster guideline, {
  Map<String, VaccinationRecord>? recordsByVaccine,
  DateTime? childBirthday,
}) {
  final List<String> periodLabels = guideline.periods
      .map((VaccinationPeriod period) => period.label)
      .toList(growable: false);

  final List<VaccineInfo> vaccines = guideline.vaccines
      .map(
        (domain.Vaccine vaccine) => _mapVaccine(
          vaccine,
          record: recordsByVaccine?[vaccine.id],
          childBirthday: childBirthday,
          periods: periodLabels,
        ),
      )
      .toList(growable: false);

  return VaccinesViewData(
    periodLabels: periodLabels,
    vaccines: vaccines,
    version: guideline.version,
    publishedAt: guideline.publishedAt,
  );
}

VaccineInfo _mapVaccine(
  domain.Vaccine vaccine, {
  VaccinationRecord? record,
  DateTime? childBirthday,
  List<String>? periods,
}) {
  final Map<String, List<int>> doseSchedules = <String, List<int>>{};
  final Map<String, domain.VaccinationPeriodHighlight> periodHighlights =
      <String, domain.VaccinationPeriodHighlight>{};
  final Set<int> expectedDoseNumbers = <int>{};
  final bool isInfluenza = vaccine.id == 'influenza';

  if (isInfluenza) {
    // インフルエンザは固定で14回分
    expectedDoseNumbers.addAll(List<int>.generate(14, (index) => index + 1));
    // インフルエンザはガイドラインの「一般的な接種期間」がないため、doseSchedulesは空のまま
    // ただしhighlightは反映する
    for (final domain.VaccineScheduleSlot slot in vaccine.schedule) {
      final domain.VaccinationPeriodHighlight? highlight = slot.highlight;
      if (highlight != null) {
        periodHighlights[slot.periodId] = highlight;
      }
    }
  } else {
    for (final domain.VaccineScheduleSlot slot in vaccine.schedule) {
      if (slot.doseNumbers.isNotEmpty) {
        final List<int> numbers = List<int>.from(slot.doseNumbers);
        doseSchedules[slot.periodId] = numbers;
        expectedDoseNumbers.addAll(numbers);
      }
      final domain.VaccinationPeriodHighlight? highlight = slot.highlight;
      if (highlight != null) {
        periodHighlights[slot.periodId] = highlight;
      }
    }
  }

  final List<int> orderedDoseNumbers = expectedDoseNumbers.toList()..sort();

  final VaccineHighlightPalette palette =
      vaccine.priority == domain.VaccinePriority.highlight
          ? VaccineHighlightPalette.secondary
          : VaccineHighlightPalette.primary;

  final List<VaccineGuidelineNote> notes = vaccine.notes
      .map(
        (domain.VaccineNote note) => VaccineGuidelineNote(
          message: note.message,
        ),
      )
      .toList(growable: false);

  final Map<int, DoseStatus?> doseStatuses = _extractDoseStatuses(
    expectedDoseNumbers: orderedDoseNumbers,
    record: record,
  );

  // doseDisplayOverridesを生成（全てのワクチン用）
  Map<int, String> doseDisplayOverrides = const <int, String>{};
  if (record != null && childBirthday != null && periods != null) {
    doseDisplayOverrides = _buildDoseDisplayOverrides(
      record: record,
      childBirthday: childBirthday,
      periods: periods,
    );
  }

  return VaccineInfo(
    id: vaccine.id,
    name: vaccine.name,
    category: vaccine.category,
    requirement: vaccine.requirement,
    doseSchedules: doseSchedules,
    periodHighlights: periodHighlights,
    highlightPalette: palette,
    notes: notes,
    doseStatuses: doseStatuses,
    doseDisplayOverrides: doseDisplayOverrides,
  );
}

Map<int, DoseStatus?> _extractDoseStatuses({
  required Iterable<int> expectedDoseNumbers,
  VaccinationRecord? record,
}) {
  final Map<int, DoseStatus?> result = <int, DoseStatus?>{};

  for (final int doseNumber in expectedDoseNumbers) {
    final DoseStatus? status = record?.getDoseByNumber(doseNumber)?.status;
    result[doseNumber] = status;
  }

  return result;
}

int _calculateAgeInMonths(DateTime birthDate, DateTime targetDate) {
  int months = (targetDate.year - birthDate.year) * 12;
  months += targetDate.month - birthDate.month;

  // 日付が誕生日前の場合は1ヶ月減らす
  if (targetDate.day < birthDate.day) {
    months--;
  }

  return months;
}

String? _findPeriodForAge(int ageInMonths, List<String> periods) {
  // 年齢に基づいて適切な期間ラベルを見つける
  if (ageInMonths >= 24) {
    // 2才以上の場合、利用可能な期間から最適なものを選択
    for (final period in periods) {
      if (period.contains('2才')) {
        return period;
      }
    }
    // 2才の期間がない場合は、年数で判定
    final years = ageInMonths ~/ 12;
    for (final period in periods) {
      if (period.contains('$years才')) {
        return period;
      }
    }
  } else if (ageInMonths >= 12) {
    // 1才台の場合
    for (final period in periods) {
      if (period.contains('1才')) {
        return period;
      }
    }
  } else {
    // 月齢の場合
    for (final period in periods) {
      if (period.contains('$ageInMonthsヶ月')) {
        return period;
      }
    }
  }

  // 完全一致しない場合は、最も近い期間を探す
  return _findClosestPeriod(ageInMonths, periods);
}

String? _findClosestPeriod(int ageInMonths, List<String> periods) {
  String? closestPeriod;
  int minDifference = double.maxFinite.toInt();

  for (final period in periods) {
    final periodAgeInMonths = _parsePeriodToMonths(period);
    if (periodAgeInMonths != null) {
      final difference = (ageInMonths - periodAgeInMonths).abs();
      if (difference < minDifference) {
        minDifference = difference;
        closestPeriod = period;
      }
    }
  }

  return closestPeriod;
}

int? _parsePeriodToMonths(String period) {
  // "Xヶ月" パターン
  final monthMatch = RegExp(r'(\d+)ヶ月').firstMatch(period);
  if (monthMatch != null) {
    return int.tryParse(monthMatch.group(1)!);
  }

  // "X才" パターン
  final yearMatch = RegExp(r'(\d+)才').firstMatch(period);
  if (yearMatch != null) {
    final years = int.tryParse(yearMatch.group(1)!);
    return years != null ? years * 12 : null;
  }

  return null;
}

Map<int, String> _buildDoseDisplayOverrides({
  required VaccinationRecord record,
  required DateTime childBirthday,
  required List<String> periods,
}) {
  final Map<int, String> overrides = <int, String>{};

  for (int i = 0; i < record.orderedDoses.length; i++) {
    final dose = record.orderedDoses[i];
    final doseNumber = i + 1; // 1-based indexing for display
    final DateTime? doseDate = dose.scheduledDate;
    if (doseDate == null) {
      continue;
    }
    final int ageInMonths = _calculateAgeInMonths(childBirthday, doseDate);
    final String? periodLabel = _findPeriodForAge(ageInMonths, periods);
    if (periodLabel != null) {
      overrides[doseNumber] = periodLabel;
    }
  }

  return overrides;
}
