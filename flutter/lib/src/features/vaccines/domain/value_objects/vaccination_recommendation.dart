import 'package:freezed_annotation/freezed_annotation.dart';

part 'vaccination_recommendation.freezed.dart';

enum RecommendationSource {
  noteConstraint,
  masterSchedule,
}

@freezed
sealed class VaccinationRecommendation with _$VaccinationRecommendation {
  const factory VaccinationRecommendation({
    required int doseNumber,
    required RecommendationSource source,
    DateTime? startDate,
    DateTime? endDate,
    @Default(<String>[]) List<String> labels,
  }) = _VaccinationRecommendation;
}
