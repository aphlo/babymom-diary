import '../../domain/repositories/calendar_event_repository.dart';

class UpdateCalendarEvent {
  const UpdateCalendarEvent(this._repository);

  final CalendarEventRepository _repository;

  Future<void> call({
    required String eventId,
    required String householdId,
    required String title,
    String memo = '',
    required bool allDay,
    required DateTime start,
    required DateTime end,
    required String iconKey,
  }) {
    return _repository.updateEvent(
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
}
