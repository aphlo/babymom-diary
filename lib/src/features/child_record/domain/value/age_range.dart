enum AgeRange {
  oneYear(maxMonths: 12),
  twoYears(maxMonths: 24),
  fourYears(maxMonths: 48);

  const AgeRange({required this.maxMonths});

  final double maxMonths;

  String get label {
    switch (this) {
      case AgeRange.oneYear:
        return '1歳';
      case AgeRange.twoYears:
        return '2歳';
      case AgeRange.fourYears:
        return '4歳';
    }
  }

  bool containsMonths(double months) {
    return months <= maxMonths;
  }

  AgeRange get next {
    switch (this) {
      case AgeRange.oneYear:
        return AgeRange.twoYears;
      case AgeRange.twoYears:
        return AgeRange.fourYears;
      case AgeRange.fourYears:
        return AgeRange.fourYears;
    }
  }
}
