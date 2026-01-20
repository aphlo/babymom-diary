import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import '../../../domain/value/age_range.dart';

/// 年齢範囲選択タブ
class AgeRangeTabs extends StatelessWidget {
  const AgeRangeTabs({
    super.key,
    required this.selected,
    required this.onSelect,
  });

  final AgeRange selected;
  final Future<void> Function(AgeRange) onSelect;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = context.isDarkMode;

    final selectedColor = context.primaryColor;
    final unselectedColor = context.menuSectionBackground;
    final borderColor = isDark
        ? context.menuSectionBorder
        : context.primaryColor.withValues(alpha: 0.35);
    final selectedTextColor = context.onPrimaryColor;
    final unselectedTextColor = selectedColor;

    final borderRadius = BorderRadius.circular(12);

    return Container(
      decoration: BoxDecoration(
        color: unselectedColor,
        borderRadius: borderRadius,
        border: Border.all(color: borderColor, width: 1.1),
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: theme.shadowColor.withValues(alpha: 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: AgeRange.values.map((range) {
            final isSelected = range == selected;
            return Expanded(
              child: InkWell(
                onTap: () => onSelect(range),
                child: Container(
                  height: 26,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isSelected ? selectedColor : unselectedColor,
                  ),
                  child: Text(
                    range.label,
                    style: theme.textTheme.labelLarge?.copyWith(
                          color: isSelected
                              ? selectedTextColor
                              : unselectedTextColor,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w500,
                        ) ??
                        TextStyle(
                          color: isSelected
                              ? selectedTextColor
                              : unselectedTextColor,
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
      ),
    );
  }
}
