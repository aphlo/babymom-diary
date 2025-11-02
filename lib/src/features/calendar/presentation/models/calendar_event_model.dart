enum CalendarEventType { regular, vaccination }

class CalendarEventModel {
  const CalendarEventModel({
    required this.title,
    required this.memo,
    required this.allDay,
    required this.start,
    required this.end,
    required this.iconPath,
    this.type = CalendarEventType.regular,
    this.vaccinationData,
  });

  final String title;
  final String memo;
  final bool allDay;
  final DateTime start;
  final DateTime end;
  final String iconPath;
  final CalendarEventType type;
  final VaccinationEventData? vaccinationData;

  bool get isVaccination => type == CalendarEventType.vaccination;
}

class VaccinationEventData {
  const VaccinationEventData({
    required this.childId,
    required this.vaccineId,
    required this.doseNumber,
  });

  final String childId;
  final String vaccineId;
  final int doseNumber;
}
