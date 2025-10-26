import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:babymom_diary/src/core/widgets/app_bottom_nav.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/presentation/models/calendar_event_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/pages/add_calendar_event_page.dart';
import 'package:babymom_diary/src/features/calendar/presentation/pages/calendar_settings_page.dart';
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
          if (event.openSettings == true) {
            viewModel.clearUiEvent();
            await navigator.push(
              MaterialPageRoute(
                builder: (_) => const CalendarSettingsPage(),
              ),
            );
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
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 44,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _AppBarIconButton(
              icon: Icons.chevron_left,
              tooltip: '前の月',
              onPressed: () => viewModel.goToPreviousMonth(),
            ),
            Flexible(
              child: Text(
                state.monthLabel,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            _AppBarIconButton(
              icon: Icons.chevron_right,
              tooltip: '次の月',
              onPressed: () => viewModel.goToNextMonth(),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.zero,
            elevation: 0,
            clipBehavior: Clip.antiAlias,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: TableCalendar<CalendarEvent>(
              firstDay: firstDate,
              lastDay: lastDate,
              focusedDay: state.focusedDay,
              currentDay: DateTime.now(),
              startingDayOfWeek: state.calendarSettings.startingDayOfWeek
                  ? StartingDayOfWeek.monday
                  : StartingDayOfWeek.sunday,
              locale: 'ja_JP',
              availableGestures: AvailableGestures.horizontalSwipe,
              rowHeight: 54,
              eventLoader: (day) => state.eventsForDay(day),
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
                leftChevronVisible: false,
                rightChevronVisible: false,
                titleTextStyle: TextStyle(fontSize: 0),
                headerMargin: EdgeInsets.zero,
                headerPadding: EdgeInsets.zero,
              ),
              calendarStyle: const CalendarStyle(
                outsideDaysVisible: true,
                canMarkersOverflow: true,
                markersMaxCount: 0,
                isTodayHighlighted: false,
              ),
              daysOfWeekHeight: 32,
              onDaySelected: (selectedDay, focusedDay) =>
                  viewModel.onDaySelected(selectedDay, focusedDay),
              selectedDayPredicate: (day) => isSameDay(day, state.selectedDay),
              onPageChanged: viewModel.onPageChanged,
              calendarBuilders: CalendarBuilders<CalendarEvent>(
                dowBuilder: (context, day) {
                  final text = () {
                    switch (day.weekday) {
                      case DateTime.saturday:
                        return '土';
                      case DateTime.sunday:
                        return '日';
                      case DateTime.monday:
                        return '月';
                      case DateTime.tuesday:
                        return '火';
                      case DateTime.wednesday:
                        return '水';
                      case DateTime.thursday:
                        return '木';
                      case DateTime.friday:
                        return '金';
                      default:
                        return '';
                    }
                  }();

                  final color = () {
                    switch (day.weekday) {
                      case DateTime.saturday:
                        return Colors.blue;
                      case DateTime.sunday:
                        return Colors.red;
                      default:
                        return Theme.of(context).textTheme.bodyLarge?.color;
                    }
                  }();

                  return Center(
                    child: Text(
                      text,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  );
                },
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
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  headerFormatter.format(state.selectedDay),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                IconButton(
                  icon: const Icon(Icons.settings),
                  tooltip: 'カレンダー設定',
                  onPressed: () => viewModel.openCalendarSettings(),
                  padding: EdgeInsets.zero,
                  constraints:
                      const BoxConstraints.tightFor(width: 32, height: 32),
                  splashRadius: 16,
                ),
              ],
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

class _AppBarIconButton extends StatelessWidget {
  const _AppBarIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, color: Colors.white),
      tooltip: tooltip,
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints.tightFor(width: 28, height: 28),
      splashRadius: 16,
    );
  }
}
