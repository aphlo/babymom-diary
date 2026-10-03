import '../entities/paywall_prompt_state.dart';

/// Paywall自動表示の状態を永続化・管理するリポジトリインターフェース
abstract class PaywallPromptRepository {
  /// 現在の状態を取得
  Future<PaywallPromptState> getState();

  /// Paywall表示を記録
  Future<void> recordShown({
    required DateTime date,
    int? milestoneRecordCount,
    bool isOnboarding = false,
  });
}
