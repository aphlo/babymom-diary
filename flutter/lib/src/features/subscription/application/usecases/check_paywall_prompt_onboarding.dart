import '../../domain/repositories/paywall_prompt_repository.dart';

/// オンボーディング完了時にPaywallを表示すべきか判定するUseCase
class CheckPaywallPromptOnboarding {
  const CheckPaywallPromptOnboarding(this._repository);

  final PaywallPromptRepository _repository;

  Future<bool> call({
    required DateTime now,
    required bool isPremium,
  }) async {
    final state = await _repository.getState();
    return state.shouldShowOnboarding(now: now, isPremium: isPremium);
  }
}
