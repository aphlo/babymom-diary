enum Percentile {
  p3(3),
  p10(10),
  p25(25),
  p50(50),
  p75(75),
  p90(90),
  p97(97);

  const Percentile(this.value);

  final int value;

  String get label => '$value%';

  static const valuesAscending = [
    Percentile.p3,
    Percentile.p10,
    Percentile.p25,
    Percentile.p50,
    Percentile.p75,
    Percentile.p90,
    Percentile.p97,
  ];
}
