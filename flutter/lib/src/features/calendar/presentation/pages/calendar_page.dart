import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:holiday_jp/holiday_jp.dart' as holiday_jp;
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import 'package:babymom_diary/src/core/theme/app_colors.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/presentation/models/calendar_event_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/pages/calendar_settings_page.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/calendar_state.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/calendar_view_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/calendar_day_cell.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/calendar_error_banner.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/calendar_error_view.dart';
import 'package:babymom_diary/src/features/calendar/presentation/widgets/selected_day_event_list.dart';
import 'package:babymom_diary/src/features/vaccines/domain/entities/dose_record.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_category.dart';
import 'package:babymom_diary/src/features/vaccines/domain/value_objects/vaccine_requirement.dart';
import 'package:babymom_diary/src/features/vaccines/presentation/models/vaccine_info.dart';
import 'package:babymom_diary/src/features/vaccines/presentation/viewmodels/vaccine_detail_state.dart';

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
        final router = GoRouter.of(context);
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
          if (!mounted) {
            return;
          }
          final result = await router.push<CalendarEventModel>(
            '/calendar/add',
            extra: request.initialDate,
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
              sixWeekMonthsEnforced: true,
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
                  final isHoliday = holiday_jp.isHoliday(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: isSameDay(day, state.selectedDay),
                    isOutside: false,
                    isHoliday: isHoliday,
                  );
                },
                todayBuilder: (context, day, focusedDay) {
                  final events = state.eventsForDay(day);
                  final isHoliday = holiday_jp.isHoliday(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: true,
                    isSelected: isSameDay(day, state.selectedDay),
                    isOutside: false,
                    isHoliday: isHoliday,
                  );
                },
                selectedBuilder: (context, day, focusedDay) {
                  final events = state.eventsForDay(day);
                  final isHoliday = holiday_jp.isHoliday(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: true,
                    isOutside: false,
                    isHoliday: isHoliday,
                  );
                },
                outsideBuilder: (context, day, focusedDay) {
                  final events = state.eventsForDay(day);
                  final isHoliday = holiday_jp.isHoliday(day);
                  return CalendarDayCell(
                    day: day,
                    events: events,
                    isToday: isSameDay(day, DateTime.now()),
                    isSelected: isSameDay(day, state.selectedDay),
                    isOutside: true,
                    isHoliday: isHoliday,
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
                Expanded(
                  child: Builder(
                    builder: (context) {
                      final holiday = holiday_jp.getHoliday(state.selectedDay);
                      return FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          children: [
                            Text(
                              headerFormatter.format(state.selectedDay),
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            if (holiday != null) ...[
                              const SizedBox(width: 8),
                              Text(
                                '(${holiday.name})',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.red,
                                    ),
                              ),
                            ],
                          ],
                        ),
                      );
                    },
                  ),
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
                    onEventTap: (event) => _handleEventTap(context, event),
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'calendar_fab',
        onPressed: viewModel.requestAddEvent,
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _handleEventTap(BuildContext context, CalendarEvent event) {
    // ワクチン予約イベントの場合はワクチン予約ページに遷移
    if (event.id.startsWith('vaccination_')) {
      _handleVaccinationEventTap(context, event);
      return;
    }

    // 通常のイベントの場合は編集ページに遷移
    context.push('/calendar/edit', extra: event).then((result) {
      // 編集・削除が成功した場合は月間データを再取得
      if (result == true) {
        ref.read(calendarViewModelProvider.notifier).refreshMonthlyEvents();
      }
    });
  }

  void _handleVaccinationEventTap(BuildContext context, CalendarEvent event) {
    final viewModel = ref.read(calendarViewModelProvider.notifier);
    final match = viewModel.findScheduledDoseByEventId(event.id);

    if (match == null || match.dose.scheduledDate == null) {
      _showCalendarSnack(context, '予約情報が見つかりませんでした');
      return;
    }

    final record = match.record;
    final doseRecord = match.dose;

    final vaccine = VaccineInfo(
      id: record.vaccineId,
      name: record.vaccineName,
      category: _mapVaccineCategory(record.category),
      requirement: _mapVaccineRequirement(record.requirement),
    );

    final statusInfo = DoseStatusInfo(
      doseNumber: match.doseNumber,
      status: doseRecord.status,
      scheduledDate: doseRecord.scheduledDate,
      reservationGroupId: doseRecord.reservationGroupId,
    );

    // 接種済みの場合は詳細ページへ、予約済みの場合は予約変更ページへ
    if (doseRecord.status == DoseStatus.completed) {
      context.push('/vaccines/scheduled-details', extra: {
        'vaccine': vaccine,
        'doseNumber': match.doseNumber,
        'statusInfo': statusInfo,
      });
    } else {
      context.pushNamed(
        'vaccine_reschedule',
        extra: {
          'vaccine': vaccine,
          'doseNumber': match.doseNumber,
          'statusInfo': statusInfo,
        },
      );
    }
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

VaccineCategory _mapVaccineCategory(
  VaccineCategory category,
) {
  switch (category) {
    case VaccineCategory.live:
      return VaccineCategory.live;
    case VaccineCategory.inactivated:
      return VaccineCategory.inactivated;
  }
}

VaccineRequirement _mapVaccineRequirement(
  VaccineRequirement requirement,
) {
  switch (requirement) {
    case VaccineRequirement.mandatory:
      return VaccineRequirement.mandatory;
    case VaccineRequirement.optional:
      return VaccineRequirement.optional;
  }
}

void _showCalendarSnack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}
