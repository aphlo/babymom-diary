import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../feeding_table_settings/domain/entities/feeding_table_settings.dart';
import '../models/weekly_summary_model.dart';

/// 回数 / 量 / 体温の表示モード
enum ChartDisplayMode { count, amount, temperature }

/// カテゴリ別折れ線グラフ（回数/量/体温の切り替え対応）
class WeeklySummaryChart extends StatelessWidget {
  const WeeklySummaryChart({
    required this.data,
    required this.category,
    required this.displayMode,
    super.key,
  });

  final WeeklySummaryData data;
  final FeedingTableCategory category;
  final ChartDisplayMode displayMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = categoryColor(category);
    final isTemp = displayMode == ChartDisplayMode.temperature;
    final isAmount = displayMode == ChartDisplayMode.amount;

    // データポイントを生成
    final spots = <FlSpot>[];
    var maxVal = 0.0;
    var minVal = double.infinity;
    var hasAnyData = false;

    for (var i = 0; i < data.days.length; i++) {
      final value = data.days[i].values[category] ?? CategoryDayValue.zero;
      final double y;
      if (isTemp) {
        final temp = value.latestTemperature;
        if (temp == null || temp == 0) {
          // 体温データなしの日はスキップ（グラフに含めない）
          continue;
        }
        y = temp;
      } else {
        y = isAmount ? value.totalAmount : value.count.toDouble();
      }
      spots.add(FlSpot(i.toDouble(), y));
      if (y > maxVal) maxVal = y;
      if (y < minVal) minVal = y;
      hasAnyData = true;
    }

    // Y軸の範囲
    final double yMin;
    final double yMax;
    if (isTemp) {
      // 体温: 35〜39℃ を基本範囲とし、データに応じて調整
      yMin = hasAnyData ? (minVal - 0.5).floorToDouble().clamp(34, 37) : 35;
      yMax = hasAnyData ? (maxVal + 0.5).ceilToDouble().clamp(37, 42) : 39;
    } else {
      yMin = 0;
      yMax = maxVal == 0 ? 5.0 : (maxVal * 1.2).ceilToDouble();
    }

    return SizedBox(
      height: 200,
      child: Padding(
        padding: const EdgeInsets.only(right: 16, top: 16),
        child: LineChart(
          LineChartData(
            minX: 0,
            maxX: 6,
            minY: yMin,
            maxY: yMax,
            lineTouchData: LineTouchData(
              touchTooltipData: LineTouchTooltipData(
                getTooltipItems: (touchedSpots) {
                  return touchedSpots.map((spot) {
                    if (isTemp) {
                      return LineTooltipItem(
                        '${spot.y.toStringAsFixed(1)}℃',
                        TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    }
                    final unit = isAmount ? 'ml' : '回';
                    final val = isAmount
                        ? spot.y.toStringAsFixed(0)
                        : spot.y.toInt().toString();
                    return LineTooltipItem(
                      '$val$unit',
                      TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }).toList();
                },
              ),
            ),
            titlesData: FlTitlesData(
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 40,
                  getTitlesWidget: (value, meta) {
                    if (value == meta.max || value == meta.min) {
                      return const SizedBox.shrink();
                    }
                    final label = isTemp
                        ? value.toStringAsFixed(1)
                        : value.toInt().toString();
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Text(
                        label,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.textTheme.bodySmall?.color,
                        ),
                      ),
                    );
                  },
                ),
              ),
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  reservedSize: 32,
                  getTitlesWidget: (value, meta) {
                    final idx = value.toInt();
                    if (idx < 0 || idx >= data.days.length) {
                      return const SizedBox.shrink();
                    }
                    final date = data.days[idx].date;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '${date.month}/${date.day}',
                        style: theme.textTheme.labelSmall,
                      ),
                    );
                  },
                ),
              ),
            ),
            gridData: FlGridData(
              drawVerticalLine: false,
              drawHorizontalLine: true,
              getDrawingHorizontalLine: (value) => FlLine(
                color: theme.dividerColor.withValues(alpha: 0.3),
                strokeWidth: 0.5,
              ),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                preventCurveOverShooting: true,
                color: color,
                barWidth: 2.5,
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) =>
                      FlDotCirclePainter(
                    radius: 3,
                    color: Colors.white,
                    strokeColor: color,
                    strokeWidth: 2,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: !isTemp,
                  color: color.withValues(alpha: 0.15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// カテゴリが量（ml）データを持つかどうか
bool categoryHasAmount(FeedingTableCategory c) =>
    c == FeedingTableCategory.formula || c == FeedingTableCategory.pump;

/// カテゴリごとの色を返す
Color categoryColor(FeedingTableCategory c) => switch (c) {
      FeedingTableCategory.nursing => AppColors.primary,
      FeedingTableCategory.formula => AppColors.secondary,
      FeedingTableCategory.pump => const Color(0xFF9C27B0),
      FeedingTableCategory.babyFood => const Color(0xFF4CAF50),
      FeedingTableCategory.pee => const Color(0xFFFF9800),
      FeedingTableCategory.poop => const Color(0xFF795548),
      FeedingTableCategory.temperature => const Color(0xFFEF5350),
      _ => Colors.grey,
    };
