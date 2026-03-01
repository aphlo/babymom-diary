import '../../domain/entities/subscription_status.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../services/revenuecat_service.dart';

/// SubscriptionRepositoryのRevenueCat実装
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  SubscriptionRepositoryImpl(this._service);

  final RevenueCatService _service;

  @override
  Stream<SubscriptionStatus> watchStatus() => _service.statusStream;

  @override
  Future<SubscriptionStatus> getStatus() => _service.getStatus();

  @override
  Future<SubscriptionStatus> restorePurchases() => _service.restorePurchases();
}
