import 'package:freezed_annotation/freezed_annotation.dart';

part 'calendar_settings.freezed.dart';

/// カレンダーの表示設定を表すドメインエンティティ
@freezed
sealed class CalendarSettings with _$CalendarSettings {
  const factory CalendarSettings({
    /// 週の開始曜日（月曜始まり: true, 日曜始まり: false）
    required bool startingDayOfWeek,
  }) = _CalendarSettings;
}
