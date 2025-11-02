import '../../domain/entities/calendar_event.dart';
import '../../presentation/models/calendar_event_model.dart';
import '../../../vaccines/domain/entities/vaccination_schedule.dart';

class VaccinationToCalendarEventMapper {
  /// VaccinationScheduleをCalendarEventに変換
  static CalendarEvent toCalendarEvent(VaccinationSchedule schedule) {
    return CalendarEvent(
      id: 'vaccination_${schedule.childId}_${schedule.vaccineId}_${schedule.doseNumber}',
      title: schedule.displayTitle,
      memo: '${schedule.vaccineName}の${schedule.doseNumber}回目の接種予定です',
      allDay: true, // ワクチン予約は終日イベントとして表示
      start: schedule.scheduledDate,
      end: schedule.scheduledDate,
      iconPath: schedule.iconPath,
    );
  }

  /// VaccinationScheduleをCalendarEventModelに変換
  static CalendarEventModel toCalendarEventModel(VaccinationSchedule schedule) {
    return CalendarEventModel(
      title: schedule.displayTitle,
      memo: '${schedule.vaccineName}の${schedule.doseNumber}回目の接種予定です',
      allDay: true,
      start: schedule.scheduledDate,
      end: schedule.scheduledDate,
      iconPath: schedule.iconPath,
      type: CalendarEventType.vaccination,
      vaccinationData: VaccinationEventData(
        childId: schedule.childId,
        vaccineId: schedule.vaccineId,
        doseNumber: schedule.doseNumber,
      ),
    );
  }

  /// 複数のVaccinationScheduleをCalendarEventのリストに変換
  static List<CalendarEvent> toCalendarEvents(
      List<VaccinationSchedule> schedules) {
    return schedules.map(toCalendarEvent).toList();
  }

  /// 複数のVaccinationScheduleをCalendarEventModelのリストに変換
  static List<CalendarEventModel> toCalendarEventModels(
      List<VaccinationSchedule> schedules) {
    return schedules.map(toCalendarEventModel).toList();
  }
}
