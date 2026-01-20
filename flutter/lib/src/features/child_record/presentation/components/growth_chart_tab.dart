import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/core/widgets/empty_placeholder.dart';
import '../../../ads/application/services/banner_ad_manager.dart';
import '../../../ads/presentation/widgets/banner_ad_widget.dart';
import '../../domain/value/age_range.dart';
import '../models/growth_chart_data.dart';
import '../viewmodels/record_view_model.dart';
import '../widgets/growth_chart.dart';
import '../viewmodels/growth_chart/growth_chart_view_model.dart';
import 'growth_chart/age_range_tabs.dart';
import 'growth_chart/chart_actions.dart';
import 'growth_chart/chart_legend.dart';

class GrowthChartTab extends ConsumerWidget {
  const GrowthChartTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(growthChartViewModelProvider);
    final notifier = ref.read(growthChartViewModelProvider.notifier);
    final summary = state.childSummary;
    final selectedDate = ref.watch(recordViewModelProvider).selectedDate;

    if (state.isLoadingChild) {
      return const Center(child: CircularProgressIndicator());
    }

    if (summary == null) {
      return const EmptyPlaceholder(
        icon: Icons.child_care,
        title: '子どもを登録してください',
        description: '成長曲線を表示するには、メニューから子どもを登録してください。',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AgeRangeTabs(
                    selected: state.selectedAgeRange,
                    onSelect: (range) => notifier.changeAgeRange(range),
                  ),
                ),
                const SizedBox(height: 6),
                Expanded(
                  child: state.chartData.when(
                    data: (data) => _ChartContent(
                      data: data,
                      ageRange: state.selectedAgeRange,
                      initialDate: selectedDate,
                      childBirthday: summary.birthday,
                    ),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (error, stack) => EmptyPlaceholder(
                      icon: Icons.error_outline,
                      title: '読み込みに失敗しました',
                      description: error.toString(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const BannerAdWidget(slot: BannerAdSlot.growthChart),
      ],
    );
  }
}

class _ChartContent extends StatelessWidget {
  const _ChartContent({
    required this.data,
    required this.ageRange,
    required this.initialDate,
    required this.childBirthday,
  });

  final GrowthChartData data;
  final AgeRange ageRange;
  final DateTime initialDate;
  final DateTime? childBirthday;

  @override
  Widget build(BuildContext context) {
    if (data.heightCurve.isEmpty || data.weightCurve.isEmpty) {
      return const EmptyPlaceholder(
        icon: Icons.insights_outlined,
        title: '標準曲線データが見つかりませんでした',
        description: 'アセットの成長曲線データを確認してください。',
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 2),
        Expanded(
          child: GrowthChart(
            data: data,
            ageRange: ageRange,
          ),
        ),
        const SizedBox(height: 4),
        const ChartLegendWithSource(),
        const SizedBox(height: 8),
        ChartActions(
          initialDate: initialDate,
          childBirthday: childBirthday,
        ),
      ],
    );
  }
}
