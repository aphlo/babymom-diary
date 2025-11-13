import '../../../../core/types/gender.dart';
import '../../child_record.dart';

class GetGrowthCurves {
  const GetGrowthCurves(this._repository);

  final GrowthCurveRepository _repository;

  Future<({List<GrowthCurvePoint> height, List<GrowthCurvePoint> weight})>
      call({
    required Gender gender,
    required AgeRange ageRange,
  }) async {
    final height = await _repository.getCurve(
      measurement: MeasurementType.height,
      gender: gender,
      ageRange: ageRange,
    );
    final weight = await _repository.getCurve(
      measurement: MeasurementType.weight,
      gender: gender,
      ageRange: ageRange,
    );
    return (height: height, weight: weight);
  }
}
