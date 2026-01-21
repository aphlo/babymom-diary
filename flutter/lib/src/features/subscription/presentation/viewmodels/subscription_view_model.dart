import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../application/providers/subscription_providers.dart';
import 'subscription_state.dart';

part 'subscription_view_model.g.dart';

/// サブスクリプション画面のViewModel
@riverpod
class SubscriptionViewModel extends _$SubscriptionViewModel {
  @override
  SubscriptionState build() {
    _loadInitialData();
    return SubscriptionState.initial();
  }

  /// 初期データを読み込み
  Future<void> _loadInitialData() async {
    // サブスク状態を取得
    final statusAsync = ref.read(subscriptionStatusStreamProvider);
    final isSubscribed = statusAsync.value?.isActive ?? false;

    // オファリングを取得
    final offerings = await ref.read(offeringsProvider.future);

    state = state.copyWith(
      isSubscribed: isSubscribed,
      offerings: offerings,
    );
  }

  /// オファリングを再読み込み
  Future<void> refreshOfferings() async {
    state = state.copyWith(isProcessing: true, errorMessage: null);

    try {
      // キャッシュを無効化して再取得
      ref.invalidate(offeringsProvider);
      final offerings = await ref.read(offeringsProvider.future);

      state = state.copyWith(
        isProcessing: false,
        offerings: offerings,
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        errorMessage: '商品情報の取得に失敗しました',
      );
    }
  }

  /// 月額プランを購入
  Future<void> purchaseMonthly() async {
    final package = state.monthlyPackage;
    if (package == null) return;
    await _purchase(package);
  }

  /// 年額プランを購入
  Future<void> purchaseAnnual() async {
    final package = state.annualPackage;
    if (package == null) return;
    await _purchase(package);
  }

  /// パッケージを購入
  Future<void> _purchase(Package package) async {
    if (state.isProcessing) return;

    state = state.copyWith(
      isProcessing: true,
      errorMessage: null,
      pendingUiEvent: null,
    );

    try {
      final repository = ref.read(subscriptionRepositoryProvider);
      final result = await repository.purchasePackage(package);

      state = state.copyWith(
        isProcessing: false,
        isSubscribed: result.isActive,
        pendingUiEvent: const SubscriptionUiEvent.purchaseSuccess(),
      );
    } on PurchasesErrorCode catch (e) {
      String message;
      switch (e) {
        case PurchasesErrorCode.purchaseCancelledError:
          message = '購入がキャンセルされました';
        case PurchasesErrorCode.paymentPendingError:
          message = '支払いが保留中です';
        case PurchasesErrorCode.productAlreadyPurchasedError:
          message = 'すでに購入済みです';
        default:
          message = '購入に失敗しました';
      }

      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: SubscriptionUiEvent.showMessage(message),
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const SubscriptionUiEvent.showMessage('購入に失敗しました'),
      );
    }
  }

  /// 購入を復元
  Future<void> restorePurchases() async {
    if (state.isProcessing) return;

    state = state.copyWith(
      isProcessing: true,
      errorMessage: null,
      pendingUiEvent: null,
    );

    try {
      final repository = ref.read(subscriptionRepositoryProvider);
      final result = await repository.restorePurchases();

      state = state.copyWith(
        isProcessing: false,
        isSubscribed: result.isActive,
        pendingUiEvent: SubscriptionUiEvent.restoreSuccess(result.isActive),
      );
    } catch (e) {
      state = state.copyWith(
        isProcessing: false,
        pendingUiEvent: const SubscriptionUiEvent.showMessage('復元に失敗しました'),
      );
    }
  }

  /// UIイベントを消費
  void consumeUiEvent() {
    state = state.copyWith(pendingUiEvent: null);
  }
}
