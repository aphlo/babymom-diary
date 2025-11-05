import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine.dart'
    as domain;
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccination_period_highlight.dart'
    as domain;
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_priority.dart'
    as domain;
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccination_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/vaccine_master.dart';
import 'package:babymom_diary/src/features/vaccines/domain/services/influenza_schedule_generator.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/influenza_season.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccination_period.dart';

import '../models/vaccine_info.dart';
import '../viewmodels/vaccines_view_data.dart';

VaccinesViewData mapGuidelineToViewData(
  VaccineMaster guideline, {
  required InfluenzaScheduleGenerator influenzaScheduleGenerator,
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
          influenzaScheduleGenerator: influenzaScheduleGenerator,
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
  required InfluenzaScheduleGenerator influenzaScheduleGenerator,
  VaccinationRecord? record,
  DateTime? childBirthday,
  List<String>? periods,
}) {
  final Map<String, List<int>> doseSchedules = <String, List<int>>{};
  final Map<String, domain.VaccinationPeriodHighlight> periodHighlights =
      <String, domain.VaccinationPeriodHighlight>{};
  final Set<int> expectedDoseNumbers = <int>{};
  final bool isInfluenza = vaccine.id == 'influenza';
  final bool canResolveActualPeriods =
      record != null && childBirthday != null && periods != null;

  if (isInfluenza &&
      record != null &&
      childBirthday != null &&
      periods != null) {
    // 実際の予約データから動的にマッピングを生成
    final dynamicMapping = _buildDynamicInfluenzaMapping(
      record: record,
      childBirthday: childBirthday,
      periods: periods,
    );
    doseSchedules.addAll(dynamicMapping.doseSchedules);
    expectedDoseNumbers.addAll(dynamicMapping.expectedDoseNumbers);

    // ハイライト情報は既存の処理を使用
    for (final domain.VaccineScheduleSlot slot in vaccine.schedule) {
      final domain.VaccinationPeriodHighlight? highlight = slot.highlight;
      if (highlight != null) {
        periodHighlights[slot.periodId] = highlight;
      }
    }
  } else if (isInfluenza) {
    // 既存の固定的な処理（予約データがない場合）
    final List<InfluenzaSeasonDefinition> definitions =
        influenzaScheduleGenerator.defineSeasons(vaccine.schedule);
    doseSchedules.addAll(
      influenzaScheduleGenerator.buildPeriodDoseMap(definitions),
    );
    expectedDoseNumbers
        .addAll(influenzaScheduleGenerator.collectDoseNumbers(definitions));
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
    isInfluenza: isInfluenza,
  );

  final Map<int, String> doseDisplayOverrides = canResolveActualPeriods
      ? _buildDoseDisplayOverrides(
          record: record,
          childBirthday: childBirthday,
          periods: periods,
        )
      : const <int, String>{};

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
  bool isInfluenza = false,
}) {
  final Map<int, DoseStatus?> result = <int, DoseStatus?>{};

  if (isInfluenza && record != null) {
    // インフルエンザの場合は動的マッピングを使用
    final scheduledDoses = record.orderedDoses
      ..sort((a, b) {
        final dateA = a.scheduledDate;
        final dateB = b.scheduledDate;
        if (dateA == null && dateB == null) return 0;
        if (dateA == null) return 1;
        if (dateB == null) return -1;
        return dateA.compareTo(dateB);
      });

    for (int i = 0; i < scheduledDoses.length; i++) {
      final newDoseNumber = i + 1;
      result[newDoseNumber] = scheduledDoses[i].status;
    }
  } else {
    // 既存の処理
    for (final int doseNumber in expectedDoseNumbers) {
      final DoseStatus? status = record?.getDoseByNumber(doseNumber)?.status;
      result[doseNumber] = status;
    }
  }

  return result;
}

class _DynamicInfluenzaMapping {
  const _DynamicInfluenzaMapping({
    required this.doseSchedules,
    required this.expectedDoseNumbers,
  });

  final Map<String, List<int>> doseSchedules;
  final Set<int> expectedDoseNumbers;
}

_DynamicInfluenzaMapping _buildDynamicInfluenzaMapping({
  required VaccinationRecord record,
  required DateTime childBirthday,
  required List<String> periods,
}) {
  final Map<String, List<int>> doseSchedules = {};
  final Set<int> expectedDoseNumbers = {};

  // 予約済みのドーズを日付順にソート
  final scheduledDoses = record.orderedDoses
    ..sort((a, b) {
      final dateA = a.scheduledDate;
      final dateB = b.scheduledDate;
      if (dateA == null && dateB == null) return 0;
      if (dateA == null) return 1;
      if (dateB == null) return -1;
      return dateA.compareTo(dateB);
    });

  // 連番で新しいドーズ番号を割り当て
  for (int i = 0; i < scheduledDoses.length; i++) {
    final dose = scheduledDoses[i];
    final newDoseNumber = i + 1; // 1から開始
    final doseDate = dose.scheduledDate;

    if (doseDate != null) {
      // 子供の年齢を計算して適切な期間を特定
      final ageInMonths = _calculateAgeInMonths(childBirthday, doseDate);
      final periodLabel = _findPeriodForAge(ageInMonths, periods);

      if (periodLabel != null) {
        doseSchedules[periodLabel] = (doseSchedules[periodLabel] ?? [])
          ..add(newDoseNumber);
        expectedDoseNumbers.add(newDoseNumber);
      }
    }
  }

  return _DynamicInfluenzaMapping(
    doseSchedules: doseSchedules,
    expectedDoseNumbers: expectedDoseNumbers,
  );
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
