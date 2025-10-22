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

    Widget? childBadge;
    final childName = event.childName;
    if (childName != null && childName.isNotEmpty) {
      childBadge = _buildChildBadge(
        context,
        childName,
        event.childColorHex,
      );
    }

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
            if (childBadge != null) ...[
              const SizedBox(height: 8),
              childBadge,
            ],
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

  Widget _buildChildBadge(
    BuildContext context,
    String childName,
    String? colorHex,
  ) {
    final theme = Theme.of(context);
    final baseColor = _parseColor(colorHex) ?? theme.colorScheme.primary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: baseColor.withOpacity(0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: baseColor.withOpacity(0.4)),
      ),
      child: Text(
        childName,
        style: theme.textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.w600,
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }

  Color? _parseColor(String? hex) {
    if (hex == null || hex.isEmpty) {
      return null;
    }
    final cleaned = hex.replaceAll('#', '').padLeft(6, '0');
    final value = int.tryParse(cleaned, radix: 16);
    if (value == null) {
      return null;
    }
    return Color(0xFF000000 | value);
  }
}
