import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import '../../../feeding_table_settings/domain/entities/feeding_table_settings.dart';
import '../models/weekly_summary_model.dart';
import 'weekly_summary_chart.dart';

/// サマリー横並び（合計 + 日平均）
class WeeklySummaryRow extends StatelessWidget {
  const WeeklySummaryRow({required this.items, super.key});

  final List<WeeklySummaryItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border:
            Border.all(color: context.tableBorderColor.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: context.cardShadow,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            for (var i = 0; i < items.length; i++) ...[
              if (i > 0)
                VerticalDivider(
                  width: 1,
                  thickness: 1,
                  color: context.tableBorderColor.withValues(alpha: 0.4),
                ),
              Expanded(child: _buildCell(context, items[i])),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildCell(BuildContext context, WeeklySummaryItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label,
            style: TextStyle(
              fontSize: 11,
              color: context.subtextColor,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            item.value,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class WeeklySummaryItem {
  const WeeklySummaryItem({required this.label, required this.value});
  final String label;
  final String value;
}

/// グラフ用カードコンテナ
class WeeklySummaryChartCard extends StatelessWidget {
  const WeeklySummaryChartCard({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.tableBorderColor.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: context.cardShadow,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 12, left: 4, right: 4),
      child: child,
    );
  }
}

/// 汎用カードコンテナ
class WeeklySummaryCardContainer extends StatelessWidget {
  const WeeklySummaryCardContainer({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.cardBackground,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: context.tableBorderColor.withValues(alpha: 0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: context.cardShadow,
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: child,
    );
  }
}

/// 日別の値を横並びで表示
class WeeklySummaryDailyValues extends StatelessWidget {
  const WeeklySummaryDailyValues({
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
    const weekdayLabels = ['日', '月', '火', '水', '木', '金', '土'];
    final isTemp = displayMode == ChartDisplayMode.temperature;
    final isAmount = displayMode == ChartDisplayMode.amount;

    return Row(
      children: List.generate(data.days.length, (i) {
        final day = data.days[i];
        final value = day.values[category] ?? CategoryDayValue.zero;

        final String display;
        if (isTemp) {
          final temp = value.latestTemperature;
          display = (temp != null && temp > 0) ? temp.toStringAsFixed(1) : '-';
        } else {
          final v = isAmount ? value.totalAmount : value.count.toDouble();
          display = isAmount ? v.toStringAsFixed(0) : v.toInt().toString();
        }

        final dayLabel = weekdayLabels[i];

        Color? labelColor;
        if (day.date.weekday == 6) {
          labelColor = context.saturdayColor;
        } else if (day.date.weekday == 7) {
          labelColor = context.sundayColor;
        }

        return Expanded(
          child: Column(
            children: [
              Text(
                dayLabel,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: labelColor ?? context.subtextColor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                display,
                style: TextStyle(
                  fontSize: isTemp ? 13 : 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
