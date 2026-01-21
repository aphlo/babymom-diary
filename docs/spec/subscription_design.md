# サブスクリプション機能 設計書

## 概要

RevenueCatを使用したサブスクリプション機能を実装し、購入者の広告を非表示にする。

- **課金タイプ**: 月額 + 年額
- **機能**: 広告削除（将来拡張予定）
- **実装順序**: iOS → Android

---

## アーキテクチャ

### Feature構造（DDD + MVVM）

```
flutter/lib/src/features/subscription/
├── domain/
│   ├── entities/
│   │   └── subscription_status.dart      # サブスク状態
│   ├── repositories/
│   │   └── subscription_repository.dart  # リポジトリIF
│   └── value_objects/
│       └── entitlement_id.dart           # Entitlement定数
├── application/
│   ├── providers/
│   │   └── subscription_providers.dart   # Riverpod Provider
│   └── usecases/
│       ├── check_subscription_status.dart
│       ├── purchase_subscription.dart
│       └── restore_purchases.dart
├── infrastructure/
│   ├── repositories/
│   │   └── subscription_repository_impl.dart
│   └── services/
│       └── revenue_cat_service.dart      # RevenueCat SDK wrapper
└── presentation/
    ├── pages/
    │   └── subscription_page.dart        # 購入画面
    ├── viewmodels/
    │   ├── subscription_view_model.dart
    │   └── subscription_state.dart
    └── widgets/
        └── subscription_banner.dart      # プロモーションバナー
```

---

## エンティティ定義

### SubscriptionStatus

サブスクリプションの状態を表すドメインエンティティ。

```dart
@freezed
class SubscriptionStatus with _$SubscriptionStatus {
  const SubscriptionStatus._();

  const factory SubscriptionStatus({
    required bool isActive,
    required bool hasAdFreeEntitlement,
    DateTime? expirationDate,
    String? productId,
  }) = _SubscriptionStatus;

  /// 広告を非表示にするべきかどうか
  bool get shouldHideAds => isActive && hasAdFreeEntitlement;

  /// 非アクティブ状態のファクトリ
  factory SubscriptionStatus.inactive() => const SubscriptionStatus(
        isActive: false,
        hasAdFreeEntitlement: false,
      );
}
```

### EntitlementId

RevenueCat Entitlementの識別子を定義する値オブジェクト。

```dart
class EntitlementId {
  static const String adFree = 'ad_free';
}
```

---

## データフロー

### 広告表示判定フロー

```
BannerAdWidget
  → ref.watch(shouldShowAdsProvider)
    → subscriptionStatusStreamProvider
      → RevenueCatService.customerInfoStream
        → CustomerInfo.entitlements["ad_free"].isActive
```

### 購入フロー

```
SubscriptionPage
  → SubscriptionViewModel.purchaseMonthly() / purchaseYearly()
    → PurchaseSubscriptionUseCase
      → SubscriptionRepository.purchase(packageId)
        → RevenueCatService.purchasePackage()
          → Purchases.purchasePackage()
```

### 復元フロー

```
SubscriptionPage
  → SubscriptionViewModel.restorePurchases()
    → RestorePurchasesUseCase
      → SubscriptionRepository.restore()
        → RevenueCatService.restorePurchases()
          → Purchases.restorePurchases()
```

---

## Provider設計

### 主要Provider

```dart
/// RevenueCatサービスのプロバイダー
@Riverpod(keepAlive: true)
RevenueCatService revenueCatService(Ref ref) => RevenueCatService();

/// サブスクリプション状態のストリームプロバイダー
@Riverpod(keepAlive: true)
Stream<SubscriptionStatus> subscriptionStatusStream(Ref ref) {
  final service = ref.watch(revenueCatServiceProvider);
  return service.subscriptionStatusStream;
}

/// 広告を表示するべきかどうか
@riverpod
bool shouldShowAds(Ref ref) {
  final status = ref.watch(subscriptionStatusStreamProvider).valueOrNull;
  return status?.shouldHideAds != true;
}

/// 利用可能なオファリング（商品一覧）
@riverpod
Future<Offerings?> offerings(Ref ref) async {
  final service = ref.watch(revenueCatServiceProvider);
  return service.getOfferings();
}
```

---

## RevenueCatService設計

RevenueCat SDKのラッパーサービス。

