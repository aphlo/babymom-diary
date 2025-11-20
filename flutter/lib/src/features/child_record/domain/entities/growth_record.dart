import '../value/weight_unit.dart';

class GrowthRecord {
  factory GrowthRecord({
    String? id,
    required String childId,
    required DateTime recordedAt,
    double? height,
    double? weight,
    WeightUnit? weightUnit,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    assert(
      height != null || weight != null,
      'Either height or weight must be provided.',
    );
    final finalId = id ??
        _generateGrowthRecordId(
          childId: childId,
          recordedAt: recordedAt,
          hasHeight: height != null,
          hasWeight: weight != null,
        );
    return GrowthRecord._(
      id: finalId,
      childId: childId,
      recordedAt: recordedAt,
      height: height,
      weight: weight,
      weightUnit: weight != null ? weightUnit : null,
      note: note,
      createdAt: createdAt ?? DateTime.now(),
      updatedAt: updatedAt ?? DateTime.now(),
    );
  }

  GrowthRecord._({
    required this.id,
    required this.childId,
    required this.recordedAt,
    this.height,
    this.weight,
    this.weightUnit,
    this.note,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String childId;
  final DateTime recordedAt;
  final double? height;
  final double? weight;
  final WeightUnit? weightUnit;
  final String? note;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  bool get hasHeight => height != null;
  bool get hasWeight => weight != null;

  GrowthRecord copyWith({
    String? id,
    String? childId,
    DateTime? recordedAt,
    double? height,
    double? weight,
    WeightUnit? weightUnit,
    bool clearHeight = false,
    bool clearWeight = false,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final resolvedHeight = clearHeight ? null : height ?? this.height;
    final resolvedWeight = clearWeight ? null : weight ?? this.weight;
    final resolvedWeightUnit =
        resolvedWeight == null ? null : weightUnit ?? this.weightUnit;

    if (resolvedHeight == null && resolvedWeight == null) {
      throw ArgumentError(
        'GrowthRecord requires at least one measurement (height or weight).',
      );
    }

    return GrowthRecord(
      id: id ?? this.id,
      childId: childId ?? this.childId,
      recordedAt: recordedAt ?? this.recordedAt,
      height: resolvedHeight,
      weight: resolvedWeight,
      weightUnit: resolvedWeightUnit,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

String _generateGrowthRecordId({
  required String childId,
  required DateTime recordedAt,
  required bool hasHeight,
  required bool hasWeight,
}) {
  String measurementPart;
  if (hasHeight && hasWeight) {
    measurementPart = 'both';
  } else if (hasHeight) {
    measurementPart = 'height';
  } else {
    measurementPart = 'weight';
  }
  final datePart =
      '${recordedAt.year.toString().padLeft(4, '0')}-${recordedAt.month.toString().padLeft(2, '0')}-${recordedAt.day.toString().padLeft(2, '0')}';
  final randomPart =
      DateTime.now().microsecondsSinceEpoch.toRadixString(36).padLeft(8, '0');
  return '$childId-$datePart-$measurementPart-$randomPart';
}
