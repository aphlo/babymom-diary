import 'package:purchases_flutter/purchases_flutter.dart';

import '../../domain/entities/subscription_status.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../services/revenue_cat_service.dart';

/// サブスクリプションリポジトリの実装
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  const SubscriptionRepositoryImpl(this._revenueCatService);

  final RevenueCatService _revenueCatService;

  @override
  Stream<SubscriptionStatus> get subscriptionStatusStream {
    return _revenueCatService.subscriptionStatusStream;
  }

  @override
  Future<SubscriptionStatus> getSubscriptionStatus() {
    return _revenueCatService.getSubscriptionStatus();
  }

  @override
  Future<Offerings?> getOfferings() {
    return _revenueCatService.getOfferings();
  }

  @override
  Future<SubscriptionStatus> purchasePackage(Package package) {
    return _revenueCatService.purchasePackage(package);
  }

  @override
  Future<SubscriptionStatus> restorePurchases() {
    return _revenueCatService.restorePurchases();
  }
}
