import 'package:flutter/foundation.dart';

@immutable
class LochiaStatus {
  const LochiaStatus({
    required this.amount,
    required this.color,
  });

  final LochiaAmount amount;
  final LochiaColor color;

  LochiaStatus copyWith({
    LochiaAmount? amount,
    LochiaColor? color,
  }) {
    return LochiaStatus(
      amount: amount ?? this.amount,
      color: color ?? this.color,
    );
  }
}

enum LochiaAmount {
  low('low'),
  medium('medium'),
  high('high');

  const LochiaAmount(this.code);

  final String code;

  static LochiaAmount? fromCode(String? code) {
    if (code == null) {
      return null;
    }
    final normalized = code.trim().toLowerCase();
    if (normalized.isEmpty) {
      return null;
    }
    for (final value in LochiaAmount.values) {
      if (value.code == normalized) {
        return value;
      }
    }
    return null;
  }
}

enum LochiaColor {
  white('white'),
  yellow('yellow'),
  brown('brown'),
  pink('pink'),
  red('red');

  const LochiaColor(this.code);

  final String code;

  static LochiaColor? fromCode(String? code) {
    if (code == null) {
      return null;
    }
    final normalized = code.trim().toLowerCase();
    if (normalized.isEmpty) {
      return null;
    }
    for (final value in LochiaColor.values) {
      if (value.code == normalized) {
        return value;
      }
    }
    return null;
  }
}
