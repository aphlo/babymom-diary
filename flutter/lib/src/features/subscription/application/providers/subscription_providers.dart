import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/subscription_status.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../../infrastructure/repositories/subscription_repository_impl.dart';
import '../../infrastructure/services/revenue_cat_service.dart';

part 'subscription_providers.g.dart';

/// RevenueCatサービスのプロバイダー
@Riverpod(keepAlive: true)
RevenueCatService revenueCatService(Ref ref) {
  return RevenueCatService();
}

/// サブスクリプションリポジトリのプロバイダー
@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(Ref ref) {
  final service = ref.watch(revenueCatServiceProvider);
  return SubscriptionRepositoryImpl(service);
}

/// サブスクリプション状態のストリームプロバイダー
@Riverpod(keepAlive: true)
Stream<SubscriptionStatus> subscriptionStatusStream(Ref ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return repository.subscriptionStatusStream;
}

/// 現在のサブスクリプション状態を取得するプロバイダー
@riverpod
Future<SubscriptionStatus> subscriptionStatus(Ref ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return repository.getSubscriptionStatus();
}

/// 広告を表示するべきかどうか
@riverpod
bool shouldShowAds(Ref ref) {
  final status = ref.watch(subscriptionStatusStreamProvider).value;
  // サブスク状態が取得できない場合やアクティブでない場合は広告を表示
  return status?.shouldHideAds != true;
}

/// サブスクが有効かどうか（同期的に取得）
@riverpod
bool isSubscriptionActive(Ref ref) {
  final status = ref.watch(subscriptionStatusStreamProvider).value;
  return status?.isActive ?? false;
}

/// 利用可能なオファリング（商品一覧）
@riverpod
Future<Offerings?> offerings(Ref ref) {
  final repository = ref.watch(subscriptionRepositoryProvider);
  return repository.getOfferings();
}
