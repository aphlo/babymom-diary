// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_prompt_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReviewPromptState _$ReviewPromptStateFromJson(Map<String, dynamic> json) =>
    _ReviewPromptState(
      recordCount: (json['recordCount'] as num).toInt(),
      appLaunchCount: (json['appLaunchCount'] as num).toInt(),
      hasReviewed: json['hasReviewed'] as bool,
      lastShownDate: json['lastShownDate'] as String?,
      dissatisfiedDate: json['dissatisfiedDate'] as String?,
    );

Map<String, dynamic> _$ReviewPromptStateToJson(_ReviewPromptState instance) =>
    <String, dynamic>{
      'recordCount': instance.recordCount,
      'appLaunchCount': instance.appLaunchCount,
      'hasReviewed': instance.hasReviewed,
      'lastShownDate': instance.lastShownDate,
      'dissatisfiedDate': instance.dissatisfiedDate,
    };
