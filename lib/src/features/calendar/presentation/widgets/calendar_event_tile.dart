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

  String _buildSubtitle({
    required bool isMultiDay,
    required DateFormat timeFormatter,
    required DateFormat dateFormatter,
    required DateFormat dateTimeFormatter,
  }) {
    if (isMultiDay) {
      if (event.allDay) {
        // 複数日の終日: 「1/1 - 1/3」
        return '${dateFormatter.format(event.start)} - ${dateFormatter.format(event.end)}';
      } else {
        // 複数日の時間指定: 「1/1 09:00 - 1/3 18:00」
        return '${dateTimeFormatter.format(event.start)} - ${dateTimeFormatter.format(event.end)}';
      }
    } else {
      if (event.allDay) {
        // 単一日の終日: 「終日」
        return '終日';
      } else {
        // 単一日の時間指定: 「09:00 - 18:00」
        return '${timeFormatter.format(event.start)} - ${timeFormatter.format(event.end)}';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final timeFormatter = DateFormat('HH:mm');
    final dateFormatter = DateFormat('M/d');
    final dateTimeFormatter = DateFormat('M/d HH:mm');
    final isVaccination = event.id.startsWith('vaccination_');

    // 複数日にまたがるかチェック
    final isMultiDay = event.startDateOnly != event.endDateOnly;

    final subtitle = _buildSubtitle(
      isMultiDay: isMultiDay,
      timeFormatter: timeFormatter,
      dateFormatter: dateFormatter,
      dateTimeFormatter: dateTimeFormatter,
    );

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
      color: isVaccination ? Colors.blue.shade50 : null, // ワクチン予約は背景色を変更
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
                    child: Row(
                      children: [
                        if (isVaccination) ...[
                          Icon(
                            Icons.vaccines,
                            size: 16,
                            color: Colors.blue.shade700,
                          ),
                          const SizedBox(width: 4),
                        ],
                        Expanded(
                          child: Text(
                            event.title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isVaccination
                                      ? Colors.blue.shade700
                                      : null,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isVaccination ? Colors.blue.shade600 : null,
                        ),
                  ),
                ],
              ),
              if (event.memo.isNotEmpty) ...[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 52), // 40 (icon width) + 12 (spacing)
                  child: Text(
                    event.memo,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: isVaccination ? Colors.blue.shade600 : null,
                        ),
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
