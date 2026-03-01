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
    required SubscriptionPlan selectedPlan,
    required List<Package> availablePackages,
    required bool isLoadingOfferings,
    required bool isPurchasing,
    required bool isRestoring,
    String? offeringsError,
    PaywallUiEvent? pendingUiEvent,
  }) = _PaywallState;

  factory PaywallState.initial() => const PaywallState(
        selectedPlan: SubscriptionPlan.yearly,
        availablePackages: [],
        isLoadingOfferings: true,
        isPurchasing: false,
        isRestoring: false,
      );

  /// 選択中のプランに対応するPackageを取得
  Package? get selectedPackage => packageForPlan(selectedPlan);

  /// 指定プランに対応するPackageを取得
  Package? packageForPlan(SubscriptionPlan plan) {
    final packageType = switch (plan) {
      SubscriptionPlan.monthly => PackageType.monthly,
      SubscriptionPlan.yearly => PackageType.annual,
    };
    try {
      return availablePackages.firstWhere((p) => p.packageType == packageType);
    } catch (_) {
      return null;
    }
  }

  /// 購入可能かどうか
  bool get canPurchase =>
      !isPurchasing &&
      !isRestoring &&
      !isLoadingOfferings &&
      selectedPackage != null;
}
