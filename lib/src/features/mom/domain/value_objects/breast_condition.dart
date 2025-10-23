import 'package:flutter/foundation.dart';

@immutable
class BreastCondition {
  const BreastCondition({
    required this.firmness,
    required this.pain,
    required this.redness,
  });

  final SymptomIntensity firmness;
  final SymptomIntensity pain;
  final SymptomIntensity redness;

  BreastCondition copyWith({
    SymptomIntensity? firmness,
    SymptomIntensity? pain,
    SymptomIntensity? redness,
  }) {
    return BreastCondition(
      firmness: firmness ?? this.firmness,
      pain: pain ?? this.pain,
      redness: redness ?? this.redness,
    );
  }
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
