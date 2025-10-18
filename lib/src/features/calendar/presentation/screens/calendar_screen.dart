import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/features/calendar/application/calendar_event_controller.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/presentation/screens/add_calendar_event_screen.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/calendar_day_cell.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/calendar_error_banner.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/calendar_error_view.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/selected_day_event_list.dart';
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
                markersMaxCount: 0,
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
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: isSameDay(day, selectedDate),
                    isOutside: false,
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  final events = dayEvents(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: true,
                    isSelected: isSameDay(day, selectedDate),
                    isOutside: false,
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  final events = dayEvents(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: true,
                    isOutside: false,
                  );
                },
                outsideBuilder: (context, day, focusedDay) {
                  final events = dayEvents(day);
                  return CalendarDayCell(
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
              child: CalendarErrorBanner(error: loadError),
            ),
          Expanded(
            child: hasError && loadError != null
                ? CalendarErrorView(error: loadError)
                : SelectedDayEventList(events: eventsForSelectedDate),
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
