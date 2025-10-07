import '../../domain/repositories/calendar_event_repository.dart';

class AddCalendarEvent {
  const AddCalendarEvent(this._repository);

  final CalendarEventRepository _repository;

  Future<void> call({
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
    return _repository.createEvent(
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
}
