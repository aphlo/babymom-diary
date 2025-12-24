import 'package:freezed_annotation/freezed_annotation.dart';

part 'influenza_season.freezed.dart';

@freezed
sealed class InfluenzaSeasonDefinition with _$InfluenzaSeasonDefinition {
  const InfluenzaSeasonDefinition._();

  const factory InfluenzaSeasonDefinition({
    required int index,
    required String periodId,
    required int firstDoseNumber,
    required int secondDoseNumber,
  }) = _InfluenzaSeasonDefinition;

  List<int> get doseNumbers => <int>[firstDoseNumber, secondDoseNumber];
}

@freezed
sealed class InfluenzaSeasonSchedule with _$InfluenzaSeasonSchedule {
  const InfluenzaSeasonSchedule._();

  const factory InfluenzaSeasonSchedule({
    required InfluenzaSeasonDefinition definition,
    DateTime? seasonStart,
  }) = _InfluenzaSeasonSchedule;

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
