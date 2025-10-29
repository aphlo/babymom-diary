class GrowthMeasurementPoint {
  const GrowthMeasurementPoint({
    required this.id,
    required this.ageInMonths,
    required this.recordedAt,
    this.height,
    this.weight,
    this.note,
  });

  final String id;
  final double ageInMonths;
  final DateTime recordedAt;
  final double? height;
  final double? weight;
  final String? note;

  bool get hasHeight => height != null;
  bool get hasWeight => weight != null;
}
