import '../../domain/entities/calendar_event.dart';
import '../../domain/repositories/calendar_event_repository.dart';
import '../sources/calendar_event_firestore_data_source.dart';

class CalendarEventRepositoryImpl implements CalendarEventRepository {
  CalendarEventRepositoryImpl(
      {required CalendarEventFirestoreDataSource remote})
      : _remote = remote;

  final CalendarEventFirestoreDataSource _remote;

  @override
  Future<void> createEvent({
    required String householdId,
    required String childId,
    required String title,
    String memo = '',
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconKey,
    String? childName,
    String? childColorHex,
  }) {
    return _remote.createEvent(
      householdId: householdId,
      childId: childId,
      title: title,
      memo: memo,
      allDay: allDay,
      start: start,
      end: end,
      iconKey: iconKey,
      childName: childName,
      childColorHex: childColorHex,
    );
  }

  @override
  Stream<List<CalendarEvent>> watchEvents({
    required String householdId,
    required DateTime start,
    required DateTime end,
  }) {
    return _remote.watchEvents(
      householdId: householdId,
      start: start,
      end: end,
    );
  }
}
