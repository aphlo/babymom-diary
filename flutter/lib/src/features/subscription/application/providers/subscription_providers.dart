import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/subscription_status.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../../infrastructure/repositories/subscription_repository_impl.dart';
import '../../infrastructure/services/revenuecat_service.dart';

part 'subscription_providers.g.dart';

/// SubscriptionRepositoryのProvider
@Riverpod(keepAlive: true)
SubscriptionRepository subscriptionRepository(Ref ref) {
  return SubscriptionRepositoryImpl(RevenueCatService.instance);
}

/// サブスクリプション状態のStreamProvider
@Riverpod(keepAlive: true)
Stream<SubscriptionStatus> subscriptionStatus(Ref ref) async* {
  final repository = ref.watch(subscriptionRepositoryProvider);

  // 初回は現在の状態を取得
  yield await repository.getStatus();

  // 以降はストリームで監視
  yield* repository.watchStatus();
}

/// プレミアムかどうかの同期Provider（デフォルトfalse）
@Riverpod(keepAlive: true)
bool isPremium(Ref ref) {
  final statusAsync = ref.watch(subscriptionStatusProvider);
  return statusAsync.value?.isPremium ?? false;
}
