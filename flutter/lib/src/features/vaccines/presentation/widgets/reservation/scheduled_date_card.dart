import 'package:flutter/material.dart';

import '../../../../../core/theme/semantic_colors.dart';
import '../../../../../core/utils/date_formatter.dart';

/// 予約済み日付を表示するカード
///
/// 予約詳細ページで使用される
class ScheduledDateCard extends StatelessWidget {
  const ScheduledDateCard({
    super.key,
    required this.scheduledDate,
  });

  final DateTime? scheduledDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardBackground,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: context.cardShadow,
            offset: const Offset(0, 8),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.event_available,
                color: context.reservedContainerAccent,
                size: 24,
              ),
              const SizedBox(width: 12),
              Text(
                '日付',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (scheduledDate != null) ...[
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: context.reservedContainerBackground,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    color: context.reservedContainerAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      DateFormatter.yyyyMMddE(scheduledDate!),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: context.reservedContainerAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ] else ...[
            Text(
              '予約日時が設定されていません',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: context.textSecondary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
