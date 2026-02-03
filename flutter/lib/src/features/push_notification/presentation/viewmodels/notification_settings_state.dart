import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/notification_settings.dart';

part 'notification_settings_state.freezed.dart';

@freezed
sealed class NotificationSettingsState with _$NotificationSettingsState {
  const NotificationSettingsState._();

  const factory NotificationSettingsState({
    @Default(true) bool isLoading,
    String? error,
    NotificationSettings? settings,
  }) = _NotificationSettingsState;

  factory NotificationSettingsState.initial() =>
      const NotificationSettingsState();

  NotificationSettingsState clearError() => copyWith(error: null);

  /// 当日通知が有効かどうか
  bool get isNotifyTodayEnabled =>
      settings?.vaccineReminder.daysBefore.contains(0) ?? true;

  /// 前日通知が有効かどうか
  bool get isNotifyTomorrowEnabled =>
      settings?.vaccineReminder.daysBefore.contains(1) ?? true;

  /// 毎日のエールが有効かどうか
  bool get isDailyEncouragementEnabled =>
      settings?.dailyEncouragement.enabled ?? true;
}
