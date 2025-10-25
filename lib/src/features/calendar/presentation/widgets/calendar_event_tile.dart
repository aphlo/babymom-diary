import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';

class CalendarEventTile extends StatelessWidget {
  const CalendarEventTile({required this.event, super.key});

  final CalendarEvent event;

  @override
  Widget build(BuildContext context) {
    final timeFormatter = DateFormat('HH:mm');
    final subtitle = event.allDay
        ? '終日'
        : '${timeFormatter.format(event.start)} - ${timeFormatter.format(event.end)}';

    Widget? icon;
    if (event.iconPath.isNotEmpty) {
      icon = ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.asset(
          event.iconPath,
          width: 40,
          height: 40,
          fit: BoxFit.cover,
        ),
      );
    } else {
      icon = Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(8),
        ),
        alignment: Alignment.center,
        child: const Text(
          '✅',
          style: TextStyle(fontSize: 24),
        ),
      );
    }

    // 新しいデータ構造では子どもの情報は表示しない

    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ...[
                  icon,
                  const SizedBox(width: 12),
                ],
                Expanded(
                  child: Text(
                    event.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            if (event.memo.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                event.memo,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
