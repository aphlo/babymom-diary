import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/preferences/shared_preferences_provider.dart';

part 'onboarding_status_provider.g.dart';

@Riverpod(keepAlive: true)
class OnboardingStatus extends _$OnboardingStatus {
  static const prefsKey = 'onboarding_completed';

  @override
  bool build() {
    final prefs = ref.watch(sharedPreferencesProvider);
    return prefs.getBool(prefsKey) ?? false;
  }

  Future<void> complete() async {
    state = true;
    final prefs = ref.read(sharedPreferencesProvider);
    await prefs.setBool(prefsKey, true);
  }
}
