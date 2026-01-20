import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import '../../pages/growth_record_list_page.dart';
import '../../widgets/growth_measurement_sheet.dart';

/// 成長曲線のアクションボタン（身長を記録、体重を記録、一覧）
class ChartActions extends StatelessWidget {
  const ChartActions({
    super.key,
    required this.initialDate,
    required this.childBirthday,
  });

  final DateTime initialDate;
  final DateTime? childBirthday;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = context.isDarkMode;
    final primaryColor = context.primaryColor;

    final buttons = [
      _ActionButtonData(
        label: '身長を記録',
        icon: Icons.straighten,
        onPressed: () => showHeightRecordSheet(
          context: context,
          initialDate: initialDate,
          minimumDate: childBirthday,
          maximumDate: DateTime.now(),
        ),
      ),
      _ActionButtonData(
        label: '体重を記録',
        icon: Icons.monitor_weight,
        onPressed: () => showWeightRecordSheet(
          context: context,
          initialDate: initialDate,
          minimumDate: childBirthday,
          maximumDate: DateTime.now(),
        ),
      ),
      _ActionButtonData(
        label: '一覧',
        icon: Icons.list_alt,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const GrowthRecordListPage(),
            ),
          );
        },
      ),
    ];

    // ダークモードではアウトラインスタイル、ライトモードではフィルドスタイル
    if (isDark) {
      return Row(
        children: [
          for (var i = 0; i < buttons.length; i++) ...[
            Expanded(
              child: SizedBox(
                height: 36,
                child: OutlinedButton(
                  onPressed: buttons[i].onPressed,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    side: BorderSide(color: primaryColor),
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

    return Row(
      children: [
        for (var i = 0; i < buttons.length; i++) ...[
          Expanded(
            child: SizedBox(
              height: 36,
              child: FilledButton(
                onPressed: buttons[i].onPressed,
                style: FilledButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
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
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
}
