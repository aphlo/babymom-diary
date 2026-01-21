import '../../domain/entities/subscription_status.dart';
import '../../domain/repositories/subscription_repository.dart';

/// サブスクリプション状態を確認するユースケース
class CheckSubscriptionStatus {
  const CheckSubscriptionStatus(this._repository);

  final SubscriptionRepository _repository;

  /// 現在のサブスクリプション状態を取得
  Future<SubscriptionStatus> call() {
    return _repository.getSubscriptionStatus();
  }
}
