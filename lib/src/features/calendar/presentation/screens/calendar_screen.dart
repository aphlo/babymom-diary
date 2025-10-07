import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/features/calendar/application/calendar_event_controller.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/presentation/screens/add_calendar_event_screen.dart';
import 'package:babymom_diary/src/features/children/application/children_local_provider.dart';
import 'package:babymom_diary/src/features/children/application/selected_child_provider.dart';
import 'package:babymom_diary/src/features/children/application/selected_child_snapshot_provider.dart';
import 'package:babymom_diary/src/features/children/domain/entities/child_summary.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart'
    as fbcore;

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    final initial = ref.read(selectedCalendarDateProvider);
    _focusedDay = initial;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) {
        return;
      }
      // Defer provider mutation until after the first build completes.
      ref.read(focusedCalendarMonthProvider.notifier).state =
          DateTime(initial.year, initial.month);
    });
  }

  Map<DateTime, List<CalendarEvent>> _groupEventsByDay(
    List<CalendarEvent> events,
  ) {
    final map = <DateTime, List<CalendarEvent>>{};
    for (final event in events) {
      var cursor = DateTime(
        event.start.year,
        event.start.month,
        event.start.day,
      );
      final end = DateTime(event.end.year, event.end.month, event.end.day);
      while (!cursor.isAfter(end)) {
        map.putIfAbsent(cursor, () => []).add(event);
        cursor = cursor.add(const Duration(days: 1));
      }
    }
    return map;
  }

  List<CalendarEvent> _eventsForDay(
    Map<DateTime, List<CalendarEvent>> eventsByDay,
    DateTime day,
  ) {
    final key = DateTime(day.year, day.month, day.day);
    return eventsByDay[key] ?? const [];
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue<List<CalendarEvent>>>(
      calendarEventsProvider,
      (previous, next) {
        next.whenOrNull(
          error: (error, stackTrace) {
            if (!mounted) {
              return;
            }
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('予定の取得に失敗しました')),
            );
          },
        );
      },
    );

    final selectedDate = ref.watch(selectedCalendarDateProvider);
    final eventsForSelectedDate = ref.watch(eventsForSelectedDateProvider);
    final allEventsAsync = ref.watch(calendarEventsProvider);
    final allEvents = allEventsAsync.value ?? const <CalendarEvent>[];
    final eventsByDay = _groupEventsByDay(allEvents);
    final isLoadingEvents = allEventsAsync.isLoading;
    final hasError = allEventsAsync.hasError;
    final Object? loadError =
        allEventsAsync.whenOrNull(error: (error, __) => error);
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 5, 1, 1);
    final lastDate = DateTime(now.year + 5, 12, 31);

    List<CalendarEvent> dayEvents(DateTime day) =>
        _eventsForDay(eventsByDay, day).toList()
          ..sort((a, b) => a.start.compareTo(b.start));

    Future<void> openAddEventScreen() async {
      final result = await Navigator.of(context).push<AddCalendarEventResult>(
        MaterialPageRoute(
          builder: (_) => AddCalendarEventScreen(initialDate: selectedDate),
        ),
      );

      if (result == null) {
        return;
      }

      if (!mounted || !context.mounted) {
        return;
      }

      final messenger = ScaffoldMessenger.of(context);
      final selectedChildId = ref.read(selectedChildControllerProvider).value;
      if (selectedChildId == null || selectedChildId.isEmpty) {
        messenger.showSnackBar(
          const SnackBar(content: Text('予定を追加する子どもを先に選択してください')),
        );
        return;
      }

      late final String householdId;
      try {
        householdId = await ref.read(fbcore.currentHouseholdIdProvider.future);
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text('世帯情報の取得に失敗しました: $e')),
        );
        return;
      }

      if (!mounted || !context.mounted) {
        return;
      }

      ChildSummary? findChild(String id) {
        final localState = ref.read(childrenLocalProvider(householdId));
        final localChildren = localState.value;
        if (localChildren != null) {
          for (final child in localChildren) {
            if (child.id == id) {
              return child;
            }
          }
        }

        final snapshotState =
            ref.read(selectedChildSnapshotProvider(householdId));
        final snapshot = snapshotState.value;
        if (snapshot != null && snapshot.id == id) {
          return snapshot;
        }
        return null;
      }

      final childSummary = findChild(selectedChildId);

      final addEvent = ref.read(addCalendarEventUseCaseProvider);

      try {
        await addEvent(
          householdId: householdId,
          childId: selectedChildId,
          title: result.title,
          memo: result.memo,
          allDay: result.allDay,
          start: result.start,
          end: result.end,
          iconKey: result.iconPath,
          childName: childSummary?.name,
          childColorHex: childSummary?.color,
        );
        messenger.showSnackBar(
          const SnackBar(content: Text('予定を保存しました')),
        );
      } catch (e) {
        messenger.showSnackBar(
          SnackBar(content: Text('予定の保存に失敗しました: $e')),
        );
      }
    }

    void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
      setState(() {
        _focusedDay = focusedDay;
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        ref.read(selectedCalendarDateProvider.notifier).state =
            DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
        ref.read(focusedCalendarMonthProvider.notifier).state =
            DateTime(focusedDay.year, focusedDay.month);
      });
    }

    final headerFormatter = DateFormat.yMMMMd('ja');

    return Scaffold(
      appBar: AppBar(
        title: const Text('カレンダー'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            child: TableCalendar<CalendarEvent>(
              firstDay: firstDate,
              lastDay: lastDate,
              focusedDay: _focusedDay,
              currentDay: DateTime.now(),
              startingDayOfWeek: StartingDayOfWeek.monday,
              locale: 'ja_JP',
              availableGestures: AvailableGestures.horizontalSwipe,
              rowHeight: 60,
              eventLoader: dayEvents,
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                titleTextFormatter: (date, locale) =>
                    DateFormat.yMMMM(locale).format(date),
                leftChevronIcon: const Icon(Icons.chevron_left),
                rightChevronIcon: const Icon(Icons.chevron_right),
              ),
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: true,
                canMarkersOverflow: true,
                isTodayHighlighted: false,
              ),
              onDaySelected: onDaySelected,
              selectedDayPredicate: (day) => isSameDay(day, selectedDate),
              onPageChanged: (focusedDay) {
                setState(() {
                  _focusedDay = focusedDay;
                });
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (!mounted) {
                    return;
                  }
                  ref.read(focusedCalendarMonthProvider.notifier).state =
                      DateTime(focusedDay.year, focusedDay.month);
                });
              },
              calendarBuilders: CalendarBuilders<CalendarEvent>(
                defaultBuilder: (context, day, focusedDay) {
                  final events = dayEvents(day);
                  return _CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: isSameDay(day, selectedDate),
                    isOutside: false,
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  final events = dayEvents(day);
                  return _CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: true,
                    isSelected: isSameDay(day, selectedDate),
                    isOutside: false,
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  final events = dayEvents(day);
                  return _CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: true,
                    isOutside: false,
                  );
                },
                outsideBuilder: (context, day, focusedDay) {
                  final events = dayEvents(day);
                  return _CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: isSameDay(day, selectedDate),
                    isOutside: true,
                  );
                },
              ),
            ),
          ),
          if (isLoadingEvents)
            const SizedBox(
              height: 2,
              child: LinearProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerFormatter.format(selectedDate),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          if (hasError && loadError != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _CalendarErrorBanner(error: loadError),
            ),
          Expanded(
            child: hasError && loadError != null
                ? _CalendarErrorView(error: loadError)
                : _SelectedDayEventList(events: eventsForSelectedDate),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: openAddEventScreen,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}

class _EmptyEventsView extends StatelessWidget {
  const _EmptyEventsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.event_available,
            size: 48,
            color: Theme.of(context).disabledColor,
          ),
          const SizedBox(height: 12),
          const Text('この日の予定はまだありません'),
        ],
      ),
    );
  }
}

