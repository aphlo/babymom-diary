import 'package:flutter/material.dart';

import '../../child_record.dart';
import '../models/growth_measurement_point.dart';

/// 成長記録のフォーマット処理を行うユーティリティクラス
class GrowthFormatters {
  const GrowthFormatters._();

  /// 身長をフォーマット
  static String formatHeight(double? value) {
    if (value == null) {
      return '-';
    }
    return '${value.toStringAsFixed(1)} cm';
  }

  /// 体重をフォーマット
  static String formatWeight(GrowthMeasurementPoint record) {
    if (!record.hasWeight) {
      return '-';
    }
    final unit = record.resolvedWeightUnit;
    final value = record.weightDisplayValue;
    if (value == null) {
      return '-';
    }
    final fractionDigits =
        unit == WeightUnit.kilograms ? 2 : (value % 1 == 0 ? 0 : 2);
    final text = _formatNumber(value, fractionDigits);
    return '$text ${unit.label}';
  }

  /// 数値をフォーマット（末尾の不要なゼロを除去）
  static String _formatNumber(double value, int fractionDigits) {
    var text = value.toStringAsFixed(fractionDigits);
    if (fractionDigits > 0) {
      text = text.replaceFirst(RegExp('\\.?0+\$'), '');
    }
    return text;
  }

  /// 誕生日からの経過時間をフォーマット
  static String? formatElapsedSinceBirth(
      DateTime? birthday, DateTime recordedAt) {
    if (birthday == null) {
      return null;
    }
    final birthDate = DateUtils.dateOnly(birthday);
    final recordDate = DateUtils.dateOnly(recordedAt);

    if (recordDate.isBefore(birthDate)) {
      return null;
    }

    int years = recordDate.year - birthDate.year;
    int months = recordDate.month - birthDate.month;
    int days = recordDate.day - birthDate.day;

    if (days < 0) {
      final previousMonth = DateTime(recordDate.year, recordDate.month, 0);
      days += previousMonth.day;
      months -= 1;
    }

    if (months < 0) {
      years -= 1;
      months += 12;
    }

    final totalMonths = years * 12 + months;
    final buffer = StringBuffer();

    if (totalMonths > 0) {
      buffer.write('$totalMonthsヶ月');
    }

    if (days > 0) {
      buffer.write('$days日');
    }

    if (buffer.isEmpty) {
      buffer.write('0日');
    }

    return '生後${buffer.toString()}目';
  }
}
