import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../domain/entities/subscription_status.dart';
import '../../domain/value_objects/entitlement_id.dart';

/// RevenueCat SDKのラッパーサービス
///
/// シングルトンパターンを使用して、アプリ全体で1つのインスタンスを共有する。
class RevenueCatService {
  RevenueCatService._();

  static final RevenueCatService _instance = RevenueCatService._();

  /// シングルトンインスタンスを取得
  factory RevenueCatService() => _instance;

  bool _isConfigured = false;

  /// CustomerInfo更新用のStreamController
  final _customerInfoController =
      StreamController<SubscriptionStatus>.broadcast();

  /// RevenueCatが初期化済みかどうか
  bool get isConfigured => _isConfigured;

  /// RevenueCatを初期化
  Future<void> configure({
    required String apiKey,
    String? appUserId,
  }) async {
    if (_isConfigured) return;

    if (apiKey.isEmpty) {
      debugPrint('[RevenueCat] API key is empty, skipping configuration');
      return;
    }

    try {
      // デバッグモードではログを有効化
      if (kDebugMode) {
        await Purchases.setLogLevel(LogLevel.debug);
      }

      final configuration = PurchasesConfiguration(apiKey);
      if (appUserId != null && appUserId.isNotEmpty) {
        configuration.appUserID = appUserId;
      }

      await Purchases.configure(configuration);
      _isConfigured = true;
      debugPrint('[RevenueCat] Configured successfully with API key');

      // CustomerInfo更新リスナーを追加
      Purchases.addCustomerInfoUpdateListener(_onCustomerInfoUpdate);

      // 初期状態を取得してStreamに追加
      final initialInfo = await Purchases.getCustomerInfo();
      _customerInfoController.add(_mapToSubscriptionStatus(initialInfo));
    } catch (e) {
      debugPrint('[RevenueCat] Configuration failed: $e');
      rethrow;
    }
  }

  /// CustomerInfo更新時のコールバック
  void _onCustomerInfoUpdate(CustomerInfo info) {
    debugPrint('[RevenueCat] Customer info updated');
    _customerInfoController.add(_mapToSubscriptionStatus(info));
  }

  /// サブスクリプション状態のストリーム
  Stream<SubscriptionStatus> get subscriptionStatusStream {
    return _customerInfoController.stream;
  }

  /// 現在のサブスクリプション状態を取得
  Future<SubscriptionStatus> getSubscriptionStatus() async {
    if (!_isConfigured) {
      return SubscriptionStatus.inactive();
    }

    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return _mapToSubscriptionStatus(customerInfo);
    } catch (e) {
      debugPrint('[RevenueCat] Failed to get subscription status: $e');
      return SubscriptionStatus.inactive();
    }
  }

  /// CustomerInfoを直接取得
  Future<CustomerInfo?> getCustomerInfo() async {
    if (!_isConfigured) return null;

    try {
      return await Purchases.getCustomerInfo();
    } catch (e) {
      debugPrint('[RevenueCat] Failed to get customer info: $e');
      return null;
    }
  }

  /// 利用可能なオファリングを取得
  Future<Offerings?> getOfferings() async {
    if (!_isConfigured) {
      return null;
    }

    try {
      final offerings = await Purchases.getOfferings();
      debugPrint(
          '[RevenueCat] Offerings loaded: ${offerings.current?.identifier}');
      return offerings;
    } catch (e) {
      debugPrint('[RevenueCat] Failed to get offerings: $e');
      return null;
    }
  }

  /// パッケージを購入
  Future<SubscriptionStatus> purchasePackage(Package package) async {
    if (!_isConfigured) {
      throw Exception('RevenueCat is not configured');
    }

    try {
      debugPrint('[RevenueCat] Purchasing package: ${package.identifier}');
      final result = await Purchases.purchase(PurchaseParams.package(package));
      debugPrint('[RevenueCat] Purchase successful');
      return _mapToSubscriptionStatus(result.customerInfo);
    } on PurchasesErrorCode catch (e) {
      debugPrint('[RevenueCat] Purchase failed with code: $e');
      rethrow;
    } catch (e) {
      debugPrint('[RevenueCat] Purchase failed: $e');
      rethrow;
    }
  }

  /// 購入を復元
  Future<SubscriptionStatus> restorePurchases() async {
    if (!_isConfigured) {
      throw Exception('RevenueCat is not configured');
    }

    try {
      debugPrint('[RevenueCat] Restoring purchases...');
      final customerInfo = await Purchases.restorePurchases();
      debugPrint('[RevenueCat] Restore completed');
      return _mapToSubscriptionStatus(customerInfo);
    } catch (e) {
      debugPrint('[RevenueCat] Restore failed: $e');
      rethrow;
    }
  }

  /// Firebase UIDでユーザーを識別
  Future<void> loginWithFirebaseUid(String uid) async {
    if (!_isConfigured) return;

    try {
      debugPrint('[RevenueCat] Logging in with Firebase UID');
      await Purchases.logIn(uid);
      debugPrint('[RevenueCat] Logged in successfully');
    } catch (e) {
      debugPrint('[RevenueCat] Login failed: $e');
    }
  }

  /// ログアウト
  Future<void> logout() async {
    if (!_isConfigured) return;

    try {
      await Purchases.logOut();
      debugPrint('[RevenueCat] Logged out');
    } catch (e) {
      debugPrint('[RevenueCat] Logout failed: $e');
    }
  }

  /// 現在のユーザーIDを取得
  Future<String?> getCurrentUserId() async {
    if (!_isConfigured) return null;

    try {
      return await Purchases.appUserID;
    } catch (e) {
      debugPrint('[RevenueCat] Failed to get user ID: $e');
      return null;
    }
  }

  /// Entitlementがアクティブかどうかを確認
  Future<bool> isEntitlementActive(String entitlementId) async {
    if (!_isConfigured) return false;

    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo.entitlements.all[entitlementId]?.isActive ?? false;
    } catch (e) {
      debugPrint('[RevenueCat] Failed to check entitlement: $e');
      return false;
    }
  }

  /// milu Proがアクティブかどうかを確認
  Future<bool> isMiluProActive() async {
    return isEntitlementActive(EntitlementId.miluPro);
  }

  /// CustomerInfoからSubscriptionStatusへの変換
  SubscriptionStatus _mapToSubscriptionStatus(CustomerInfo info) {
    final miluProEntitlement = info.entitlements.all[EntitlementId.miluPro];
    final isActive = miluProEntitlement?.isActive ?? false;

    DateTime? expirationDate;
    if (miluProEntitlement?.expirationDate != null) {
      expirationDate = DateTime.tryParse(miluProEntitlement!.expirationDate!);
    }

    debugPrint('[RevenueCat] Subscription status - active: $isActive');

    return SubscriptionStatus(
      isActive: isActive,
      hasAdFreeEntitlement: isActive,
      expirationDate: expirationDate,
      productId: miluProEntitlement?.productIdentifier,
    );
  }

  /// リソースを解放
  void dispose() {
    _customerInfoController.close();
  }
}
