import '../entities/subscription_status.dart';

/// サブスクリプション管理のリポジトリインターフェース
abstract class SubscriptionRepository {
  /// サブスクリプション状態のストリームを監視
  Stream<SubscriptionStatus> watchStatus();

  /// 現在のサブスクリプション状態を取得
  Future<SubscriptionStatus> getStatus();

  /// 購入をリストア
  Future<SubscriptionStatus> restorePurchases();
}
