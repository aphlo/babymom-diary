enum WeightUnit {
  kilograms(label: 'kg'),
  grams(label: 'g');

  const WeightUnit({required this.label});

  final String label;

  String get storageValue => name;

  static WeightUnit? fromStorageValue(String? value) {
    if (value == null) {
      return null;
    }
    for (final unit in WeightUnit.values) {
      if (unit.storageValue == value) {
        return unit;
      }
    }
    return null;
  }
}
