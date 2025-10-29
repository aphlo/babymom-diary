import '../value/percentile.dart';

class GrowthCurvePoint {
  GrowthCurvePoint({
    required this.ageInMonths,
    required this.ageLabel,
    required Map<Percentile, double> percentiles,
  }) : percentiles = Map.unmodifiable(percentiles);

  final double ageInMonths;
  final String ageLabel;
  final Map<Percentile, double> percentiles;

  double valueFor(Percentile percentile) {
    final value = percentiles[percentile];
    if (value == null) {
      throw StateError(
        'Percentile ${percentile.value}% is not available for age '
        '$ageInMonths months ($ageLabel)',
      );
    }
    return value;
  }
}
