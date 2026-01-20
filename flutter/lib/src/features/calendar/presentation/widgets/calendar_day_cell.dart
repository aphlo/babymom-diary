import 'package:flutter/material.dart';

import 'package:babymom_diary/src/core/theme/semantic_colors.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';

class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({
    required this.day,
    required this.events,
    required this.isToday,
    required this.isSelected,
    required this.isOutside,
    this.isHoliday = false,
    super.key,
  });

  final DateTime day;
  final List<CalendarEvent> events;
  final bool isToday;
  final bool isSelected;
  final bool isOutside;
  final bool isHoliday;

  Color _borderColor(BuildContext context) {
    if (isSelected) {
      return Theme.of(context).colorScheme.primary;
    }
    if (isToday) {
      return Theme.of(context).colorScheme.secondary;
    }
    return Theme.of(context)
        .dividerColor
        .withValues(alpha: isOutside ? 0.3 : 0.6);
  }

  Color? _backgroundColor(BuildContext context) {
    if (isSelected) {
      return Theme.of(context).colorScheme.primary.withValues(alpha: 0.12);
    }
    if (isToday) {
      return Theme.of(context).colorScheme.secondary.withValues(alpha: 0.08);
    }
    return null;
  }

  Color _dayNumberColor(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyLarge?.color ??
        Theme.of(context).colorScheme.onSurface;
    Color color;

    // 祝日は赤色（日曜日と同じ色）
    if (isHoliday) {
      color = context.sundayColor;
    } else {
      switch (day.weekday) {
        case DateTime.sunday:
          color = context.sundayColor;
          break;
        case DateTime.saturday:
          color = context.saturdayColor;
          break;
        default:
          color = base;
          break;
      }
    }

    if (isOutside) {
      return color.withValues(alpha: 0.35);
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.biggest;
        final dayFontSize = size.shortestSide * 0.28;
        final padding = EdgeInsets.all(size.shortestSide * 0.12);
        final CalendarEvent? primaryEvent =
            events.isEmpty ? null : events.first;
        final borderRadius = BorderRadius.circular(size.shortestSide * 0.15);

        // アイコンのサイズと位置を計算
        final iconSize = size.shortestSide * 0.85; // アイコンをさらに大きくする
        final iconPadding = size.shortestSide * 0.01;
        final iconBottom = size.shortestSide * -0.06;
        final iconRight = size.shortestSide * -0.06;

        Widget buildEventIcon(CalendarEvent event) {
          Widget child;
          if (event.iconPath.isEmpty) {
            child = Icon(
              Icons.task_alt,
              size: iconSize * 0.7,
              color: Colors.grey,
            );
          } else {
            child = Image.asset(
              event.iconPath,
              fit: BoxFit.contain,
            );
          }

          Widget icon = Padding(
            padding: EdgeInsets.all(iconPadding),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: child,
            ),
          );

          if (isOutside) {
            icon = Opacity(opacity: 0.35, child: icon);
          }

          return icon;
        }

        final background = _backgroundColor(context);
        final borderColor = _borderColor(context);

        return DecoratedBox(
          decoration: BoxDecoration(
            color: background ?? Colors.transparent,
            border: Border.all(
              color: borderColor,
              width: 0.5,
            ),
          ),
          child: Stack(
            children: [
              if (primaryEvent != null)
                Positioned(
                  right: iconRight,
                  bottom: iconBottom,
                  width: iconSize,
                  height: iconSize,
                  child: buildEventIcon(primaryEvent),
                ),
              Positioned(
                top: padding.top - 2,
                left: padding.left - 2,
                child: Text(
                  '${day.day}',
                  style: TextStyle(
                    fontSize: dayFontSize,
                    fontWeight: FontWeight.w600,
                    color: _dayNumberColor(context),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
