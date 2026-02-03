// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_settings_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationSettingsDto _$NotificationSettingsDtoFromJson(
        Map<String, dynamic> json) =>
    _NotificationSettingsDto(
      vaccineReminder: VaccineReminderSettingsDto.fromJson(
          json['vaccineReminder'] as Map<String, dynamic>),
      dailyEncouragement: DailyEncouragementSettingsDto.fromJson(
          json['dailyEncouragement'] as Map<String, dynamic>),
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp),
      updatedAt:
          const TimestampConverter().fromJson(json['updatedAt'] as Timestamp),
    );

Map<String, dynamic> _$NotificationSettingsDtoToJson(
        _NotificationSettingsDto instance) =>
    <String, dynamic>{
      'vaccineReminder': instance.vaccineReminder,
      'dailyEncouragement': instance.dailyEncouragement,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };

_VaccineReminderSettingsDto _$VaccineReminderSettingsDtoFromJson(
        Map<String, dynamic> json) =>
    _VaccineReminderSettingsDto(
      enabled: json['enabled'] as bool,
      daysBefore: (json['daysBefore'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$VaccineReminderSettingsDtoToJson(
        _VaccineReminderSettingsDto instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
      'daysBefore': instance.daysBefore,
    };

_DailyEncouragementSettingsDto _$DailyEncouragementSettingsDtoFromJson(
        Map<String, dynamic> json) =>
    _DailyEncouragementSettingsDto(
      enabled: json['enabled'] as bool,
    );

Map<String, dynamic> _$DailyEncouragementSettingsDtoToJson(
        _DailyEncouragementSettingsDto instance) =>
    <String, dynamic>{
      'enabled': instance.enabled,
    };
