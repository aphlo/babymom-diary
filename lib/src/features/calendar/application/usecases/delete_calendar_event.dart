import '../../domain/repositories/calendar_event_repository.dart';

class DeleteCalendarEvent {
  const DeleteCalendarEvent(this._repository);

  final CalendarEventRepository _repository;

  Future<void> call({
    required String eventId,
    required String householdId,
  }) {
    return _repository.deleteEvent(
      eventId: eventId,
      householdId: householdId,
    );
  }
}
