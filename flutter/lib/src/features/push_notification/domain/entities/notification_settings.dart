import 'package:freezed_annotation/freezed_annotation.dart';

part 'notification_settings.freezed.dart';

@freezed
sealed class NotificationSettings with _$NotificationSettings {
  const NotificationSettings._();

  const factory NotificationSettings({
    required VaccineReminderSettings vaccineReminder,
    required DailyEncouragementSettings dailyEncouragement,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) = _NotificationSettings;

  factory NotificationSettings.defaultSettings() {
    final now = DateTime.now();
    return NotificationSettings(
      vaccineReminder: const VaccineReminderSettings(
        enabled: true,
        daysBefore: [0, 1],
      ),
      dailyEncouragement: const DailyEncouragementSettings(enabled: true),
      createdAt: now,
      updatedAt: now,
    );
  }
}

@freezed
sealed class VaccineReminderSettings with _$VaccineReminderSettings {
  const factory VaccineReminderSettings({
    required bool enabled,
    required List<int> daysBefore,
  }) = _VaccineReminderSettings;
}

@freezed
sealed class DailyEncouragementSettings with _$DailyEncouragementSettings {
  const factory DailyEncouragementSettings({
    required bool enabled,
  }) = _DailyEncouragementSettings;
}
