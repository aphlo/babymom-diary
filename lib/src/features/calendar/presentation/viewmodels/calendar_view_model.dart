import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:babymom_diary/src/features/calendar/application/calendar_event_controller.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_event.dart';
import 'package:babymom_diary/src/features/calendar/domain/entities/calendar_settings.dart';
import 'package:babymom_diary/src/features/calendar/domain/repositories/calendar_event_repository.dart';
import 'package:babymom_diary/src/features/calendar/domain/repositories/calendar_settings_repository.dart';
import 'package:babymom_diary/src/features/calendar/infrastructure/repositories/calendar_settings_repository_impl.dart';
import 'package:babymom_diary/src/features/calendar/presentation/models/calendar_event_model.dart';
import 'package:babymom_diary/src/features/calendar/presentation/viewmodels/calendar_state.dart';
import 'package:babymom_diary/src/features/children/application/children_local_provider.dart';
import 'package:babymom_diary/src/features/children/application/selected_child_provider.dart';
import 'package:babymom_diary/src/features/children/application/selected_child_snapshot_provider.dart';
import 'package:babymom_diary/src/features/children/domain/entities/child_summary.dart';
import 'package:babymom_diary/src/core/firebase/household_service.dart'
    as fbcore;

final calendarViewModelProvider =
    AutoDisposeStateNotifierProvider<CalendarViewModel, CalendarState>(
  (ref) {
    final repository = ref.watch(calendarEventRepositoryProvider);
    final settingsRepository = ref.watch(calendarSettingsRepositoryProvider);
    return CalendarViewModel(ref, repository, settingsRepository);
  },
);

class CalendarViewModel extends StateNotifier<CalendarState> {
  CalendarViewModel(
    this._ref,
    this._repository,
    this._settingsRepository,
  ) : super(CalendarState.initial()) {
    _initialize();
    _ref.onDispose(() {
      _eventsSubscription?.cancel();
      _settingsSubscription?.cancel();
      _eventsSubscription = null;
      _settingsSubscription = null;
    });
  }

  final Ref _ref;
  final CalendarEventRepository _repository;
  final CalendarSettingsRepository _settingsRepository;

  StreamSubscription<List<CalendarEvent>>? _eventsSubscription;
  StreamSubscription<CalendarSettings>? _settingsSubscription;
  List<CalendarEvent> _latestEvents = const <CalendarEvent>[];
  List<ChildSummary> _localChildren = const <ChildSummary>[];
  ChildSummary? _snapshotChild;

  void _initialize() {
    _listenToSelectedChild();
    _listenToCalendarSettings();
    _loadHouseholdId();
  }

  Future<void> _loadHouseholdId() async {
    try {
      final householdId =
          await _ref.read(fbcore.currentHouseholdIdProvider.future);
      state = state.copyWith(householdId: householdId);
      _subscribeToChildren(householdId);
      _refreshEventsSubscription();
    } catch (error, stackTrace) {
      state = state.copyWith(
        pendingUiEvent: const CalendarUiEvent.showMessage('世帯情報の取得に失敗しました'),
      );
      state = state.copyWith(
        eventsAsync: AsyncValue.error(error, stackTrace),
      );
    }
  }

  void _listenToSelectedChild() {
    _ref.listen<AsyncValue<String?>>(
      selectedChildControllerProvider,
      (previous, next) {
        final value = next.valueOrNull;
        if (state.selectedChildId == value) {
          return;
        }
        state = state.copyWith(selectedChildId: value, pendingUiEvent: null);
      },
      fireImmediately: true,
    );
  }

  void _listenToCalendarSettings() {
    _settingsSubscription = _settingsRepository.watchSettings().listen(
      (settings) {
        state =
            state.copyWith(calendarSettings: settings, pendingUiEvent: null);
      },
      onError: (error) {
        // エラーが発生した場合はデフォルト設定を使用
        state = state.copyWith(
          calendarSettings: const CalendarSettings(startingDayOfWeek: false),
          pendingUiEvent: null,
        );
      },
    );
  }

