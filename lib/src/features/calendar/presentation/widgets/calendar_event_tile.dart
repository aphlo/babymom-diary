import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';

class CalendarEventTile extends StatelessWidget {
  const CalendarEventTile({
    required this.event,
    this.onTap,
    super.key,
  });

  final CalendarEvent event;
  final VoidCallback? onTap;

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
        alignment: Alignment.center,
        child: const Icon(
          Icons.task_alt,
          size: 24,
          color: Colors.grey,
        ),
      );
    }

    return Card(
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 52), // 40 (icon width) + 12 (spacing)
                  child: Text(
                    event.memo,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
