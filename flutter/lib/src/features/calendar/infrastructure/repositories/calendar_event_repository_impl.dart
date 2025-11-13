import 'dart:async';

import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/calendar_event_repository.dart';
import '../sources/calendar_event_firestore_data_source.dart';

class CalendarEventRepositoryImpl implements CalendarEventRepository {
  CalendarEventRepositoryImpl(
      {required CalendarEventFirestoreDataSource remote})
      : _remote = remote;

  final CalendarEventFirestoreDataSource _remote;

  // メモリキャッシュ
  final Map<String, StreamController<List<CalendarEvent>>> _streamControllers =
      {};
  final Map<String, List<CalendarEvent>> _cachedEvents = {};
  final Map<String, StreamSubscription> _subscriptions = {};

  @override
  Future<void> createEvent({
    required String householdId,
    required String title,
    String memo = '',
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconKey,
  }) {
    return _remote.createEvent(
      householdId: householdId,
      title: title,
      memo: memo,
      allDay: allDay,
      start: start,
      end: end,
      iconKey: iconKey,
    );
  }

  @override
  Future<void> updateEvent({
    required String eventId,
    required String householdId,
    required String title,
    String memo = '',
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconKey,
  }) {
    return _remote.updateEvent(
      eventId: eventId,
      householdId: householdId,
      title: title,
      memo: memo,
      allDay: allDay,
      start: start,
      end: end,
      iconKey: iconKey,
    );
  }

  @override
  Future<void> deleteEvent({
    required String eventId,
    required String householdId,
    required DateTime eventDate,
  }) {
    return _remote.deleteEvent(
      eventId: eventId,
      householdId: householdId,
      eventDate: eventDate,
    );
  }

  @override
  Stream<List<CalendarEvent>> watchEvents({
    required String householdId,
    required DateTime start,
    required DateTime end,
  }) {
    final cacheKey =
        '${householdId}_${start.toIso8601String()}_${end.toIso8601String()}';

    // 既存のストリームコントローラーがある場合はそれを返す
    if (_streamControllers.containsKey(cacheKey)) {
      final controller = _streamControllers[cacheKey]!;
      if (!controller.isClosed) {
        // キャッシュされたデータがあれば即座に送信
        final cachedData = _cachedEvents[cacheKey];
        if (cachedData != null) {
          controller.add(cachedData);
        }
        return controller.stream;
      }
    }

    // 新しいストリームコントローラーを作成
    final controller = StreamController<List<CalendarEvent>>.broadcast();
    _streamControllers[cacheKey] = controller;

    // リモートデータソースからのストリームを購読
    final subscription = _remote
        .watchEvents(
      householdId: householdId,
      start: start,
      end: end,
    )
        .listen(
      (events) {
        _cachedEvents[cacheKey] = events;
        if (!controller.isClosed) {
          controller.add(events);
        }
      },
      onError: (error) {
        if (!controller.isClosed) {
          controller.addError(error);
        }
      },
    );

    _subscriptions[cacheKey] = subscription;

    // コントローラーが閉じられたときのクリーンアップ
    controller.onCancel = () {
      _subscriptions[cacheKey]?.cancel();
      _subscriptions.remove(cacheKey);
      _streamControllers.remove(cacheKey);
      _cachedEvents.remove(cacheKey);
    };

    return controller.stream;
  }

  void dispose() {
    for (final subscription in _subscriptions.values) {
      subscription.cancel();
    }
    for (final controller in _streamControllers.values) {
      controller.close();
    }
    _subscriptions.clear();
    _streamControllers.clear();
    _cachedEvents.clear();
  }
}
