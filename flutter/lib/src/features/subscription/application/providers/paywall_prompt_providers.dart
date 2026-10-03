import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/preferences/shared_preferences_provider.dart';
import '../../domain/repositories/paywall_prompt_repository.dart';
import '../../infrastructure/repositories/paywall_prompt_repository_impl.dart';
import '../usecases/check_paywall_prompt_onboarding.dart';
import '../usecases/check_paywall_prompt_record.dart';
import '../usecases/record_paywall_prompt_shown.dart';

final paywallPromptRepositoryProvider =
    Provider<PaywallPromptRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return PaywallPromptRepositoryImpl(prefs);
});

final checkPaywallPromptOnboardingUseCaseProvider =
    Provider<CheckPaywallPromptOnboarding>((ref) {
  final repository = ref.watch(paywallPromptRepositoryProvider);
  return CheckPaywallPromptOnboarding(repository);
});

final checkPaywallPromptRecordUseCaseProvider =
    Provider<CheckPaywallPromptRecord>((ref) {
  final repository = ref.watch(paywallPromptRepositoryProvider);
  return CheckPaywallPromptRecord(repository);
});

final recordPaywallPromptShownUseCaseProvider =
    Provider<RecordPaywallPromptShown>((ref) {
  final repository = ref.watch(paywallPromptRepositoryProvider);
  return RecordPaywallPromptShown(repository);
});
