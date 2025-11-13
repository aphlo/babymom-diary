import 'package:flutter/material.dart';

class CalendarErrorBanner extends StatelessWidget {
  const CalendarErrorBanner({required this.error, super.key});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: colors.error.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.error.withOpacity(0.4)),
      ),
      child: Row(
        children: [
          Icon(Icons.error_outline, color: colors.error),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '予定の取得に失敗しました',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: colors.error),
            ),
          ),
        ],
      ),
    );
  }
}
