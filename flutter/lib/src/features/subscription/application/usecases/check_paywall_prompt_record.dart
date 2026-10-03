import '../../domain/repositories/paywall_prompt_repository.dart';

/// 記録保存マイルストーン達成時にPaywallを表示すべきか判定するUseCase
class CheckPaywallPromptRecord {
  const CheckPaywallPromptRecord(this._repository);

  final PaywallPromptRepository _repository;

  Future<bool> call({
    required int recordCount,
    required DateTime now,
    required bool isPremium,
    String? reviewLastShownDate,
  }) async {
    final state = await _repository.getState();
    return state.shouldShowForRecordCount(
      recordCount: recordCount,
      now: now,
      isPremium: isPremium,
      reviewLastShownDate: reviewLastShownDate,
    );
  }
}