  void _subscribeToChildren(String householdId) {
    _ref.listen<AsyncValue<List<ChildSummary>>>(
      childrenLocalProvider(householdId),
      (previous, next) {
        final value = next.valueOrNull ?? const <ChildSummary>[];
        _localChildren = value;
        _rebuildAvailableChildren();
      },
      fireImmediately: true,
    );

    _ref.listen<AsyncValue<ChildSummary?>>(
      selectedChildSnapshotProvider(householdId),
      (previous, next) {
        _snapshotChild = next.valueOrNull;
        _rebuildAvailableChildren();
      },
      fireImmediately: true,
    );
  }

  void _rebuildAvailableChildren() {
    final List<ChildSummary> available =
        List<ChildSummary>.from(_localChildren);
    final snapshot = _snapshotChild;
    if (snapshot != null &&
        snapshot.id.isNotEmpty &&
        !available.any((child) => child.id == snapshot.id)) {
      available.add(snapshot);
    }
    state = state.copyWith(
      availableChildren: available,
      pendingUiEvent: null,
    );
    _updateEventsState(_latestEvents);
  }

  void _refreshEventsSubscription() {
    _eventsSubscription?.cancel();
    final householdId = state.householdId;
    if (householdId == null) {
      return;
    }
    final range = _visibleRangeForMonth(state.focusedDay);
    state = state.copyWith(eventsAsync: const AsyncValue.loading());

    // ストリームにデバウンス機能を追加してパフォーマンスを向上
    _eventsSubscription = _repository
        .watchEvents(
          householdId: householdId,
          start: range.start,
          end: range.end,
        )
        .distinct() // 重複する更新を除去
        .listen(
      (events) {
        _latestEvents = events;
        _updateEventsState(events);
      },
      onError: (error, stackTrace) {
        state = state.copyWith(
          eventsAsync: AsyncValue.error(error, stackTrace),
          pendingUiEvent: const CalendarUiEvent.showMessage(
            '予定の取得に失敗しました',
          ),
        );
      },
    );
  }

  void _updateEventsState(List<CalendarEvent> events) {
    final eventsByDay = _groupEventsByDay(events);

    // ローディング状態の場合は常に更新する
    // または状態が実際に変更された場合のみ更新
    final currentEvents = state.eventsAsync.valueOrNull ?? [];
    final isLoading = state.eventsAsync.isLoading;
    final hasChanged = events.length != currentEvents.length ||
        !_eventsEqual(events, currentEvents);

    if (isLoading || hasChanged) {
      state = state.copyWith(
        eventsAsync: AsyncValue.data(events),
        eventsByDay: eventsByDay,
        pendingUiEvent: null,
      );
    }
  }

  bool _eventsEqual(List<CalendarEvent> a, List<CalendarEvent> b) {
    if (a.length != b.length) return false;
    final aIds = a.map((e) => e.id).toSet();
    final bIds = b.map((e) => e.id).toSet();
    return aIds.difference(bIds).isEmpty && bIds.difference(aIds).isEmpty;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final normalizedSelected = _normalizeDate(selectedDay);
    final normalizedFocused = _normalizeDate(focusedDay);
    final requiresRefresh = normalizedFocused.year != state.focusedDay.year ||
        normalizedFocused.month != state.focusedDay.month;
    state = state.copyWith(
      selectedDay: normalizedSelected,
      focusedDay: normalizedFocused,
      pendingUiEvent: null,
    );
    if (requiresRefresh) {
      _refreshEventsSubscription();
    }
  }

  void onPageChanged(DateTime focusedDay) {
    final normalizedFocused = _normalizeDate(
      DateTime(focusedDay.year, focusedDay.month),
    );
    final requiresRefresh = normalizedFocused.year != state.focusedDay.year ||
        normalizedFocused.month != state.focusedDay.month;
    if (!requiresRefresh) {
      return;
    }
    state = state.copyWith(
      focusedDay: normalizedFocused,
      selectedDay: normalizedFocused,
      pendingUiEvent: null,
    );
    _refreshEventsSubscription();
  }

