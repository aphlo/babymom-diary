import '../../../../core/types/gender.dart';
import '../entities/growth_curve_point.dart';
import '../value/age_range.dart';
import '../value/measurement_type.dart';

abstract class GrowthCurveRepository {
  Future<List<GrowthCurvePoint>> getCurve({
    required MeasurementType measurement,
    required Gender gender,
    required AgeRange ageRange,
  });
}
