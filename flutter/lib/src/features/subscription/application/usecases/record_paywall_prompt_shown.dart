import '../../domain/repositories/paywall_prompt_repository.dart';

/// Paywall表示日時やマイルストーンを記録するUseCase
class RecordPaywallPromptShown {
  const RecordPaywallPromptShown(this._repository);

  final PaywallPromptRepository _repository;

  Future<void> call({
    required DateTime now,
    int? milestoneRecordCount,
    bool isOnboarding = false,
  }) async {
    await _repository.recordShown(
      date: now,
      milestoneRecordCount: milestoneRecordCount,
      isOnboarding: isOnboarding,
    );
  }
}
