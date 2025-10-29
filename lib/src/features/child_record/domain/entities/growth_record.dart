class GrowthRecord {
  const GrowthRecord({
    required this.id,
    required this.childId,
    required this.recordedAt,
    this.height,
    this.weight,
    this.note,
    this.createdAt,
    this.updatedAt,
  }) : assert(
          height != null || weight != null,
          'Either height or weight must be provided.',
        );

  final String id;
  final String childId;
  final DateTime recordedAt;
  final double? height;
  final double? weight;
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
    bool clearHeight = false,
    bool clearWeight = false,
    String? note,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    final resolvedHeight = clearHeight ? null : height ?? this.height;
    final resolvedWeight = clearWeight ? null : weight ?? this.weight;

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
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
