import '../entities/calendar_event.dart';

abstract class CalendarEventRepository {
  Stream<List<CalendarEvent>> watchEvents({
    required String householdId,
    required DateTime start,
    required DateTime end,
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
