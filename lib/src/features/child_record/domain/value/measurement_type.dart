enum MeasurementType {
  height(unit: 'cm'),
  weight(unit: 'kg');

  const MeasurementType({required this.unit});

  final String unit;

  String get labelJa {
    switch (this) {
      case MeasurementType.height:
        return '身長';
      case MeasurementType.weight:
        return '体重';
    }
  }
}
