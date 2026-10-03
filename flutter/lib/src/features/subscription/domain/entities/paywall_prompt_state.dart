import 'package:meta/meta.dart';

/// クールダウン期間（日数）：一度表示したら最低7日間は再表示しない
const int kPaywallCooldownDays = 7;

/// マイルストーン記録回数
const List<int> kPaywallMilestoneRecordCounts = [10, 30, 50];

/// Paywall自動表示のプロンプト状態を表すエンティティ
@immutable
class PaywallPromptState {
  const PaywallPromptState({
    this.lastShownDate,
    this.hasShownOnboarding = false,
    this.lastShownMilestoneRecordCount = 0,
  });

  /// 初期状態
  static const initial = PaywallPromptState();

  /// 最後にPaywallを表示した日付（YYYY-MM-DD形式）
  final String? lastShownDate;

  /// オンボーディング完了時に表示したかどうか
  final bool hasShownOnboarding;

  /// 最後に表示したマイルストーン記録回数
  final int lastShownMilestoneRecordCount;

  /// 共通の抑制チェック（プレミアム加入、クールダウン期間、同日表示、同日レビュー表示）
  bool isSuppressed({
    required DateTime now,
    required bool isPremium,
    String? reviewLastShownDate,
  }) {
    // プレミアムユーザーには絶対に表示しない
    if (isPremium) return true;

    // 今日すでにレビューダイアログが表示されていたら表示しない
    if (reviewLastShownDate != null) {
      final reviewDate = DateTime.tryParse(reviewLastShownDate);
      if (reviewDate != null && _isSameDay(reviewDate, now)) {
        return true;
      }
    }

    // 過去にPaywallを表示したことがある場合、クールダウン期間および同日判定
    if (lastShownDate != null) {
      final lastDate = DateTime.tryParse(lastShownDate!);
      if (lastDate != null) {
        // 同日なら表示しない
        if (_isSameDay(lastDate, now)) return true;

        // クールダウン期間（7日未満）なら表示しない
        final differenceInDays = now.difference(lastDate).inDays;
        if (differenceInDays < kPaywallCooldownDays) return true;
      }
    }

    return false;
  }

  /// オンボーディング完了時に表示すべきか
  bool shouldShowOnboarding({
    required DateTime now,
    required bool isPremium,
  }) {
    if (hasShownOnboarding) return false;
    return !isSuppressed(now: now, isPremium: isPremium);
  }

  /// 記録保存マイルストーン達成時に表示すべきか
  bool shouldShowForRecordCount({
    required int recordCount,
    required DateTime now,
    required bool isPremium,
    String? reviewLastShownDate,
  }) {
    if (isSuppressed(
      now: now,
      isPremium: isPremium,
      reviewLastShownDate: reviewLastShownDate,
    )) {
      return false;
    }

    // マイルストーン（10, 30, 50...）のいずれかに達しているか
    final isMilestone = kPaywallMilestoneRecordCounts.contains(recordCount) ||
        (recordCount > 50 && recordCount % 50 == 0);

    if (!isMilestone) return false;

    // すでにこのマイルストーン以下で表示済みならスキップ
    if (recordCount <= lastShownMilestoneRecordCount) return false;

    return true;
  }

  PaywallPromptState copyWith({
    String? lastShownDate,
    bool? hasShownOnboarding,
    int? lastShownMilestoneRecordCount,
  }) {
    return PaywallPromptState(
      lastShownDate: lastShownDate ?? this.lastShownDate,
      hasShownOnboarding: hasShownOnboarding ?? this.hasShownOnboarding,
      lastShownMilestoneRecordCount:
          lastShownMilestoneRecordCount ?? this.lastShownMilestoneRecordCount,
    );
  }

  static bool _isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PaywallPromptState &&
          runtimeType == other.runtimeType &&
          lastShownDate == other.lastShownDate &&
          hasShownOnboarding == other.hasShownOnboarding &&
          lastShownMilestoneRecordCount == other.lastShownMilestoneRecordCount;

  @override
  int get hashCode => Object.hash(
        lastShownDate,
        hasShownOnboarding,
        lastShownMilestoneRecordCount,
      );

  @override
  String toString() =>
      'PaywallPromptState(lastShownDate: $lastShownDate, hasShownOnboarding: $hasShownOnboarding, lastShownMilestoneRecordCount: $lastShownMilestoneRecordCount)';
}
