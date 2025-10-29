import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../child_record.dart';
import '../models/growth_chart_data.dart';
import '../widgets/growth_chart.dart';
import '../viewmodels/growth_chart_view_model.dart';

class GrowthChartTab extends ConsumerWidget {
  const GrowthChartTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(growthChartViewModelProvider);
    final notifier = ref.read(growthChartViewModelProvider.notifier);
    final summary = state.childSummary;
    final theme = Theme.of(context);

    if (state.isLoadingChild) {
      return const Center(child: CircularProgressIndicator());
    }

    if (summary == null) {
      return _EmptyPlaceholder(
        icon: Icons.child_care,
        title: '子どもを選択してください',
        description: '成長曲線を表示するには、上部のプロフィールから子どもを選択してください。',
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _Header(
            ageRange: state.selectedAgeRange,
            onSelectRange: (range) => notifier.changeAgeRange(range),
          ),
          const SizedBox(height: 6),
          Expanded(
            child: state.chartData.when(
              data: (data) => _ChartContent(
                data: data,
                ageRange: state.selectedAgeRange,
                theme: theme,
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => _EmptyPlaceholder(
                icon: Icons.error_outline,
                title: '読み込みに失敗しました',
                description: error.toString(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChartContent extends StatelessWidget {
  const _ChartContent({
    required this.data,
    required this.ageRange,
    required this.theme,
  });

  final GrowthChartData data;
  final AgeRange ageRange;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    if (data.heightCurve.isEmpty || data.weightCurve.isEmpty) {
      return const _EmptyPlaceholder(
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
        Align(
          alignment: Alignment.centerLeft,
          child: const _Legend(isInline: true),
        ),
        const SizedBox(height: 8),
        const _ChartActions(),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.ageRange,
    required this.onSelectRange,
  });

  final AgeRange ageRange;
  final Future<void> Function(AgeRange) onSelectRange;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: _AgeRangeTabs(
        selected: ageRange,
        onSelect: onSelectRange,
      ),
    );
  }
}

class _AgeRangeTabs extends StatelessWidget {
  const _AgeRangeTabs({
    required this.selected,
    required this.onSelect,
  });

  final AgeRange selected;
  final Future<void> Function(AgeRange) onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const selectedColor = Color(0xFFE87086);
    final unselectedColor = Colors.white;
    final borderColor = selectedColor.withOpacity(0.35);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: borderColor, width: 1.1),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: AgeRange.values.map((range) {
          final isSelected = range == selected;
          return Expanded(
            child: InkWell(
              onTap: () {
                onSelect(range);
              },
              child: Container(
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: isSelected ? selectedColor : unselectedColor,
                ),
                child: Text(
                  range.label,
                  style: theme.textTheme.labelLarge?.copyWith(
                        color: isSelected ? Colors.white : selectedColor,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                      ) ??
                      TextStyle(
                        color: isSelected ? Colors.white : selectedColor,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w500,
                        fontSize: 13,
                      ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _Legend extends StatelessWidget {
  const _Legend({this.isInline = false});

  final bool isInline;

  @override
  Widget build(BuildContext context) {
    const items = [
      _LegendItem(color: Color(0xFFE87086), label: '身長 (cm)'),
      _LegendItem(color: Color(0xFF2196F3), label: '体重 (kg)'),
    ];
    if (isInline) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          for (var i = 0; i < items.length; i++) ...[
            items[i],
            if (i < items.length - 1) const SizedBox(width: 12),
          ],
        ],
      );
    }
    return Wrap(
      spacing: 16,
      runSpacing: 8,
      children: items,
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});

  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: (theme.textTheme.labelSmall ?? theme.textTheme.labelMedium)
              ?.copyWith(
                  fontSize: (theme.textTheme.labelSmall?.fontSize ?? 12)),
        ),
      ],
    );
  }
}

class _ChartActions extends StatelessWidget {
  const _ChartActions();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    const buttonColor = Color(0xFFE87086);
    final buttons = [
      _ActionButtonData(
        label: '身長を記録',
        icon: Icons.straighten,
        color: buttonColor,
      ),
      _ActionButtonData(
        label: '体重を記録',
        icon: Icons.monitor_weight,
        color: buttonColor,
      ),
      _ActionButtonData(
        label: '一覧',
        icon: Icons.list_alt,
        color: buttonColor,
      ),
    ];
    return Row(
      children: [
        for (var i = 0; i < buttons.length; i++) ...[
          Expanded(
            child: SizedBox(
              height: 36,
              child: FilledButton(
                onPressed: () {},
                style: FilledButton.styleFrom(
                  backgroundColor: buttons[i].color,
                  padding: EdgeInsets.zero,
                  textStyle: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(buttons[i].icon, size: 18),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        buttons[i].label,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (i < buttons.length - 1) const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _ActionButtonData {
  const _ActionButtonData({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;
}

class _EmptyPlaceholder extends StatelessWidget {
  const _EmptyPlaceholder({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon,
              size: 48, color: theme.colorScheme.primary.withOpacity(0.6)),
          const SizedBox(height: 12),
          Text(
            title,
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              description,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
