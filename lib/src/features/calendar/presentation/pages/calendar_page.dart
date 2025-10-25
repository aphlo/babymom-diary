import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/presentation/models/calendar_event_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/pages/add_calendar_event_page.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/calendar_state.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/calendar_view_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/calendar_day_cell.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/calendar_error_banner.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/calendar_error_view.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/selected_day_event_list.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  @override
  Widget build(BuildContext context) {
    final viewModel = ref.read(calendarViewModelProvider.notifier);
    final messenger = ScaffoldMessenger.of(context);
    final navigator = Navigator.of(context);

    ref.listen<CalendarState>(
      calendarViewModelProvider,
      (previous, next) {
        final event = next.pendingUiEvent;
        if (event == null || event == previous?.pendingUiEvent) {
          return;
        }
        Future.microtask(() async {
          if (!mounted) {
            return;
          }
          if (event.message != null) {
            messenger.showSnackBar(
              SnackBar(content: Text(event.message!)),
            );
            viewModel.clearUiEvent();
            return;
          }
          final request = event.openAddEvent;
          if (request == null) {
            viewModel.clearUiEvent();
            return;
          }
          viewModel.clearUiEvent();
          final result = await navigator.push<CalendarEventModel>(
            MaterialPageRoute(
              builder: (_) => AddCalendarEventPage(
                initialDate: request.initialDate,
              ),
            ),
          );
          if (!mounted) {
            return;
          }
          if (result != null) {
            await viewModel.handleAddEventResult(result);
          }
        });
      },
    );

    final state = ref.watch(calendarViewModelProvider);
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 5, 1, 1);
    final lastDate = DateTime(now.year + 5, 12, 31);

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
              focusedDay: state.focusedDay,
              currentDay: DateTime.now(),
              startingDayOfWeek: StartingDayOfWeek.monday,
              locale: 'ja_JP',
              availableGestures: AvailableGestures.horizontalSwipe,
              rowHeight: 60,
              eventLoader: (day) => state.eventsForDay(day),
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
              onDaySelected: (selectedDay, focusedDay) =>
                  viewModel.onDaySelected(selectedDay, focusedDay),
              selectedDayPredicate: (day) => isSameDay(day, state.selectedDay),
              onPageChanged: viewModel.onPageChanged,
              calendarBuilders: CalendarBuilders<CalendarEvent>(
                defaultBuilder: (context, day, focusedDay) {
                  final events = state.eventsForDay(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: isSameDay(day, state.selectedDay),
                    isOutside: false,
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  final events = state.eventsForDay(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: true,
                    isSelected: isSameDay(day, state.selectedDay),
                    isOutside: false,
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  final events = state.eventsForDay(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: true,
                    isOutside: false,
                  );
                },
                outsideBuilder: (context, day, focusedDay) {
                  final events = state.eventsForDay(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: isSameDay(day, state.selectedDay),
                    isOutside: true,
                  );
                },
              ),
            ),
          ),
          if (state.isLoadingEvents)
            const SizedBox(
              height: 2,
              child: LinearProgressIndicator(),
            ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                headerFormatter.format(state.selectedDay),
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
          if (state.hasError && state.loadError != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CalendarErrorBanner(error: state.loadError!),
            ),
          Expanded(
            child: state.hasError && state.loadError != null
                ? CalendarErrorView(error: state.loadError!)
                : SelectedDayEventList(
                    events: state.eventsForSelectedDay(),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.requestAddEvent,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const AppBottomNav(),
    );
  }
}
