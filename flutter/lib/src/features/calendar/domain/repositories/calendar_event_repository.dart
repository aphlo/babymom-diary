import '../entities/calendar_event.dart';

abstract class CalendarEventRepository {
  /// 月間イベントを一度だけ取得（リアルタイム更新なし）
  Future<List<CalendarEvent>> getEvents({
    required String householdId,
    required DateTime start,
    required DateTime end,
  });

  /// 特定の日付のイベントをリアルタイムで監視
  Stream<List<CalendarEvent>> watchEventsForDate({
    required String householdId,
    required DateTime date,
  });

  Future<void> createEvent({
    required String householdId,
    required String title,
    String memo,
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconKey,
  });

  Future<void> updateEvent({
    required String eventId,
    required String householdId,
    required String title,
    String memo,
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconKey,
  });

  Future<void> deleteEvent({
    required String eventId,
    required String householdId,
    required DateTime eventDate,
  });
}
