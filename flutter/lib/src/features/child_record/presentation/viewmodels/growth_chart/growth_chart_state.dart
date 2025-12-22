import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../menu/children/domain/entities/child_summary.dart';
import '../../../child_record.dart';
import '../../models/growth_chart_data.dart';

part 'growth_chart_state.freezed.dart';

@freezed
sealed class GrowthChartState with _$GrowthChartState {
  const GrowthChartState._();

  const factory GrowthChartState({
    required AgeRange selectedAgeRange,
    required AsyncValue<GrowthChartData> chartData,
    ChildSummary? childSummary,
    @Default(true) bool isLoadingChild,
  }) = _GrowthChartState;

  factory GrowthChartState.initial() => GrowthChartState(
        selectedAgeRange: AgeRange.oneYear,
        chartData: const AsyncValue<GrowthChartData>.loading(),
        childSummary: null,
        isLoadingChild: true,
      );
}
