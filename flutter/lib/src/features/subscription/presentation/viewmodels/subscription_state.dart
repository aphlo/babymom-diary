import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

part 'subscription_state.freezed.dart';

/// サブスクリプション画面のUI状態
@freezed
sealed class SubscriptionState with _$SubscriptionState {
  const factory SubscriptionState({
    /// 処理中かどうか
    @Default(false) bool isProcessing,

    /// 現在サブスク加入中かどうか
    @Default(false) bool isSubscribed,

    /// 利用可能なオファリング
    Offerings? offerings,

    /// エラーメッセージ
    String? errorMessage,

    /// 成功メッセージ
    String? successMessage,

    /// 保留中のUIイベント
    SubscriptionUiEvent? pendingUiEvent,
  }) = _SubscriptionState;

  /// 初期状態
  static SubscriptionState initial() => const SubscriptionState();
}

/// SubscriptionStateの拡張メソッド
extension SubscriptionStateX on SubscriptionState {
  /// 月額パッケージを取得
  Package? get monthlyPackage {
    return offerings?.current?.monthly;
  }

  /// 年額パッケージを取得
  Package? get annualPackage {
    return offerings?.current?.annual;
  }

  /// 商品が利用可能かどうか
  bool get hasPackages => monthlyPackage != null || annualPackage != null;
}

/// サブスクリプション画面のUIイベント
@freezed
sealed class SubscriptionUiEvent with _$SubscriptionUiEvent {
  /// メッセージを表示
  const factory SubscriptionUiEvent.showMessage(String message) = _ShowMessage;

  /// 購入成功
  const factory SubscriptionUiEvent.purchaseSuccess() = _PurchaseSuccess;

  /// 復元成功
  const factory SubscriptionUiEvent.restoreSuccess(bool hasActiveSubscription) =
      _RestoreSuccess;
}
