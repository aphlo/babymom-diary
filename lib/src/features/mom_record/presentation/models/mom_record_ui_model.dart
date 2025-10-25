import 'package:flutter/foundation.dart';

import '../../domain/entities/mom_monthly_records.dart';
import '../../domain/value_objects/breast_condition.dart';
import '../../domain/value_objects/lochia_status.dart';

@immutable
class MomDailyRecordUiModel {
  const MomDailyRecordUiModel({
    required this.date,
    required this.dateLabel,
    this.temperature,
    this.lochiaAmount,
    this.lochiaColor,
    this.breastFirmness,
    this.breastPain,
    this.breastRedness,
    this.memo,
  });

  final DateTime date;
  final String dateLabel;
  final double? temperature;
  final LochiaAmount? lochiaAmount;
  final LochiaColor? lochiaColor;
  final SymptomIntensity? breastFirmness;
  final SymptomIntensity? breastPain;
  final SymptomIntensity? breastRedness;
  final String? memo;

  bool get hasMemo => memo != null && memo!.isNotEmpty;

  bool get hasData =>
      temperature != null ||
      lochiaAmount != null ||
      lochiaColor != null ||
      breastFirmness != null ||
      breastPain != null ||
      breastRedness != null ||
      hasMemo;

  String? get temperatureLabel => _formatTemperature(temperature);

  String? get lochiaAmountLabel => _formatLochiaAmount(lochiaAmount);

  String? get lochiaColorLabel => _formatLochiaColor(lochiaColor);

  String? get breastFirmnessLabel => _formatSymptomIntensity(breastFirmness);

  String? get breastPainLabel => _formatSymptomIntensity(breastPain);

  String? get breastRednessLabel => _formatSymptomIntensity(breastRedness);

  String? get lochiaSummary {
    if (lochiaAmountLabel == null && lochiaColorLabel == null) {
      return null;
    }
    final amount = lochiaAmountLabel ?? '-';
    final color = lochiaColorLabel ?? '-';
    return '量：$amount\n色：$color';
  }

  String? get breastSummary {
    if (breastFirmnessLabel == null &&
        breastPainLabel == null &&
        breastRednessLabel == null) {
      return null;
    }
    final firmness = breastFirmnessLabel ?? '-';
    final pain = breastPainLabel ?? '-';
    final redness = breastRednessLabel ?? '-';
    return '張り：$firmness\n痛み：$pain\n赤み：$redness';
  }
}

@immutable
class MomMonthlyRecordUiModel {
  MomMonthlyRecordUiModel({
    required this.year,
    required this.month,
    required List<MomDailyRecordUiModel> days,
  }) : days = List<MomDailyRecordUiModel>.unmodifiable(days);

  final int year;
  final int month;
  final List<MomDailyRecordUiModel> days;

  String get monthLabel => '$year年${month.toString().padLeft(2, '0')}月';

  static MomMonthlyRecordUiModel fromDomain(MomMonthlyRecords records) {
    return MomMonthlyRecordUiModel(
      year: records.year,
      month: records.month,
      days: records.records
          .map(
            (record) => MomDailyRecordUiModel(
              date: record.date,
              dateLabel: _formatDateLabel(record.date),
              temperature: record.temperatureCelsius,
              lochiaAmount: record.lochia?.amount,
              lochiaColor: record.lochia?.color,
              breastFirmness: record.breast?.firmness,
              breastPain: record.breast?.pain,
              breastRedness: record.breast?.redness,
              memo: record.memo,
            ),
          )
          .toList(growable: false),
    );
  }
}

String _formatDateLabel(DateTime date) {
  const weekdays = ['月', '火', '水', '木', '金', '土', '日'];
  final weekdayLabel = weekdays[date.weekday - 1];
  return '${date.day}日\n($weekdayLabel)';
}

String? _formatTemperature(double? temperature) {
  if (temperature == null) {
    return null;
  }
  return '${temperature.toStringAsFixed(1)}℃';
}

String? _formatLochiaAmount(LochiaAmount? amount) {
  if (amount == null) {
    return null;
  }
  switch (amount) {
    case LochiaAmount.low:
      return '少';
    case LochiaAmount.medium:
      return '中';
    case LochiaAmount.high:
      return '多';
  }
}

String? _formatLochiaColor(LochiaColor? color) {
  if (color == null) {
    return null;
  }
  switch (color) {
    case LochiaColor.yellow:
      return '黄';
    case LochiaColor.brown:
      return '茶';
    case LochiaColor.pink:
      return 'ピンク';
    case LochiaColor.red:
      return '赤';
  }
}

String? _formatSymptomIntensity(SymptomIntensity? intensity) {
  if (intensity == null) {
    return null;
  }
  switch (intensity) {
    case SymptomIntensity.slight:
      return 'すこし';
    case SymptomIntensity.normal:
      return 'ふつう';
    case SymptomIntensity.strong:
      return 'つよい';
  }
}
