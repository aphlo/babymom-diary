import '../../child_record.dart';
import '../models/growth_measurement_point.dart';

class GrowthChartUiMapper {
  const GrowthChartUiMapper();

  List<GrowthMeasurementPoint> toMeasurementPoints({
    required List<GrowthRecord> records,
    required DateTime? birthday,
  }) {
    final sorted = List<GrowthRecord>.from(records)
      ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
    return sorted
        .map(
          (record) => GrowthMeasurementPoint(
            id: record.id,
            ageInMonths: _ageInMonths(birthday, record.recordedAt),
            recordedAt: record.recordedAt,
            height: record.height,
            weight: record.weight,
            note: record.note,
          ),
        )
        .toList(growable: false);
  }

  List<GrowthMeasurementPoint> filterMeasurementsByRange(
    List<GrowthMeasurementPoint> points,
    AgeRange range,
  ) {
    return points
        .where((point) => point.ageInMonths <= range.maxMonths + 1e-6)
        .toList(growable: false);
  }

  double _ageInMonths(DateTime? birthday, DateTime recordedAt) {
    if (birthday == null) {
      return 0;
    }
    final diff = recordedAt.difference(birthday);
    final months = diff.inDays / 30.4375;
    return months.isFinite ? months.clamp(0, double.infinity) as double : 0;
  }
}
