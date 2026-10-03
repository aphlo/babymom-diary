import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/paywall_prompt_state.dart';
import '../../domain/repositories/paywall_prompt_repository.dart';

/// SharedPreferencesを使用したPaywallプロンプト状態リポジトリの実装
class PaywallPromptRepositoryImpl implements PaywallPromptRepository {
  PaywallPromptRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyLastShownDate = 'paywall_prompt/last_shown_date';
  static const String _keyHasShownOnboarding =
      'paywall_prompt/has_shown_onboarding';
  static const String _keyLastShownMilestone =
      'paywall_prompt/last_shown_milestone_record_count';

  @override
  Future<PaywallPromptState> getState() async {
    final lastShownDate = _prefs.getString(_keyLastShownDate);
    final hasShownOnboarding = _prefs.getBool(_keyHasShownOnboarding) ?? false;
    final lastShownMilestone = _prefs.getInt(_keyLastShownMilestone) ?? 0;

    return PaywallPromptState(
      lastShownDate: lastShownDate,
      hasShownOnboarding: hasShownOnboarding,
      lastShownMilestoneRecordCount: lastShownMilestone,
    );
  }

  @override
  Future<void> recordShown({
    required DateTime date,
    int? milestoneRecordCount,
    bool isOnboarding = false,
  }) async {
    final dateString = date.toIso8601String().split('T').first;
    await _prefs.setString(_keyLastShownDate, dateString);

    if (isOnboarding) {
      await _prefs.setBool(_keyHasShownOnboarding, true);
    }

    if (milestoneRecordCount != null) {
      await _prefs.setInt(_keyLastShownMilestone, milestoneRecordCount);
    }
  }
}
