/// 課金プランの種類
enum SubscriptionPlan {
  /// 買い切り（広告削除）
  lifetime,

  /// 月額プラン（旧プラン）
  @Deprecated('サブスクリプション廃止に伴い非推奨')
  monthly,

  /// 年額プラン（旧プラン）
  @Deprecated('サブスクリプション廃止に伴い非推奨')
  yearly,
}
