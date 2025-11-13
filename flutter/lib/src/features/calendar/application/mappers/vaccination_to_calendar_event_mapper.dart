import '../../domain/entities/calendar_event.dart';
import '../../presentation/models/calendar_event_model.dart';
import '../../../vaccines/domain/entities/vaccination_record.dart';

/// VaccinationRecordからCalendarEventに変換するマッパー
/// VaccinationScheduleは廃止され、VaccinationRecordから直接カレンダーイベントを生成
class VaccinationToCalendarEventMapper {
  /// VaccinationRecordのリストからCalendarEventのリストに変換
  static List<CalendarEvent> toCalendarEvents(
    List<VaccinationRecord> records,
    String childId,
  ) {
    return records
        .expand((record) => record.toCalendarEvents(childId))
        .toList();
  }

  /// VaccinationRecordのリストからCalendarEventModelのリストに変換
  static List<CalendarEventModel> toCalendarEventModels(
    List<VaccinationRecord> records,
    String childId,
  ) {
    return records
        .expand((record) => record.toCalendarEvents(childId))
        .map((event) => CalendarEventModel(
              title: event.title,
              memo: event.memo,
              allDay: event.allDay,
              start: event.start,
              end: event.end,
              iconPath: event.iconPath,
              type: CalendarEventType.vaccination,
              vaccinationData: VaccinationEventData(
                childId: childId,
                vaccineId: _extractVaccineId(event.id),
                doseNumber: _extractDoseNumber(event.title),
              ),
            ))
        .toList();
  }

  /// イベントIDからワクチンIDを抽出
  static String _extractVaccineId(String eventId) {
    // vaccination_${childId}_${vaccineId}_${doseNumber} の形式
    final parts = eventId.split('_');
    if (parts.length >= 3) {
      return parts[2];
    }
    return '';
  }

  /// タイトルから接種回数を抽出
  static int _extractDoseNumber(String title) {
    // "${vaccineName} ${doseNumber}回目" の形式
    final match = RegExp(r'(\d+)回目').firstMatch(title);
    if (match != null) {
      return int.tryParse(match.group(1) ?? '1') ?? 1;
    }
    return 1;
  }
}
