import '../../domain/entities/subscription_status.dart';
import '../../domain/repositories/subscription_repository.dart';

/// 購入を復元するユースケース
class RestorePurchases {
  const RestorePurchases(this._repository);

  final SubscriptionRepository _repository;

  /// 購入を復元
  Future<SubscriptionStatus> call() {
    return _repository.restorePurchases();
  }
}
