import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../menu/children/domain/entities/child_summary.dart';
import '../../child_record.dart';
import '../models/growth_chart_data.dart';

class GrowthChartState {
  const GrowthChartState({
    required this.selectedAgeRange,
    required this.chartData,
    this.childSummary,
    this.isLoadingChild = true,
  });

  final AgeRange selectedAgeRange;
  final AsyncValue<GrowthChartData> chartData;
  final ChildSummary? childSummary;
  final bool isLoadingChild;

  factory GrowthChartState.initial() => GrowthChartState(
        selectedAgeRange: AgeRange.oneYear,
        chartData: const AsyncValue<GrowthChartData>.loading(),
        childSummary: null,
        isLoadingChild: true,
      );

  GrowthChartState copyWith({
    AgeRange? selectedAgeRange,
    AsyncValue<GrowthChartData>? chartData,
    ChildSummary? childSummary,
    bool replaceChildSummary = false,
    bool? isLoadingChild,
  }) {
    return GrowthChartState(
      selectedAgeRange: selectedAgeRange ?? this.selectedAgeRange,
      chartData: chartData ?? this.chartData,
      childSummary: replaceChildSummary
          ? childSummary
          : (childSummary ?? this.childSummary),
      isLoadingChild: isLoadingChild ?? this.isLoadingChild,
    );
  }
}
