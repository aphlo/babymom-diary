import 'package:flutter/material.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

/// RevenueCat Paywallを管理するサービス
class PaywallService {
  PaywallService._();

  static final PaywallService _instance = PaywallService._();

  factory PaywallService() => _instance;

  /// Paywallを表示する
  ///
  /// [context] BuildContext
  /// [offering] 表示するOffering（nullの場合はcurrent offeringを使用）
  /// [displayCloseButton] 閉じるボタンを表示するかどうか
  ///
  /// Returns [PaywallResult] 購入結果
  Future<PaywallResult> presentPaywall({
    required BuildContext context,
    Offering? offering,
    bool displayCloseButton = true,
  }) async {
    debugPrint('[Paywall] Presenting paywall...');

    try {
      final result = await RevenueCatUI.presentPaywall(
        displayCloseButton: displayCloseButton,
        offering: offering,
      );

      debugPrint('[Paywall] Result: $result');
      return result;
    } catch (e) {
      debugPrint('[Paywall] Error presenting paywall: $e');
      rethrow;
    }
  }

  /// Paywallをフルスクリーンダイアログとして表示
  ///
  /// [context] BuildContext
  /// [requiredEntitlementIdentifier] 必要なEntitlement ID
  ///
  /// ユーザーがEntitlementを持っていない場合のみPaywallを表示
  Future<PaywallResult> presentPaywallIfNeeded({
    required BuildContext context,
    required String requiredEntitlementIdentifier,
    Offering? offering,
  }) async {
    debugPrint(
        '[Paywall] Presenting paywall if needed for entitlement: $requiredEntitlementIdentifier');

    try {
      final result = await RevenueCatUI.presentPaywallIfNeeded(
        requiredEntitlementIdentifier,
        offering: offering,
      );

      debugPrint('[Paywall] Result: $result');
      return result;
    } catch (e) {
      debugPrint('[Paywall] Error: $e');
      rethrow;
    }
  }
}

/// Paywall表示のユーティリティ関数
class PaywallUtils {
  PaywallUtils._();

  /// 簡易的なPaywall表示
  static Future<PaywallResult> showPaywall(BuildContext context) async {
    return PaywallService().presentPaywall(context: context);
  }

  /// Entitlementが必要な場合のみPaywallを表示
  static Future<PaywallResult> showPaywallIfNeeded(
    BuildContext context, {
    required String entitlementId,
  }) async {
    return PaywallService().presentPaywallIfNeeded(
      context: context,
      requiredEntitlementIdentifier: entitlementId,
    );
  }
}