class _CalendarErrorBanner extends StatelessWidget {
  const _CalendarErrorBanner({required this.error});

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

class _CalendarErrorView extends StatelessWidget {
  const _CalendarErrorView({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: colors.error),
            const SizedBox(height: 12),
            Text(
              '予定の取得に失敗しました',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: colors.error),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              '$error',
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectedDayEventList extends StatelessWidget {
  const _SelectedDayEventList({required this.events});

  final List<CalendarEvent> events;

  static const _scrollPhysics = BouncingScrollPhysics(
    parent: AlwaysScrollableScrollPhysics(),
  );

  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return ListView(
        physics: _scrollPhysics,
        padding: const EdgeInsets.fromLTRB(16, 40, 16, 24),
        children: const [
          _EmptyEventsView(),
        ],
      );
    }

    return ListView.separated(
      physics: _scrollPhysics,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      itemBuilder: (context, index) {
        final event = events[index];
        return _CalendarEventTile(event: event);
      },
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemCount: events.length,
    );
  }
}

class _CalendarEventTile extends StatelessWidget {
  const _CalendarEventTile({required this.event});

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
                if (icon != null) ...[
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

class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({
    required this.day,
    required this.events,
    required this.isToday,
    required this.isSelected,
    required this.isOutside,
  });

  final DateTime day;
  final List<CalendarEvent> events;
  final bool isToday;
  final bool isSelected;
  final bool isOutside;

  static const _iconSpacing = 2.0;

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
        final iconSize = size.shortestSide * 0.24;
        final padding = EdgeInsets.all(size.shortestSide * 0.12);
        final maxIcons = _estimateMaxIcons(size, iconSize);
        final visibleEvents = events.take(maxIcons).toList();
        final overflowCount = events.length - visibleEvents.length;

        Widget buildEventIcon(CalendarEvent event) {
          if (event.iconPath.isEmpty) {
            final icon = Icon(
              event.allDay ? Icons.event_available : Icons.schedule,
              size: iconSize,
              color: Theme.of(context).iconTheme.color,
            );
            return isOutside ? Opacity(opacity: 0.35, child: icon) : icon;
          }

          Widget image = ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.asset(
              event.iconPath,
              width: iconSize,
              height: iconSize,
              fit: BoxFit.cover,
            ),
          );

          if (isOutside) {
            image = Opacity(opacity: 0.35, child: image);
          }

          return image;
        }

