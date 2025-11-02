import '../entities/vaccine.dart';
import '../value_objects/influenza_season.dart';

class InfluenzaScheduleGenerator {
  const InfluenzaScheduleGenerator();

  List<InfluenzaSeasonDefinition> defineSeasons(
    List<VaccineScheduleSlot> scheduleSlots,
  ) {
    final List<InfluenzaSeasonDefinition> definitions =
        <InfluenzaSeasonDefinition>[];
    for (int index = 0; index < scheduleSlots.length; index++) {
      final VaccineScheduleSlot slot = scheduleSlots[index];
      definitions.add(
        InfluenzaSeasonDefinition(
          index: index,
          periodId: slot.periodId,
          firstDoseNumber: index * 2 + 1,
          secondDoseNumber: index * 2 + 2,
        ),
      );
    }
    return definitions;
  }

  Map<String, List<int>> buildPeriodDoseMap(
    List<InfluenzaSeasonDefinition> definitions,
  ) {
    final Map<String, List<int>> result = <String, List<int>>{};
    for (final InfluenzaSeasonDefinition definition in definitions) {
      result[definition.periodId] = definition.doseNumbers;
    }
    return result;
  }

  List<int> collectDoseNumbers(List<InfluenzaSeasonDefinition> definitions) {
    final List<int> result = <int>[];
    for (final InfluenzaSeasonDefinition definition in definitions) {
      result.addAll(definition.doseNumbers);
    }
    return result;
  }

  List<InfluenzaSeasonSchedule> buildSeasonSchedules({
    required List<InfluenzaSeasonDefinition> definitions,
    required DateTime? childBirthday,
  }) {
    final allSchedules = definitions
        .map(
          (InfluenzaSeasonDefinition definition) => InfluenzaSeasonSchedule(
            definition: definition,
            seasonStart:
                _computeInfluenzaSeasonStart(childBirthday, definition.index),
          ),
        )
        .toList(growable: false);

    // 子供の誕生日がある場合は7年分に制限
    if (childBirthday != null && allSchedules.length > 7) {
      return allSchedules.take(7).toList(growable: false);
    }

    return allSchedules;
  }

  DateTime? _computeInfluenzaSeasonStart(
    DateTime? childBirthday,
    int seasonIndex,
  ) {
    if (childBirthday == null) {
      return null;
    }
    final DateTime firstSeasonStart = _addMonthsKeepingDay(childBirthday, 6);
    return _addMonthsKeepingDay(firstSeasonStart, seasonIndex * 12);
  }

  DateTime _addMonthsKeepingDay(DateTime date, int monthsToAdd) {
    final int totalMonths = date.month - 1 + monthsToAdd;
    final int targetYear = date.year + totalMonths ~/ 12;
    final int targetMonth = (totalMonths % 12) + 1;
    final int lastDay = _lastDayOfMonth(targetYear, targetMonth);
    final int targetDay = date.day > lastDay ? lastDay : date.day;
    return DateTime(targetYear, targetMonth, targetDay);
  }

  int _lastDayOfMonth(int year, int month) {
    final DateTime firstDayNextMonth =
        month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);
    return firstDayNextMonth.subtract(const Duration(days: 1)).day;
  }
}