  void goToPreviousMonth() {
    final currentMonth =
        DateTime(state.focusedDay.year, state.focusedDay.month);
    final previousMonth = DateTime(currentMonth.year, currentMonth.month - 1);
    final normalizedPrevious = _normalizeDate(previousMonth);

    state = state.copyWith(
      focusedDay: normalizedPrevious,
      selectedDay: normalizedPrevious,
      pendingUiEvent: null,
    );
    _refreshEventsSubscription();
  }

  void goToNextMonth() {
    final currentMonth =
        DateTime(state.focusedDay.year, state.focusedDay.month);
    final nextMonth = DateTime(currentMonth.year, currentMonth.month + 1);
    final normalizedNext = _normalizeDate(nextMonth);

    state = state.copyWith(
      focusedDay: normalizedNext,
      selectedDay: normalizedNext,
      pendingUiEvent: null,
    );
    _refreshEventsSubscription();
  }

  void clearUiEvent() {
    if (state.pendingUiEvent == null) {
      return;
    }
    state = state.copyWith(pendingUiEvent: null);
  }

  void requestAddEvent() {
    final householdId = state.householdId;
    if (householdId == null) {
      state = state.copyWith(
        pendingUiEvent: const CalendarUiEvent.showMessage('世帯情報を取得できませんでした'),
      );
      return;
    }
    final children = state.availableChildren;
    if (children.isEmpty) {
      state = state.copyWith(
        pendingUiEvent: const CalendarUiEvent.showMessage('先に子どもを登録してください'),
      );
      return;
    }
    final request = AddEventRequest(
      initialDate: state.selectedDay,
      children: children,
      initialChildId: state.selectedChildId,
    );
    state = state.copyWith(
      pendingUiEvent: CalendarUiEvent.openAddEvent(request),
    );
  }

  void openCalendarSettings() {
    state = state.copyWith(
      pendingUiEvent: const CalendarUiEvent.openSettings(),
    );
  }

  Future<void> handleAddEventResult(CalendarEventModel result) async {
    final householdId = state.householdId;
    if (householdId == null) {
      state = state.copyWith(
        pendingUiEvent: const CalendarUiEvent.showMessage('世帯情報が存在しません'),
      );
      return;
    }

    try {
      await _repository.createEvent(
        householdId: householdId,
        title: result.title,
        memo: result.memo,
        allDay: result.allDay,
        start: result.start,
        end: result.end,
        iconKey: result.iconPath,
      );
      state = state.copyWith(
        pendingUiEvent: const CalendarUiEvent.showMessage('予定を保存しました'),
      );
    } catch (error) {
      state = state.copyWith(
        pendingUiEvent: CalendarUiEvent.showMessage(
          '予定の保存に失敗しました: $error',
        ),
      );
    }
  }

  static Map<DateTime, List<CalendarEvent>> _groupEventsByDay(
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
        final key = DateTime(cursor.year, cursor.month, cursor.day);
        map.putIfAbsent(key, () => <CalendarEvent>[]).add(event);
        cursor = cursor.add(const Duration(days: 1));
      }
    }
    for (final entry in map.entries) {
      entry.value.sort((a, b) => a.start.compareTo(b.start));
    }
    return map;
  }

  static DateTime _normalizeDate(DateTime date) =>
      DateTime(date.year, date.month, date.day);

  static ({DateTime start, DateTime end}) _visibleRangeForMonth(DateTime day) {
    final firstOfMonth = DateTime(day.year, day.month, 1);
    final weekday = (firstOfMonth.weekday + 6) % 7;
    final start = firstOfMonth.subtract(Duration(days: weekday));
    final end = start.add(const Duration(days: 42));
    return (start: start, end: end);
  }
}