```dart
class RevenueCatService {
  bool _isConfigured = false;

  /// RevenueCatを初期化
  Future<void> configure({
    required String apiKey,
    String? appUserId,
  }) async {
    if (_isConfigured) return;

    await Purchases.configure(
      PurchasesConfiguration(apiKey)..appUserID = appUserId,
    );
    _isConfigured = true;
  }

  /// サブスクリプション状態のストリーム
  Stream<SubscriptionStatus> get subscriptionStatusStream {
    return Purchases.customerInfoStream.map(_mapToSubscriptionStatus);
  }

  /// 現在のサブスクリプション状態を取得
  Future<SubscriptionStatus> getSubscriptionStatus() async {
    final customerInfo = await Purchases.getCustomerInfo();
    return _mapToSubscriptionStatus(customerInfo);
  }

  /// 利用可能なオファリングを取得
  Future<Offerings?> getOfferings() async {
    return await Purchases.getOfferings();
  }

  /// パッケージを購入
  Future<SubscriptionStatus> purchasePackage(Package package) async {
    final result = await Purchases.purchasePackage(package);
    return _mapToSubscriptionStatus(result.customerInfo);
  }

  /// 購入を復元
  Future<SubscriptionStatus> restorePurchases() async {
    final customerInfo = await Purchases.restorePurchases();
    return _mapToSubscriptionStatus(customerInfo);
  }

  /// Firebase UIDでユーザーを識別
  Future<void> loginWithFirebaseUid(String uid) async {
    await Purchases.logIn(uid);
  }

  SubscriptionStatus _mapToSubscriptionStatus(CustomerInfo info) {
    final adFreeEntitlement = info.entitlements.all[EntitlementId.adFree];
    return SubscriptionStatus(
      isActive: adFreeEntitlement?.isActive ?? false,
      hasAdFreeEntitlement: adFreeEntitlement?.isActive ?? false,
      expirationDate: adFreeEntitlement?.expirationDate,
      productId: adFreeEntitlement?.productIdentifier,
    );
  }
}
```

---

## 初期化処理

### app_runner.dart での初期化

```dart
Future<void> runBabymomDiaryApp({
  required String appTitle,
  required String revenueCatApiKey,  // 追加
  bool enableAnalytics = false,
}) async {
  await FirebaseAuth.instance.signInAnonymously();

  // RevenueCat初期化
  final uid = FirebaseAuth.instance.currentUser?.uid;
  final revenueCatService = RevenueCatService();
  await revenueCatService.configure(
    apiKey: revenueCatApiKey,
    appUserId: uid,
  );

  // ... 既存の処理
}
```

---

## 広告連携

### BannerAdWidget の修正

```dart
class BannerAdWidget extends ConsumerStatefulWidget {
  // ...

  @override
  Widget build(BuildContext context) {
    // サブスク状態をチェック
    final shouldShowAds = ref.watch(shouldShowAdsProvider);
    if (!shouldShowAds) {
      return const SizedBox.shrink();
    }

    // 既存の広告表示ロジック
    // ...
  }
}
```

### BannerAdManager の修正

```dart
Future<void> preloadAll(double width) async {
  // サブスク加入済みならスキップ
  final status = await _ref.read(subscriptionStatusStreamProvider.future);
  if (status.shouldHideAds) return;

  // 既存のプリロードロジック
  // ...
}
```

---

## RevenueCat設定

### Entitlement

| ID | 説明 |
|----|------|
| `ad_free` | 広告非表示権限 |

### Products

| Product ID | 種類 | 説明 |
|------------|------|------|
| `ad_free_monthly` | 月額サブスク | 毎月自動更新 |
| `ad_free_yearly` | 年額サブスク | 毎年自動更新（割引価格） |

### Offerings

- **Default Offering**: `default`
  - Monthly Package: `ad_free_monthly`
  - Annual Package: `ad_free_yearly`

---

## APIキー管理

### 環境別APIキー

| 環境 | Firebase Project | RevenueCat App |
|------|-----------------|----------------|
| STG | `babymom-diary-stg` | STG用アプリ |
| PROD | `babymom-diary` | PROD用アプリ |

### 注入方法

`--dart-define` を使用してビルド時に注入:

```bash
# STG
flutter run --flavor stg -t lib/main_stg.dart \
  --dart-define=REVENUECAT_API_KEY=<stg_api_key>

# PROD
flutter run --flavor prod -t lib/main_prod.dart \
  --dart-define=REVENUECAT_API_KEY=<prod_api_key>
```

Dart側での取得:

```dart
const revenueCatApiKey = String.fromEnvironment('REVENUECAT_API_KEY');
```

---

## テスト戦略

### ユニットテスト

- `SubscriptionStatus` エンティティのテスト
  - `shouldHideAds` の判定ロジック
  - ファクトリメソッドの動作

### インテグレーションテスト

- RevenueCatService のモック化
- Provider のテスト

### E2Eテスト

- StoreKit Configuration file（iOS Simulator）
- Sandbox Apple ID（iOS 実機）
- Google Play テストトラック（Android）

---

## 将来の拡張

### 追加予定の機能

1. **プレミアム専用機能**
   - 高度な統計・分析
   - データエクスポート
   - カスタムテーマ

2. **ファミリー共有**
   - Apple Family Sharing対応
   - Google Play Family Library対応

3. **プロモーションコード**
   - 無料トライアル期間
   - 割引クーポン

### Entitlement拡張

将来的に複数のEntitlementを追加する場合:

```dart
class EntitlementId {
  static const String adFree = 'ad_free';
  static const String premium = 'premium';  // 将来用
  static const String pro = 'pro';          // 将来用
}
```
