import 'package:meta/meta.dart';

enum RecommendationSource {
  noteConstraint,
  masterSchedule,
}

@immutable
class VaccinationRecommendation {
  const VaccinationRecommendation({
    required this.doseNumber,
    required this.source,
    this.startDate,
    this.endDate,
    this.labels = const <String>[],
  });

  final int doseNumber;
  final RecommendationSource source;
  final DateTime? startDate;
  final DateTime? endDate;
  final List<String> labels;
}
