import 'package:meta/meta.dart';

@immutable
class InfluenzaSeasonDefinition {
  const InfluenzaSeasonDefinition({
    required this.index,
    required this.periodId,
    required this.firstDoseNumber,
    required this.secondDoseNumber,
  });

  final int index;
  final String periodId;
  final int firstDoseNumber;
  final int secondDoseNumber;

  List<int> get doseNumbers => <int>[firstDoseNumber, secondDoseNumber];
}

@immutable
class InfluenzaSeasonSchedule {
  const InfluenzaSeasonSchedule({
    required this.definition,
    this.seasonStart,
  });

  final InfluenzaSeasonDefinition definition;
  final DateTime? seasonStart;

  int get seasonIndex => definition.index;
  int get firstDoseNumber => definition.firstDoseNumber;
  int get secondDoseNumber => definition.secondDoseNumber;
  String get periodId => definition.periodId;

  String seasonLabel({String fallback = '未設定'}) {
    final DateTime? start = seasonStart;
    if (start == null) {
      return fallback;
    }
    return '${start.year}年';
  }
}
