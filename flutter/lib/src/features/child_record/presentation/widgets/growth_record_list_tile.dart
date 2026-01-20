import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import 'package:babymom_diary/src/core/utils/date_formatter.dart';
import '../models/growth_measurement_point.dart';
import '../utils/growth_formatters.dart';

/// 成長記録リストの個別タイル
class GrowthRecordListTile extends StatelessWidget {
  const GrowthRecordListTile({
    super.key,
    required this.record,
    required this.isHeightRecord,
    required this.childBirthday,
    required this.onEdit,
    required this.onDelete,
  });

  final GrowthMeasurementPoint record;
  final bool isHeightRecord;
  final DateTime? childBirthday;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final formattedDate = DateFormatter.ddE(record.recordedAt);
    final value = isHeightRecord
        ? GrowthFormatters.formatHeight(record.height)
        : GrowthFormatters.formatWeight(record);
    final ageText = GrowthFormatters.formatElapsedSinceBirth(
      childBirthday,
      record.recordedAt,
    );

    final valueTextStyle = theme.textTheme.titleMedium?.copyWith(
      fontWeight: FontWeight.w700,
      fontSize: (theme.textTheme.titleMedium?.fontSize ??
              theme.textTheme.bodyLarge?.fontSize ??
              16) +
          2,
      color: context.primaryColor,
    );

    return Container(
      color: context.menuSectionBackground,
      child: Column(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.only(
              left: 16,
              right: 8,
            ),
            title: Text(
              formattedDate,
              style: theme.textTheme.bodyLarge,
            ),
            subtitle: ageText == null
                ? null
                : Text(
                    ageText,
                    style: TextStyle(
                      color: context.subtextColor,
                      fontSize: 12,
                    ),
                  ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  value,
                  style: valueTextStyle,
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.edit),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  constraints: const BoxConstraints(
                    minWidth: 28,
                    minHeight: 28,
                  ),
                  visualDensity: VisualDensity.compact,
                  splashRadius: 18,
                  onPressed: onEdit,
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  constraints: const BoxConstraints(
                    minWidth: 28,
                    minHeight: 28,
                  ),
                  visualDensity: VisualDensity.compact,
                  splashRadius: 18,
                  onPressed: onDelete,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

/// 成長記録リストの月ヘッダー
class GrowthRecordMonthHeader extends StatelessWidget {
  const GrowthRecordMonthHeader({
    super.key,
    required this.month,
  });

  final String month;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          child: Text(
            month,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        const Divider(height: 1),
      ],
    );
  }
}
