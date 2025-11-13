import 'package:flutter/material.dart';

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
    return Theme.of(context).dividerColor.withOpacity(isOutside ? 0.3 : 0.6);
  }

  Color? _backgroundColor(BuildContext context) {
    if (isSelected) {
      return Theme.of(context).colorScheme.primary.withOpacity(0.12);
    }
    if (isToday) {
      return Theme.of(context).colorScheme.secondary.withOpacity(0.08);
    }
    return null;
  }

  Color _dayNumberColor(BuildContext context) {
    final base = Theme.of(context).textTheme.bodyLarge?.color ??
        Theme.of(context).colorScheme.onSurface;
    Color color;

    // 祝日は赤色
    if (isHoliday) {
      color = Colors.red;
    } else {
      switch (day.weekday) {
        case DateTime.sunday:
          color = Colors.red;
          break;
        case DateTime.saturday:
          color = Colors.blue;
          break;
        default:
          color = base;
          break;
      }
    }

    if (isOutside) {
      return color.withOpacity(0.35);
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
        final borderRadius = BorderRadius.circular(size.shortestSide * 0.2);
        final dayReservedHeight = dayFontSize + padding.top * 0.6;
        final iconAreaPadding = EdgeInsets.only(
          top: dayReservedHeight,
          left: size.shortestSide * 0.06,
          right: size.shortestSide * 0.06,
          bottom: size.shortestSide * 0.06,
        );

        Widget buildEventIcon(CalendarEvent event) {
          final paddingValue = size.shortestSide * 0.04;
          Widget child;
          if (event.iconPath.isEmpty) {
            child = Center(
              child: Icon(
                Icons.task_alt,
                size: size.shortestSide * 0.5,
                color: Colors.grey,
              ),
            );
          } else {
            child = Image.asset(
              event.iconPath,
              fit: BoxFit.cover,
            );
          }

          Widget icon = Padding(
            padding: EdgeInsets.all(paddingValue),
            child: ClipRRect(
              borderRadius: borderRadius,
              child: SizedBox.expand(child: child),
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
                Positioned.fill(
                  child: Padding(
                    padding: iconAreaPadding,
                    child: buildEventIcon(primaryEvent),
                  ),
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
