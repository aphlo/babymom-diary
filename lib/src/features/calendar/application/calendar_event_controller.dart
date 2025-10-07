import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/calendar/application/usecases/add_calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/data/repositories/calendar_event_repository_impl.dart';
import 'package:babymom_diary/src/features/calendar/data/sources/calendar_event_firestore_data_source.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/domain/repositories/calendar_event_repository.dart';

import '../../children/application/children_local_provider.dart';
import '../../children/domain/entities/child_summary.dart';
import '../../../core/firebase/household_service.dart' as fbcore;

final _firebaseFirestoreProvider = Provider<FirebaseFirestore>(
  (ref) => ref.watch(fbcore.firebaseFirestoreProvider),
);

final _calendarEventRemoteDataSourceProvider =
    Provider<CalendarEventFirestoreDataSource>((ref) {
  final firestore = ref.watch(_firebaseFirestoreProvider);
  return CalendarEventFirestoreDataSource(firestore);
});

final calendarEventRepositoryProvider =
    Provider<CalendarEventRepository>((ref) {
  final remote = ref.watch(_calendarEventRemoteDataSourceProvider);
  return CalendarEventRepositoryImpl(remote: remote);
});

final addCalendarEventUseCaseProvider = Provider<AddCalendarEvent>(
  (ref) => AddCalendarEvent(ref.watch(calendarEventRepositoryProvider)),
);

final selectedCalendarDateProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
});

final focusedCalendarMonthProvider = StateProvider<DateTime>((ref) {
  final selected = ref.watch(selectedCalendarDateProvider);
  return DateTime(selected.year, selected.month);
});

final calendarVisibleRangeProvider =
    Provider<({DateTime start, DateTime end})>((ref) {
  final month = ref.watch(focusedCalendarMonthProvider);
  return _visibleRangeForMonth(month);
});

final calendarEventsProvider =
    StreamProvider.autoDispose<List<CalendarEvent>>((ref) async* {
  final range = ref.watch(calendarVisibleRangeProvider);
  final householdId = await ref.watch(fbcore.currentHouseholdIdProvider.future);
  final repo = ref.watch(calendarEventRepositoryProvider);

  final childrenState = ref.watch(childrenLocalProvider(householdId));
  final childMap = _mapById(childrenState.value);

  yield* repo
      .watchEvents(
    householdId: householdId,
    start: range.start,
    end: range.end,
  )
      .map((events) {
    if (childMap.isEmpty) return events;
    return events.map((event) {
      final child = childMap[event.childId];
      if (child == null) return event;
      return event.copyWith(
        childName: child.name,
        childColorHex: child.color,
      );
    }).toList();
  });
});

final eventsForSelectedDateProvider = Provider<List<CalendarEvent>>((ref) {
  final selectedDate = ref.watch(selectedCalendarDateProvider);
  final eventsAsync = ref.watch(calendarEventsProvider);

  return eventsAsync.when(
    data: (events) {
      final filtered = events
          .where((event) => event.occursOn(selectedDate))
          .toList()
        ..sort((a, b) => a.start.compareTo(b.start));
      return filtered;
    },
    loading: () => const [],
    error: (_, __) => const [],
  );
});

({DateTime start, DateTime end}) _visibleRangeForMonth(DateTime monthLocal) {
  final first = DateTime(monthLocal.year, monthLocal.month, 1);
  final weekday = (first.weekday + 6) % 7; // 月曜始まり
  final start = first.subtract(Duration(days: weekday));
  final end = start.add(const Duration(days: 42)); // 半開区間
  return (start: start, end: end);
}

Map<String, ChildSummary> _mapById(List<ChildSummary>? children) {
  if (children == null || children.isEmpty) return const {};
  return {
    for (final child in children) child.id: child,
  };
}
