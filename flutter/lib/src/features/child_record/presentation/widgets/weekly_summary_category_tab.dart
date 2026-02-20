import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import '../../../feeding_table_settings/domain/entities/feeding_table_settings.dart';
import '../models/weekly_summary_model.dart';
import 'weekly_summary_chart.dart';
import 'weekly_summary_components.dart';

/// カテゴリ別の詳細タブ（チャート + サマリーカード + 日別一覧）
class CategoryDetailTab extends StatefulWidget {
  const CategoryDetailTab({
    required this.data,
    required this.category,
    super.key,
  });

  final WeeklySummaryData data;
  final FeedingTableCategory category;

  @override
  State<CategoryDetailTab> createState() => _CategoryDetailTabState();
}

class _CategoryDetailTabState extends State<CategoryDetailTab> {
  late ChartDisplayMode _displayMode;

  @override
  void initState() {
    super.initState();
    final category = widget.category;
    if (category == FeedingTableCategory.temperature) {
      _displayMode = ChartDisplayMode.temperature;
    } else if (categoryHasAmount(category)) {
      _displayMode = ChartDisplayMode.amount;
    } else {
      _displayMode = ChartDisplayMode.count;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.data;
    final category = widget.category;
    final isTemp = category == FeedingTableCategory.temperature;
    final hasAmount = categoryHasAmount(category);
    final isAmount = _displayMode == ChartDisplayMode.amount;

    // ダークモードではbottom navと同色にならないよう少し明るくする
    final bgColor =
        context.isDarkMode ? const Color(0xFF232127) : context.pageBackground;

    // 体温タブ
    if (isTemp) {
      return _buildTemperatureTab(context, data, bgColor);
    }

    // 通常カテゴリ
    final unit = isAmount ? 'ml' : '回';
    var total = 0.0;
    for (final day in data.days) {
      final value = day.values[category] ?? CategoryDayValue.zero;
      total += isAmount ? value.totalAmount : value.count.toDouble();
    }
    final average = total / 7;
    final totalDisplay =
        isAmount ? total.toStringAsFixed(0) : total.toInt().toString();
    final averageDisplay = average.toStringAsFixed(1);

    return Container(
      color: bgColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // グラフカード
            WeeklySummaryChartCard(
              child: Column(
                children: [
                  if (hasAmount)
                    Padding(
                      padding: const EdgeInsets.only(right: 12, bottom: 4),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          _DisplayModeToggle(
                            mode: _displayMode,
                            onChanged: (mode) =>
                                setState(() => _displayMode = mode),
                          ),
                        ],
                      ),
                    ),
                  WeeklySummaryChart(
                    data: data,
                    category: category,
                    displayMode: _displayMode,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            WeeklySummaryRow(
              items: [
                WeeklySummaryItem(label: '合計', value: '$totalDisplay$unit'),
                WeeklySummaryItem(
                    label: '日平均', value: '$averageDisplay$unit/日'),
              ],
            ),
            const SizedBox(height: 12),
            WeeklySummaryCardContainer(
              child: WeeklySummaryDailyValues(
                data: data,
                category: category,
                displayMode: _displayMode,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTemperatureTab(
    BuildContext context,
    WeeklySummaryData data,
    Color bgColor,
  ) {
    const category = FeedingTableCategory.temperature;

    // 体温の集計
    var tempSum = 0.0;
    var tempCount = 0;
    for (final day in data.days) {
      final value = day.values[category] ?? CategoryDayValue.zero;
      final temp = value.latestTemperature;
      if (temp != null && temp > 0) {
        tempSum += temp;
        tempCount++;
      }
    }
    final avgTemp = tempCount > 0 ? tempSum / tempCount : 0.0;

    return Container(
      color: bgColor,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // グラフカード
            WeeklySummaryChartCard(
              child: WeeklySummaryChart(
                data: data,
                category: category,
                displayMode: ChartDisplayMode.temperature,
              ),
            ),
            // 注意文言
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 4, left: 4),
              child: Text(
                '※ 同日に複数の記録がある場合、最新の記録を表示しています',
                style: TextStyle(
                  fontSize: 11,
                  color: context.subtextColor,
                ),
              ),
            ),
            const SizedBox(height: 8),
            // サマリーカード
            WeeklySummaryRow(
              items: [
                WeeklySummaryItem(
                  label: '記録日数',
                  value: '$tempCount日 / 7日',
                ),
                WeeklySummaryItem(
                  label: '平均体温',
                  value: tempCount > 0 ? '${avgTemp.toStringAsFixed(1)}℃' : '-',
                ),
              ],
            ),
            const SizedBox(height: 12),
            // 日別一覧カード
            WeeklySummaryCardContainer(
              child: WeeklySummaryDailyValues(
                data: data,
                category: category,
                displayMode: ChartDisplayMode.temperature,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 回数/量の切り替えトグル
class _DisplayModeToggle extends StatelessWidget {
  const _DisplayModeToggle({
    required this.mode,
    required this.onChanged,
  });

  final ChartDisplayMode mode;
  final ValueChanged<ChartDisplayMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<ChartDisplayMode>(
      segments: const [
        ButtonSegment(
          value: ChartDisplayMode.count,
          label: Text('回数'),
        ),
        ButtonSegment(
          value: ChartDisplayMode.amount,
          label: Text('量'),
        ),
      ],
      selected: {mode},
      showSelectedIcon: false,
      onSelectionChanged: (selection) => onChanged(selection.first),
      style: ButtonStyle(
        visualDensity: VisualDensity.compact,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
    );
  }
}
