import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/preferences/shared_preferences_provider.dart';

class OnboardingStatusNotifier extends StateNotifier<bool> {
  OnboardingStatusNotifier(this._prefs)
      : super(_prefs.getBool(prefsKey) ?? false);

  static const prefsKey = 'onboarding_completed';

  final SharedPreferences _prefs;

  Future<void> complete() async {
    state = true;
    await _prefs.setBool(prefsKey, true);
  }
}

final onboardingStatusProvider =
    StateNotifierProvider<OnboardingStatusNotifier, bool>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return OnboardingStatusNotifier(prefs);
});
