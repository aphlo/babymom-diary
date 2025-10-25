import 'package:flutter/foundation.dart';

@immutable
class LochiaStatus {
  const LochiaStatus({
    this.amount,
    this.color,
  }) : assert(
          amount != null || color != null,
          'LochiaStatus requires at least one value.',
        );

  final LochiaAmount? amount;
  final LochiaColor? color;

  static const Object _sentinel = Object();

  LochiaStatus copyWith({
    Object? amount = _sentinel,
    Object? color = _sentinel,
  }) {
    final nextAmount =
        amount == _sentinel ? this.amount : amount as LochiaAmount?;
    final nextColor = color == _sentinel ? this.color : color as LochiaColor?;
    return LochiaStatus(amount: nextAmount, color: nextColor);
  }

  bool get hasAmount => amount != null;
  bool get hasColor => color != null;
  bool get isComplete => hasAmount && hasColor;
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
