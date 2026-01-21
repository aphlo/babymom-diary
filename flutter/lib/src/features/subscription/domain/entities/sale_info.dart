import 'package:freezed_annotation/freezed_annotation.dart';

part 'sale_info.freezed.dart';

/// サブスクリプションのセール情報
@freezed
sealed class SaleInfo with _$SaleInfo {
  const factory SaleInfo({
    /// セールが有効かどうか
    required bool isEnabled,

    /// 月額プランの割引率（%）
    required int monthlyDiscountPercent,

    /// 年額プランの割引率（%）
    required int yearlyDiscountPercent,

    /// セールメッセージ
    required String message,

    /// セール終了日
    DateTime? endDate,
  }) = _SaleInfo;

  /// セールなしの状態
  static SaleInfo none() => const SaleInfo(
        isEnabled: false,
        monthlyDiscountPercent: 0,
        yearlyDiscountPercent: 0,
        message: '',
      );
}

/// SaleInfoの拡張メソッド
extension SaleInfoX on SaleInfo {
  /// セールが有効かどうか（期限切れチェック含む）
  bool get isActive {
    if (!isEnabled) return false;
    if (endDate == null) return true;
    return DateTime.now().isBefore(endDate!);
  }

  /// 月額がセール中かどうか
  bool get isMonthlyOnSale => isActive && monthlyDiscountPercent > 0;

  /// 年額がセール中かどうか
  bool get isYearlyOnSale => isActive && yearlyDiscountPercent > 0;

  /// 残り日数
  int? get daysRemaining {
    if (endDate == null) return null;
    final diff = endDate!.difference(DateTime.now()).inDays;
    return diff >= 0 ? diff : null;
  }
}
