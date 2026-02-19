import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../domain/entities/subscription_plan.dart';
import '../../domain/entities/subscription_status.dart';
import '../../domain/value_objects/entitlement.dart';
import 'revenuecat_config.dart';

/// RevenueCat SDKのラッパーサービス
class RevenueCatService {
  RevenueCatService._();

  static final instance = RevenueCatService._();

  final _statusController = StreamController<SubscriptionStatus>.broadcast();

  /// サブスクリプション状態のストリーム
  Stream<SubscriptionStatus> get statusStream => _statusController.stream;

  /// RevenueCat SDKを初期化
  static Future<void> initialize({required bool isProduction}) async {
    final config = isProduction ? RevenueCatConfig.prod : RevenueCatConfig.stg;
    final apiKey = Platform.isIOS ? config.iosApiKey : config.androidApiKey;

    if (!isProduction) {
      await Purchases.setLogLevel(LogLevel.debug);
    }

    await Purchases.configure(PurchasesConfiguration(apiKey));

    // CustomerInfo更新時のリスナーを登録
    Purchases.addCustomerInfoUpdateListener((customerInfo) {
      final status = instance._mapCustomerInfo(customerInfo);
      instance._statusController.add(status);
    });
  }

  /// 現在のCustomerInfoからサブスクリプション状態を取得
  Future<SubscriptionStatus> getStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return _mapCustomerInfo(customerInfo);
    } catch (e) {
      debugPrint('[RevenueCat] Failed to get customer info: $e');
      return SubscriptionStatus.free;
    }
  }

  /// 利用可能なOfferingsを取得
  Future<Offerings> getOfferings() async {
    return Purchases.getOfferings();
  }

  /// パッケージを購入
  Future<SubscriptionStatus> purchasePackage(Package package) async {
    final result = await Purchases.purchase(PurchaseParams.package(package));
    return _mapCustomerInfo(result.customerInfo);
  }

  /// 購入をリストア
  Future<SubscriptionStatus> restorePurchases() async {
    final customerInfo = await Purchases.restorePurchases();
    return _mapCustomerInfo(customerInfo);
  }

  /// CustomerInfoからSubscriptionStatusへマッピング
  SubscriptionStatus _mapCustomerInfo(CustomerInfo info) {
    final entitlement = info.entitlements.active[Entitlement.premium];

    if (entitlement == null || !entitlement.isActive) {
      return SubscriptionStatus.free;
    }

    return SubscriptionStatus(
      isPremium: true,
      activePlan: _mapProductIdentifier(entitlement.productIdentifier),
      expiresAt: entitlement.expirationDate != null
          ? DateTime.parse(entitlement.expirationDate!)
          : null,
    );
  }

  /// プロダクトIDからSubscriptionPlanへマッピング
  SubscriptionPlan? _mapProductIdentifier(String productId) {
    if (productId.contains('monthly')) return SubscriptionPlan.monthly;
    if (productId.contains('yearly')) return SubscriptionPlan.yearly;
    if (productId.contains('lifetime')) return SubscriptionPlan.lifetime;
    return null;
  }

  /// リソース解放
  void dispose() {
    _statusController.close();
  }
}
