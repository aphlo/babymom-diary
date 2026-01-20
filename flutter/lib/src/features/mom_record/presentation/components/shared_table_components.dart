import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';

/// テーブルのヘッダーセル
class TableHeaderCell extends StatelessWidget {
  const TableHeaderCell({
    super.key,
    required this.label,
    required this.flex,
    this.textAlign = TextAlign.center,
  });

  final String label;
  final int flex;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.labelLarge?.copyWith(
      color: theme.colorScheme.onSurfaceVariant,
      fontWeight: FontWeight.w600,
    );
    return Expanded(
      flex: flex,
      child: Text(
        label,
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}

/// テーブルのデータセル
class TableDataCell extends StatelessWidget {
  const TableDataCell({
    super.key,
    required this.text,
    required this.flex,
    this.style,
    this.padding,
  });

  final String text;
  final int flex;
  final TextStyle? style;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: Text(
          text,
          style: style,
          softWrap: true,
        ),
      ),
    );
  }
}

/// テーブルのヘッダー部分
class TableHeader extends StatelessWidget {
  const TableHeader({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final headerColor =
        theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6);

    return Container(
      color: headerColor,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(children: children),
    );
  }
}

/// 週末の背景色を取得するヘルパー関数
Color getWeekendRowColor(DateTime date, BuildContext context) {
  final weekday = date.weekday;
  if (weekday == DateTime.saturday) {
    return context.saturdayRowBackground;
  } else if (weekday == DateTime.sunday) {
    return context.sundayRowBackground;
  } else {
    return Theme.of(context).colorScheme.surface;
  }
}
