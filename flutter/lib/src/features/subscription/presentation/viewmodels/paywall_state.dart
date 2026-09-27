import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../domain/entities/subscription_plan.dart';

part 'paywall_state.freezed.dart';

@freezed
sealed class PaywallUiEvent with _$PaywallUiEvent {
  const factory PaywallUiEvent.showMessage(String message) = _ShowMessage;
  const factory PaywallUiEvent.purchaseCompleted() = _PurchaseCompleted;
}

@freezed
sealed class PaywallState with _$PaywallState {
  const PaywallState._();

  const factory PaywallState({
    @Default(SubscriptionPlan.lifetime) SubscriptionPlan selectedPlan,
    required List<Package> availablePackages,
    required bool isLoadingOfferings,
    required bool isPurchasing,
    required bool isRestoring,

    /// Offerings取得に失敗した場合にハードコードの情報で表示するモード
    @Default(false) bool isFallbackMode,
    String? offeringsError,
    PaywallUiEvent? pendingUiEvent,
  }) = _PaywallState;

  factory PaywallState.initial() => const PaywallState(
        selectedPlan: SubscriptionPlan.lifetime,
        availablePackages: [],
        isLoadingOfferings: true,
        isPurchasing: false,
        isRestoring: false,
      );

  /// 広告削除用のPackageを取得
  Package? get adFreePackage {
    if (availablePackages.isEmpty) return null;
    // 1. lifetime タイプを優先
    try {
      return availablePackages.firstWhere(
        (p) => p.packageType == PackageType.lifetime,
      );
    } catch (_) {}

    // 2. identifier に ad_free または lifetime が含まれるものを探す
    try {
      return availablePackages.firstWhere(
        (p) =>
            p.identifier.toLowerCase().contains('ad_free') ||
            p.identifier.toLowerCase().contains('lifetime'),
      );
    } catch (_) {}

    // 3. なければ最初のパッケージ
    return availablePackages.firstOrNull;
  }

  /// 選択中のプランに対応するPackageを取得（後方互換性）
  Package? get selectedPackage => adFreePackage;

  /// 購入可能かどうか（フォールバック時も購入ボタンを有効にする）
  bool get canPurchase =>
      !isPurchasing &&
      !isRestoring &&
      !isLoadingOfferings &&
      (adFreePackage != null || isFallbackMode);
}
