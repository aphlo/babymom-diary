import 'package:meta/meta.dart';

/// Provides utilities for translating vaccination period labels (e.g. `2ヶ月`,
/// `9ヶ月`, `2才`) into concrete dates relative to a child's birthday.
@immutable
class VaccinationPeriodCalculator {
  const VaccinationPeriodCalculator._();

  static DateTime? dateForLabel({
    required DateTime? birthday,
    required String label,
  }) {
    if (birthday == null) {
      return null;
    }
    final _PeriodSpan? span = _PeriodSpan.parse(label);
    if (span == null) {
      return null;
    }
    return _addMonthsClamped(birthday, span.startMonths);
  }

  static DateRange? dateRangeForLabel({
    required DateTime? birthday,
    required String label,
  }) {
    if (birthday == null) {
      return null;
    }
    final _PeriodSpan? span = _PeriodSpan.parse(label);
    if (span == null) {
      return null;
    }
    final DateTime start = _addMonthsClamped(birthday, span.startMonths);
    final DateTime endExclusive =
        _addMonthsClamped(birthday, span.endMonthsExclusive);
    final DateTime endInclusive =
        endExclusive.subtract(const Duration(days: 1));
    return DateRange(start: start, end: endInclusive);
  }

  static DateRange? dateRangeForLabels({
    required DateTime? birthday,
    required Iterable<String> labels,
  }) {
    if (birthday == null) {
      return null;
    }
    DateRange? accumulated;
    for (final String label in labels) {
      final DateRange? current =
          dateRangeForLabel(birthday: birthday, label: label);
      if (current == null) {
        return null;
      }
      if (accumulated == null) {
        accumulated = current;
      } else {
        accumulated = accumulated.extendToInclude(current);
      }
    }
    return accumulated;
  }
}

@immutable
class DateRange {
  const DateRange({required this.start, required this.end});

  final DateTime start;
  final DateTime end;

  DateRange extendToInclude(DateRange other) {
    final DateTime newStart = start.isBefore(other.start) ? start : other.start;
    final DateTime newEnd = end.isAfter(other.end) ? end : other.end;
    return DateRange(start: newStart, end: newEnd);
  }
}

class _PeriodSpan {
  _PeriodSpan._(this.startMonths, this.endMonthsExclusive);

  final int startMonths;
  final int endMonthsExclusive;

  static final RegExp _monthPattern = RegExp(r'^(\d+)ヶ月$');
  static final RegExp _monthRangePattern = RegExp(r'^(\d+)-(\d+)ヶ月$');
  static final RegExp _yearPattern = RegExp(r'^(\d+)才$');
  static final RegExp _yearMonthPattern = RegExp(r'^(\d+)才(\d+)ヶ月$');

  static _PeriodSpan? parse(String label) {
    final RegExpMatch? monthMatch = _monthPattern.firstMatch(label);
    if (monthMatch != null) {
      final int? months = int.tryParse(monthMatch.group(1)!);
      if (months == null) {
        return null;
      }
      return _PeriodSpan._(months, months + 1);
    }

    final RegExpMatch? monthRangeMatch = _monthRangePattern.firstMatch(label);
    if (monthRangeMatch != null) {
      final int? start = int.tryParse(monthRangeMatch.group(1)!);
      final int? endInclusive = int.tryParse(monthRangeMatch.group(2)!);
      if (start == null || endInclusive == null || endInclusive < start) {
        return null;
      }
      return _PeriodSpan._(start, endInclusive + 1);
    }

    final RegExpMatch? yearMatch = _yearPattern.firstMatch(label);
    if (yearMatch != null) {
      final int? years = int.tryParse(yearMatch.group(1)!);
      if (years == null) {
        return null;
      }
      final int start = years * 12;
      return _PeriodSpan._(start, start + 12);
    }

    final RegExpMatch? yearMonthMatch = _yearMonthPattern.firstMatch(label);
    if (yearMonthMatch != null) {
      final int? years = int.tryParse(yearMonthMatch.group(1)!);
      final int? months = int.tryParse(yearMonthMatch.group(2)!);
      if (years == null || months == null) {
        return null;
      }
      final int start = years * 12 + months;
      return _PeriodSpan._(start, start + 1);
    }

    return null;
  }
}

DateTime _addMonthsClamped(DateTime date, int monthsToAdd) {
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
