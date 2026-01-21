import 'package:freezed_annotation/freezed_annotation.dart';

part 'subscription_status.freezed.dart';

/// サブスクリプションの状態を表すドメインエンティティ
@freezed
sealed class SubscriptionStatus with _$SubscriptionStatus {
  const factory SubscriptionStatus({
    /// サブスクリプションがアクティブかどうか
    required bool isActive,

    /// 広告非表示のEntitlementを持っているかどうか
    required bool hasAdFreeEntitlement,

    /// サブスクリプションの有効期限
    DateTime? expirationDate,

    /// 購入した商品ID
    String? productId,
  }) = _SubscriptionStatus;

  /// 非アクティブ状態のファクトリ
  static SubscriptionStatus inactive() => const SubscriptionStatus(
        isActive: false,
        hasAdFreeEntitlement: false,
      );
}

/// SubscriptionStatusの拡張メソッド
extension SubscriptionStatusX on SubscriptionStatus {
  /// 広告を非表示にするべきかどうか
  bool get shouldHideAds => isActive && hasAdFreeEntitlement;
}
