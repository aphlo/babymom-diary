import 'package:flutter/material.dart';
import 'package:purchases_ui_flutter/purchases_ui_flutter.dart';

/// RevenueCat Customer Centerを管理するサービス
///
/// Customer Centerは、ユーザーがサブスクリプションを自己管理できる画面を提供する。
/// - サブスクリプションの詳細表示
/// - キャンセル処理
/// - プラン変更
/// - 問い合わせ
class CustomerCenterService {
  CustomerCenterService._();

  static final CustomerCenterService _instance = CustomerCenterService._();

  factory CustomerCenterService() => _instance;

  /// Customer Centerを表示する
  ///
  /// [context] BuildContext
  ///
  /// Customer Centerでは以下の機能が利用可能:
  /// - 現在のサブスクリプション状態の確認
  /// - サブスクリプションのキャンセル
  /// - プランの変更
  /// - サポートへの問い合わせ
  Future<void> presentCustomerCenter({
    required BuildContext context,
  }) async {
    debugPrint('[CustomerCenter] Presenting customer center...');

    try {
      await RevenueCatUI.presentCustomerCenter();
      debugPrint('[CustomerCenter] Customer center closed');
    } catch (e) {
      debugPrint('[CustomerCenter] Error presenting customer center: $e');
      rethrow;
    }
  }
}

/// Customer Center表示のユーティリティ関数
class CustomerCenterUtils {
  CustomerCenterUtils._();

  /// 簡易的なCustomer Center表示
  static Future<void> showCustomerCenter(BuildContext context) async {
    return CustomerCenterService().presentCustomerCenter(context: context);
  }
}
