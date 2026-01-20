import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';

/// 成長曲線の凡例とデータソース表示
class ChartLegendWithSource extends StatelessWidget {
  const ChartLegendWithSource({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const ChartLegend(isInline: true),
        Flexible(
          child: FittedBox(
            alignment: Alignment.centerRight,
            fit: BoxFit.scaleDown,
            child: Text(
              'こども家庭庁「令和5年乳幼児身体発育調査」より作成',
              style: (theme.textTheme.labelSmall ?? theme.textTheme.labelMedium)
                  ?.copyWith(
                fontSize: 9,
                color: context.subtextColor,
              ),
              textAlign: TextAlign.right,
              maxLines: 1,
              softWrap: false,
            ),
          ),
        ),
      ],
    );
  }
}

/// 成長曲線の凡例
class ChartLegend extends StatelessWidget {
  const ChartLegend({
    super.key,
    this.isInline = false,
  });

  final bool isInline;

  @override
  Widget build(BuildContext context) {
    final items = [
      ChartLegendItem(color: context.primaryColor, label: '身長 (cm)'),
      ChartLegendItem(color: context.secondaryColor, label: '体重 (kg)'),
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

/// 凡例の個別アイテム
class ChartLegendItem extends StatelessWidget {
  const ChartLegendItem({
    super.key,
    required this.color,
    required this.label,
  });

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
