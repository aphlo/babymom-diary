import '../../../../core/types/gender.dart';
import '../../child_record.dart';
import '../sources/asset_growth_curve_data_source.dart';

class GrowthCurveRepositoryImpl implements GrowthCurveRepository {
  GrowthCurveRepositoryImpl({
    required AssetGrowthCurveDataSource assetDataSource,
  }) : _assetDataSource = assetDataSource;

  final AssetGrowthCurveDataSource _assetDataSource;

  @override
  Future<List<GrowthCurvePoint>> getCurve({
    required MeasurementType measurement,
    required Gender gender,
    required AgeRange ageRange,
  }) async {
    final allPoints = await _assetDataSource.loadCurve(
      measurement: measurement,
      gender: gender,
    );
    return allPoints
        .where((point) => ageRange.containsMonths(point.ageInMonths))
        .toList(growable: false);
  }
}
