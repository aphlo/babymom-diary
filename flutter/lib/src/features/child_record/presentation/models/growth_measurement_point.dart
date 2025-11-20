import '../../child_record.dart';

class GrowthMeasurementPoint {
  const GrowthMeasurementPoint({
    required this.id,
    required this.ageInMonths,
    required this.recordedAt,
    this.height,
    this.weightGrams,
    this.weightUnit,
    this.note,
  });

  final String id;
  final double ageInMonths;
  final DateTime recordedAt;
  final double? height;
  final double? weightGrams;
  final WeightUnit? weightUnit;
  final String? note;

  bool get hasHeight => height != null;
  bool get hasWeight => weightGrams != null;

  WeightUnit get resolvedWeightUnit => weightUnit ?? WeightUnit.kilograms;

  double? get weightKg {
    if (weightGrams == null) {
      return null;
    }
    return weightGrams! / 1000;
  }

  double? get weightDisplayValue {
    final grams = weightGrams;
    if (grams == null) {
      return null;
    }
    if (resolvedWeightUnit == WeightUnit.grams) {
      return grams;
    }
    return grams / 1000;
  }
}
