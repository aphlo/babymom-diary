import '../../child_record.dart';
import 'growth_measurement_point.dart';

class GrowthChartData {
  const GrowthChartData({
    required this.heightCurve,
    required this.weightCurve,
    required this.measurements,
  });

  final List<GrowthCurvePoint> heightCurve;
  final List<GrowthCurvePoint> weightCurve;
  final List<GrowthMeasurementPoint> measurements;

  static const empty = GrowthChartData(
    heightCurve: <GrowthCurvePoint>[],
    weightCurve: <GrowthCurvePoint>[],
    measurements: <GrowthMeasurementPoint>[],
  );
}
