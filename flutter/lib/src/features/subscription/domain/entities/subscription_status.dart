import 'package:meta/meta.dart';

import 'subscription_plan.dart';

/// サブスクリプションの状態を表すエンティティ
@immutable
class SubscriptionStatus {
  const SubscriptionStatus({
    required this.isPremium,
    this.activePlan,
    this.expiresAt,
  });

  /// フリープランのデフォルト状態
  static const free = SubscriptionStatus(isPremium: false);

  /// プレミアムプランが有効かどうか
  final bool isPremium;

  /// 現在有効なプラン（フリーの場合はnull）
  final SubscriptionPlan? activePlan;

  /// サブスクリプションの有効期限（買い切りの場合はnull）
  final DateTime? expiresAt;

  /// 買い切りプランかどうか
  bool get isLifetime => activePlan == SubscriptionPlan.lifetime;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SubscriptionStatus &&
          runtimeType == other.runtimeType &&
          isPremium == other.isPremium &&
          activePlan == other.activePlan &&
          expiresAt == other.expiresAt;

  @override
  int get hashCode => Object.hash(isPremium, activePlan, expiresAt);

  @override
  String toString() =>
      'SubscriptionStatus(isPremium: $isPremium, activePlan: $activePlan, expiresAt: $expiresAt)';
}
