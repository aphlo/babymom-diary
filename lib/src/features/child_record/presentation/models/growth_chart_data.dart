import '../../child_record.dart';
import 'growth_measurement_point.dart';

class GrowthChartData {
  const GrowthChartData({
    required this.heightCurve,
    required this.weightCurve,
    required this.measurements,
    required this.allMeasurements,
  });

  final List<GrowthCurvePoint> heightCurve;
  final List<GrowthCurvePoint> weightCurve;

  /// Measurements filtered for chart display (may exclude records before dueDate when using corrected age)
  final List<GrowthMeasurementPoint> measurements;

  /// All measurements without corrected age filtering (for record list display)
  final List<GrowthMeasurementPoint> allMeasurements;

  static const empty = GrowthChartData(
    heightCurve: <GrowthCurvePoint>[],
    weightCurve: <GrowthCurvePoint>[],
    measurements: <GrowthMeasurementPoint>[],
    allMeasurements: <GrowthMeasurementPoint>[],
  );
}
