import 'package:purchases_flutter/purchases_flutter.dart';

import '../entities/subscription_status.dart';

/// サブスクリプションリポジトリのインターフェース
abstract class SubscriptionRepository {
  /// サブスクリプション状態のストリーム
  Stream<SubscriptionStatus> get subscriptionStatusStream;

  /// 現在のサブスクリプション状態を取得
  Future<SubscriptionStatus> getSubscriptionStatus();

  /// 利用可能なオファリングを取得
  Future<Offerings?> getOfferings();

  /// パッケージを購入
  Future<SubscriptionStatus> purchasePackage(Package package);

  /// 購入を復元
  Future<SubscriptionStatus> restorePurchases();
}
