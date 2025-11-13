/// カレンダーの表示設定を表すドメインエンティティ
class CalendarSettings {
  const CalendarSettings({
    required this.startingDayOfWeek,
  });

  /// 週の開始曜日（月曜始まり: true, 日曜始まり: false）
  final bool startingDayOfWeek;

  CalendarSettings copyWith({
    bool? startingDayOfWeek,
  }) {
    return CalendarSettings(
      startingDayOfWeek: startingDayOfWeek ?? this.startingDayOfWeek,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CalendarSettings &&
        other.startingDayOfWeek == startingDayOfWeek;
  }

  @override
  int get hashCode => startingDayOfWeek.hashCode;

  @override
  String toString() {
    return 'CalendarSettings(startingDayOfWeek: $startingDayOfWeek)';
  }
}
