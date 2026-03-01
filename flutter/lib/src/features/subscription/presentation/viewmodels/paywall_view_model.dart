import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/subscription_plan.dart';
import '../../infrastructure/services/revenuecat_service.dart';
import 'paywall_state.dart';

part 'paywall_view_model.g.dart';

@riverpod
class PaywallViewModel extends _$PaywallViewModel {
  @override
  PaywallState build() {
    Future.microtask(_loadOfferings);
    return PaywallState.initial();
  }

  Future<void> _loadOfferings() async {
    state = state.copyWith(isLoadingOfferings: true, offeringsError: null);
    try {
      final offerings = await RevenueCatService.instance.getOfferings();
      final packages = offerings.current?.availablePackages ?? [];
      state = state.copyWith(
        isLoadingOfferings: false,
        availablePackages: packages,
      );
    } catch (e) {
      state = state.copyWith(
        isLoadingOfferings: false,
        offeringsError: 'プランの読み込みに失敗しました',
      );
    }
  }

  /// Offeringsを再読み込み
  Future<void> reloadOfferings() async {
    await _loadOfferings();
  }

  /// プランを選択
  void selectPlan(SubscriptionPlan plan) {
    state = state.copyWith(selectedPlan: plan);
  }

  /// 選択中のプランを購入
  Future<void> purchase() async {
    final package = state.selectedPackage;
    if (package == null) return;

    state = state.copyWith(isPurchasing: true, pendingUiEvent: null);
    try {
      await RevenueCatService.instance.purchasePackage(package);
      state = state.copyWith(
        isPurchasing: false,
        pendingUiEvent: const PaywallUiEvent.purchaseCompleted(),
      );
    } on PlatformException catch (e) {
      final errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode == PurchasesErrorCode.purchaseCancelledError) {
        // ユーザーキャンセルは静かに無視
        state = state.copyWith(isPurchasing: false);
        return;
      }
      state = state.copyWith(
        isPurchasing: false,
        pendingUiEvent: const PaywallUiEvent.showMessage('購入に失敗しました'),
      );
    } catch (_) {
      state = state.copyWith(
        isPurchasing: false,
        pendingUiEvent: const PaywallUiEvent.showMessage('購入に失敗しました'),
      );
    }
  }

  /// 購入をリストア
  Future<void> restorePurchases() async {
    state = state.copyWith(isRestoring: true, pendingUiEvent: null);
    try {
      final status = await RevenueCatService.instance.restorePurchases();
      if (status.isPremium) {
        state = state.copyWith(
          isRestoring: false,
          pendingUiEvent: const PaywallUiEvent.purchaseCompleted(),
        );
      } else {
        state = state.copyWith(
          isRestoring: false,
          pendingUiEvent: const PaywallUiEvent.showMessage(
            '復元可能な購入が見つかりませんでした',
          ),
        );
      }
    } catch (_) {
      state = state.copyWith(
        isRestoring: false,
        pendingUiEvent: const PaywallUiEvent.showMessage(
          '購入の復元に失敗しました',
        ),
      );
    }
  }

  /// UiEventをクリア
  void clearUiEvent() {
    state = state.copyWith(pendingUiEvent: null);
  }
}
