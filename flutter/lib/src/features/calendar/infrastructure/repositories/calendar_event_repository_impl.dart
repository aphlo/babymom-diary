import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/calendar_event_repository.dart';
import '../sources/calendar_event_firestore_data_source.dart';

class CalendarEventRepositoryImpl implements CalendarEventRepository {
  CalendarEventRepositoryImpl(
      {required CalendarEventFirestoreDataSource remote})
      : _remote = remote;

  final CalendarEventFirestoreDataSource _remote;

  @override
  Future<List<CalendarEvent>> getEvents({
    required String householdId,
    required DateTime start,
    required DateTime end,
  }) {
    return _remote.getEvents(
      householdId: householdId,
      start: start,
      end: end,
    );
  }

  @override
  Stream<List<CalendarEvent>> watchEventsForDate({
    required String householdId,
    required DateTime date,
  }) {
    return _remote.watchEventsForDate(
      householdId: householdId,
      date: date,
    );
  }

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
}
