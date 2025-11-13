import '../../child_record.dart';
import '../models/growth_measurement_point.dart';

class GrowthChartUiMapper {
  const GrowthChartUiMapper();

  /// Maps records to measurement points with corrected age filtering applied
  /// (excludes records before dueDate when using corrected age)
  List<GrowthMeasurementPoint> toMeasurementPoints({
    required List<GrowthRecord> records,
    required DateTime? birthday,
    required bool useCorrectedAge,
    required DateTime? dueDate,
  }) {
    final sorted = List<GrowthRecord>.from(records)
      ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));

    // Determine baseline date for age calculation
    final baselineDate = _determineBaseline(
      birthday: birthday,
      dueDate: dueDate,
      useCorrectedAge: useCorrectedAge,
    );

    return sorted
        .map(
          (record) => GrowthMeasurementPoint(
            id: record.id,
            ageInMonths: _ageInMonths(baselineDate, record.recordedAt),
            recordedAt: record.recordedAt,
            height: record.height,
            weight: _normalizedWeight(record.weight),
            note: record.note,
          ),
        )
        .where((point) => _shouldIncludePoint(
              point: point,
              baselineDate: baselineDate,
              useCorrectedAge: useCorrectedAge,
            ))
        .toList(growable: false);
  }

  /// Maps all records to measurement points without corrected age filtering
  /// (includes all records regardless of dueDate)
  List<GrowthMeasurementPoint> toAllMeasurementPoints({
    required List<GrowthRecord> records,
    required DateTime? birthday,
    required bool useCorrectedAge,
    required DateTime? dueDate,
  }) {
    final sorted = List<GrowthRecord>.from(records)
      ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));

    // Determine baseline date for age calculation
    final baselineDate = _determineBaseline(
      birthday: birthday,
      dueDate: dueDate,
      useCorrectedAge: useCorrectedAge,
    );

    return sorted
        .map(
          (record) => GrowthMeasurementPoint(
            id: record.id,
            ageInMonths: _ageInMonths(baselineDate, record.recordedAt),
            recordedAt: record.recordedAt,
            height: record.height,
            weight: _normalizedWeight(record.weight),
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
    return months.isFinite ? months.clamp(0.0, double.infinity) : 0.0;
  }

  double? _normalizedWeight(double? value) {
    if (value == null) {
      return null;
    }
    if (value > 20) {
      return value / 1000;
    }
    return value;
  }

  /// Determines the baseline date for age calculation based on settings
  ///
  /// If useCorrectedAge is true and the child is premature (birthday is 21+ days before dueDate):
  /// - Use dueDate as baseline (x-axis = 0)
  /// Otherwise:
  /// - Use birthday as baseline (default behavior)
  DateTime? _determineBaseline({
    required DateTime? birthday,
    required DateTime? dueDate,
    required bool useCorrectedAge,
  }) {
    if (!useCorrectedAge || birthday == null || dueDate == null) {
      return birthday;
    }

    // Check if child is premature (birthday is 21+ days before dueDate)
    final isPremature = dueDate.difference(birthday).inDays >= 21;

    if (isPremature) {
      return dueDate; // Use dueDate as baseline for corrected age
    }

    return birthday; // Use birthday as baseline (not premature)
  }

  /// Determines if a measurement point should be included in the chart
  ///
  /// When using corrected age with dueDate as baseline, exclude records before dueDate
  bool _shouldIncludePoint({
    required GrowthMeasurementPoint point,
    required DateTime? baselineDate,
    required bool useCorrectedAge,
  }) {
    if (!useCorrectedAge || baselineDate == null) {
      return true; // Include all points when not using corrected age
    }

    // When using corrected age, exclude records before baseline (dueDate)
    return point.recordedAt.isAfter(baselineDate) ||
        point.recordedAt.isAtSameMomentAs(baselineDate);
  }
}
