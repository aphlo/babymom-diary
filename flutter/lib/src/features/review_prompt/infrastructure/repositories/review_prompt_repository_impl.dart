import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/review_prompt_state.dart';
import '../../domain/repositories/review_prompt_repository.dart';

/// SharedPreferencesを使用したレビュー促進状態リポジトリの実装
class ReviewPromptRepositoryImpl implements ReviewPromptRepository {
  ReviewPromptRepositoryImpl(this._prefs);

  final SharedPreferences _prefs;

  static const String _keyRecordCount = 'review_prompt/record_count';
  static const String _keyAppLaunchCount = 'review_prompt/app_launch_count';
  static const String _keyHasReviewed = 'review_prompt/has_reviewed';
  static const String _keyLastShownDate = 'review_prompt/last_shown_date';

  @override
  Future<ReviewPromptState> getState() async {
    final recordCount = _prefs.getInt(_keyRecordCount) ?? 0;
    final appLaunchCount = _prefs.getInt(_keyAppLaunchCount) ?? 0;
    final hasReviewed = _prefs.getBool(_keyHasReviewed) ?? false;
    final lastShownDate = _prefs.getString(_keyLastShownDate);

    return ReviewPromptState(
      recordCount: recordCount,
      appLaunchCount: appLaunchCount,
      hasReviewed: hasReviewed,
      lastShownDate: lastShownDate,
    );
  }

  @override
  Future<ReviewPromptState> incrementRecordCount() async {
    final currentCount = _prefs.getInt(_keyRecordCount) ?? 0;
    final newCount = currentCount + 1;
    await _prefs.setInt(_keyRecordCount, newCount);

    return getState();
  }

  @override
  Future<ReviewPromptState> incrementLaunchCount() async {
    final currentCount = _prefs.getInt(_keyAppLaunchCount) ?? 0;
    final newCount = currentCount + 1;
    await _prefs.setInt(_keyAppLaunchCount, newCount);

    return getState();
  }

  @override
  Future<void> markAsReviewed() async {
    await _prefs.setBool(_keyHasReviewed, true);
  }

  @override
  Future<void> recordDialogShown(DateTime date) async {
    final dateString = date.toIso8601String().split('T').first;
    await _prefs.setString(_keyLastShownDate, dateString);
  }
}
