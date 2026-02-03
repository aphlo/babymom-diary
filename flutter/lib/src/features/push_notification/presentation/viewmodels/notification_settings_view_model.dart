import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/usecases/update_notification_settings.dart';
import '../../domain/entities/notification_settings.dart';
import '../../infrastructure/repositories/notification_repository_impl.dart';
import 'notification_settings_state.dart';

part 'notification_settings_view_model.g.dart';

@riverpod
class NotificationSettingsViewModel extends _$NotificationSettingsViewModel {
  @override
  NotificationSettingsState build() {
    return NotificationSettingsState.initial();
  }

  String? get _uid => FirebaseAuth.instance.currentUser?.uid;

  Future<void> loadSettings() async {
    final uid = _uid;
    if (uid == null) {
      state = state.copyWith(
        isLoading: false,
        error: 'ログインが必要です',
      );
      return;
    }

    state = state.copyWith(isLoading: true, error: null);

    try {
      final repository = ref.read(notificationRepositoryProvider);
      var settings = await repository.getSettings(uid: uid);

      // 設定がない場合はデフォルト設定を作成
      if (settings == null) {
        settings = NotificationSettings.defaultSettings();
        await repository.updateSettings(uid: uid, settings: settings);
      }

      state = state.copyWith(
        isLoading: false,
        settings: settings,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '設定の読み込みに失敗しました',
      );
    }
  }

  Future<void> toggleNotifyToday(bool enabled) async {
    final currentSettings = state.settings;
    if (currentSettings == null) return;

    final currentDaysBefore =
        List<int>.from(currentSettings.vaccineReminder.daysBefore);

    if (enabled && !currentDaysBefore.contains(0)) {
      currentDaysBefore.add(0);
    } else if (!enabled) {
      currentDaysBefore.remove(0);
    }

    currentDaysBefore.sort();

    final newSettings = currentSettings.copyWith(
      vaccineReminder: currentSettings.vaccineReminder.copyWith(
        enabled: currentDaysBefore.isNotEmpty,
        daysBefore: currentDaysBefore,
      ),
      updatedAt: DateTime.now(),
    );

    state = state.copyWith(settings: newSettings);
    await _saveSettings(newSettings);
  }

  Future<void> toggleNotifyTomorrow(bool enabled) async {
    final currentSettings = state.settings;
    if (currentSettings == null) return;

    final currentDaysBefore =
        List<int>.from(currentSettings.vaccineReminder.daysBefore);

    if (enabled && !currentDaysBefore.contains(1)) {
      currentDaysBefore.add(1);
    } else if (!enabled) {
      currentDaysBefore.remove(1);
    }

    currentDaysBefore.sort();

    final newSettings = currentSettings.copyWith(
      vaccineReminder: currentSettings.vaccineReminder.copyWith(
        enabled: currentDaysBefore.isNotEmpty,
        daysBefore: currentDaysBefore,
      ),
      updatedAt: DateTime.now(),
    );

    state = state.copyWith(settings: newSettings);
    await _saveSettings(newSettings);
  }

  Future<void> toggleDailyEncouragement(bool enabled) async {
    final currentSettings = state.settings;
    if (currentSettings == null) return;

    final newSettings = currentSettings.copyWith(
      dailyEncouragement: currentSettings.dailyEncouragement.copyWith(
        enabled: enabled,
      ),
      updatedAt: DateTime.now(),
    );

    state = state.copyWith(settings: newSettings);
    await _saveSettings(newSettings);
  }

  Future<void> _saveSettings(NotificationSettings settings) async {
    final uid = _uid;
    if (uid == null) {
      state = state.copyWith(error: '設定を保存できません');
      return;
    }

    try {
      final useCase =
          UpdateNotificationSettings(ref.read(notificationRepositoryProvider));
      await useCase.call(uid: uid, settings: settings);
    } catch (_) {
      state = state.copyWith(error: '設定の保存に失敗しました');
    }
  }

  void clearError() {
    state = state.clearError();
  }
}
