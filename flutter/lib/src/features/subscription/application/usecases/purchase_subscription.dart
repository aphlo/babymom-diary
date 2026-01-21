import 'package:purchases_flutter/purchases_flutter.dart';

import '../../domain/entities/subscription_status.dart';
import '../../domain/repositories/subscription_repository.dart';

/// サブスクリプションを購入するユースケース
class PurchaseSubscription {
  const PurchaseSubscription(this._repository);

  final SubscriptionRepository _repository;

  /// 指定されたパッケージを購入
  Future<SubscriptionStatus> call(Package package) {
    return _repository.purchasePackage(package);
  }
}
