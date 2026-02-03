import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notification_settings.dart';

part 'notification_settings_dto.freezed.dart';
part 'notification_settings_dto.g.dart';

@freezed
sealed class NotificationSettingsDto with _$NotificationSettingsDto {
  const NotificationSettingsDto._();

  const factory NotificationSettingsDto({
    required VaccineReminderSettingsDto vaccineReminder,
    required DailyEncouragementSettingsDto dailyEncouragement,
    @TimestampConverter() required DateTime createdAt,
    @TimestampConverter() required DateTime updatedAt,
  }) = _NotificationSettingsDto;

  factory NotificationSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$NotificationSettingsDtoFromJson(json);

  factory NotificationSettingsDto.fromEntity(NotificationSettings entity) {
    return NotificationSettingsDto(
      vaccineReminder:
          VaccineReminderSettingsDto.fromEntity(entity.vaccineReminder),
      dailyEncouragement:
          DailyEncouragementSettingsDto.fromEntity(entity.dailyEncouragement),
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  NotificationSettings toEntity() {
    return NotificationSettings(
      vaccineReminder: vaccineReminder.toEntity(),
      dailyEncouragement: dailyEncouragement.toEntity(),
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}

@freezed
sealed class VaccineReminderSettingsDto with _$VaccineReminderSettingsDto {
  const VaccineReminderSettingsDto._();

  const factory VaccineReminderSettingsDto({
    required bool enabled,
    required List<int> daysBefore,
  }) = _VaccineReminderSettingsDto;

  factory VaccineReminderSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$VaccineReminderSettingsDtoFromJson(json);

  factory VaccineReminderSettingsDto.fromEntity(
      VaccineReminderSettings entity) {
    return VaccineReminderSettingsDto(
      enabled: entity.enabled,
      daysBefore: entity.daysBefore,
    );
  }

  VaccineReminderSettings toEntity() {
    return VaccineReminderSettings(
      enabled: enabled,
      daysBefore: daysBefore,
    );
  }
}

@freezed
sealed class DailyEncouragementSettingsDto
    with _$DailyEncouragementSettingsDto {
  const DailyEncouragementSettingsDto._();

  const factory DailyEncouragementSettingsDto({
    required bool enabled,
  }) = _DailyEncouragementSettingsDto;

  factory DailyEncouragementSettingsDto.fromJson(Map<String, dynamic> json) =>
      _$DailyEncouragementSettingsDtoFromJson(json);

  factory DailyEncouragementSettingsDto.fromEntity(
      DailyEncouragementSettings entity) {
    return DailyEncouragementSettingsDto(
      enabled: entity.enabled,
    );
  }

  DailyEncouragementSettings toEntity() {
    return DailyEncouragementSettings(
      enabled: enabled,
    );
  }
}

class TimestampConverter implements JsonConverter<DateTime, Timestamp> {
  const TimestampConverter();

  @override
  DateTime fromJson(Timestamp timestamp) => timestamp.toDate();

  @override
  Timestamp toJson(DateTime date) => Timestamp.fromDate(date);
}
