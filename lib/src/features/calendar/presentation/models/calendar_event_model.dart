class CalendarEventModel {
  const CalendarEventModel({
    required this.childId,
    required this.title,
    required this.memo,
    required this.allDay,
    required this.start,
    required this.end,
    required this.iconPath,
  });

  final String childId;
  final String title;
  final String memo;
  final bool allDay;
  final DateTime start;
  final DateTime end;
  final String iconPath;
}
