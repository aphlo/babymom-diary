import 'package:firebase_remote_config/firebase_remote_config.dart';

import '../../domain/entities/sale_info.dart';

/// セール情報をRemote Configから取得するデータソース
class SaleRemoteConfigSource {
  const SaleRemoteConfigSource(this._remoteConfig);

  final FirebaseRemoteConfig _remoteConfig;

  /// Remote Configのキー
  static const _keyEnabled = 'subscription_sale_enabled';
  static const _keyMonthlyDiscount = 'subscription_sale_monthly_discount_percent';
  static const _keyYearlyDiscount = 'subscription_sale_yearly_discount_percent';
  static const _keyMessage = 'subscription_sale_message';
  static const _keyEndDate = 'subscription_sale_end_date';

  /// セール情報を取得
  SaleInfo getSaleInfo() {
    final enabled = _remoteConfig.getBool(_keyEnabled);
    final monthlyDiscount = _remoteConfig.getInt(_keyMonthlyDiscount);
    final yearlyDiscount = _remoteConfig.getInt(_keyYearlyDiscount);
    final message = _remoteConfig.getString(_keyMessage);
    final endDateStr = _remoteConfig.getString(_keyEndDate);

    DateTime? endDate;
    if (endDateStr.isNotEmpty) {
      endDate = DateTime.tryParse(endDateStr);
    }

    return SaleInfo(
      isEnabled: enabled,
      monthlyDiscountPercent: monthlyDiscount,
      yearlyDiscountPercent: yearlyDiscount,
      message: message,
      endDate: endDate,
    );
  }
}
