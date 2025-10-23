import 'package:flutter/foundation.dart';

@immutable
class BreastCondition {
  const BreastCondition({
    this.firmness,
    this.pain,
    this.redness,
  }) : assert(
          firmness != null || pain != null || redness != null,
          'BreastCondition requires at least one value.',
        );

  final SymptomIntensity? firmness;
  final SymptomIntensity? pain;
  final SymptomIntensity? redness;

  static const Object _sentinel = Object();

  BreastCondition copyWith({
    Object? firmness = _sentinel,
    Object? pain = _sentinel,
    Object? redness = _sentinel,
  }) {
    final nextFirmness =
        firmness == _sentinel ? this.firmness : firmness as SymptomIntensity?;
    final nextPain = pain == _sentinel ? this.pain : pain as SymptomIntensity?;
    final nextRedness =
        redness == _sentinel ? this.redness : redness as SymptomIntensity?;
    return BreastCondition(
      firmness: nextFirmness,
      pain: nextPain,
      redness: nextRedness,
    );
  }

  bool get hasFirmness => firmness != null;
  bool get hasPain => pain != null;
  bool get hasRedness => redness != null;
  bool get isComplete => hasFirmness && hasPain && hasRedness;
}

enum SymptomIntensity {
  none('none'),
  slight('slight'),
  normal('normal'),
  strong('strong');

  const SymptomIntensity(this.code);

  final String code;

  static SymptomIntensity? fromCode(String? code) {
    if (code == null) {
      return null;
    }
    final normalized = code.trim().toLowerCase();
    if (normalized.isEmpty) {
      return null;
    }
    for (final value in SymptomIntensity.values) {
      if (value.code == normalized) {
        return value;
      }
    }
    return null;
  }
}