        const dashLength = 4.0;
        const dashGap = 2.0;
        const strokeWidth = 1.0;

        final background = _backgroundColor(context);
        final borderColor = _borderColor(context);

        return CustomPaint(
          painter: _DashedBorderPainter(
            borderColor: borderColor,
            dashLength: dashLength,
            dashGap: dashGap,
            strokeWidth: strokeWidth,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: background ?? Colors.transparent,
            ),
            child: Stack(
              children: [
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
                Positioned.fill(
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: dayFontSize + padding.top * 0.5,
                      left: padding.left,
                      right: padding.right,
                      bottom: padding.bottom,
                    ),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Wrap(
                        spacing: _iconSpacing,
                        runSpacing: _iconSpacing,
                        children: [
                          for (final event in visibleEvents)
                            SizedBox(
                              width: iconSize,
                              height: iconSize,
                              child: buildEventIcon(event),
                            ),
                          if (overflowCount > 0)
                            _MoreBadge(
                              overflow: overflowCount,
                              height: iconSize,
                              muted: isOutside,
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  int _estimateMaxIcons(Size cell, double iconSize) {
    final usableWidth = cell.width * 0.82;
    final usableHeight = cell.height * 0.58;
    final perRow = usableWidth ~/ (iconSize + _iconSpacing);
    final rows = usableHeight ~/ (iconSize + _iconSpacing);
    final capacity = (perRow.clamp(1, 6)) * (rows.clamp(1, 3));
    return capacity.clamp(0, 12);
  }
}

class _MoreBadge extends StatelessWidget {
  const _MoreBadge({
    required this.overflow,
    required this.height,
    this.muted = false,
  });

  final int overflow;
  final double height;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final baseColor = colors.surfaceContainerHighest;
    final onBase = colors.onSurfaceVariant;

    return Container(
      height: height,
      constraints: BoxConstraints(minWidth: height),
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: muted ? baseColor.withOpacity(0.4) : baseColor,
      ),
      child: Text(
        '+$overflow',
        style: TextStyle(
          fontSize: 12,
          color: muted ? onBase.withOpacity(0.5) : onBase,
        ),
      ),
    );
  }
}

class _DashedBorderPainter extends CustomPainter {
  const _DashedBorderPainter({
    required this.borderColor,
    required this.dashLength,
    required this.dashGap,
    required this.strokeWidth,
  });

  final Color borderColor;
  final double dashLength;
  final double dashGap;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    if (size.isEmpty) return;

    final rect = Offset.zero & size;
    final path = Path()..addRect(rect);
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true;

    for (final metric in path.computeMetrics()) {
      var distance = 0.0;
      while (distance < metric.length) {
        final next =
            (distance + dashLength).clamp(0.0, metric.length).toDouble();
        final dashPath = metric.extractPath(distance, next);
        canvas.drawPath(dashPath, paint);
        distance = next + dashGap;
      }
    }
  }

  @override
  bool shouldRepaint(covariant _DashedBorderPainter oldDelegate) {
    return borderColor != oldDelegate.borderColor ||
        dashLength != oldDelegate.dashLength ||
        dashGap != oldDelegate.dashGap ||
        strokeWidth != oldDelegate.strokeWidth;
  }
}
