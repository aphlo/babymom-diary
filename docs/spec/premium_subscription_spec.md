# プレミアムプラン（課金機能）設計書・実装手順書

## 1. 概要

### 1.1 目的

milu アプリにプレミアムプラン（月額・年額）を RevenueCat で導入し、課金ユーザーに広告削除と UI カスタマイズ機能を提供する。

### 1.2 プレミアム特典

| # | 特典 | 説明 |
|---|------|------|
| 1 | 広告削除 | 全13スロットの BannerAd を非表示 |
| 2 | ボトムナビゲーション並び替え | 「ベビーの記録」は先頭固定、残り4つを並び替え可能 |
| 3 | ベビーの記録タブ並び替え | 3タブ（授乳表・離乳食・成長曲線）の順番を変更可能 |
| 4 | ママの記録タブ並び替え | 2タブ（ママの記録・日記）の順番を変更可能 |

### 1.3 プラン構成

| プランID | 種別 | 説明 |
|----------|------|------|
| `milu_premium_monthly` | 自動更新サブスクリプション（月額） | 毎月自動更新 |
| `milu_premium_yearly` | 自動更新サブスクリプション（年額） | 毎年自動更新 |

### 1.4 価格案

| プラン | 価格 | 備考 |
|--------|------|------|
| 月額 | ¥200 | 基準価格 |
| 年額 | ¥2,000 | 月額比 約17%お得 |

> 価格は App Store Connect / Google Play Console で設定時に最終決定する。

### 1.5 設計方針

| 項目 | 決定 |
|------|------|
| 課金基盤 | RevenueCat (`purchases_flutter`) |
| ペイウォールUI | カスタム実装（PaywallPage） |
| サブスク状態管理 | RevenueCat SDK のみ（Firestore 同期なし） |
| 並び替え設定の保存先 | SharedPreferences（端末ローカル） |
| アーキテクチャ | 既存の DDD + MVVM + Riverpod パターンに従う |

---

## 2. 実装済み（Phase 1・2）

### 2.1 実装済みファイル一覧

#### 新規ファイル: subscription feature

```
flutter/lib/src/features/subscription/
  domain/
    entities/
      subscription_plan.dart         # enum: monthly, yearly
      subscription_status.dart       # isPremium, activePlan, expiresAt
    value_objects/
      entitlement.dart               # static const premium = 'premium'
    repositories/
      subscription_repository.dart   # abstract: watchStatus(), getStatus(), restorePurchases()
  application/
    providers/
      subscription_providers.dart    # subscriptionRepositoryProvider, subscriptionStatusProvider(Stream), isPremiumProvider(bool)
  infrastructure/
    services/
      revenuecat_service.dart        # RevenueCat SDK ラッパー（initialize, getCustomerInfo, purchase, restore等）
      revenuecat_config.dart         # flavor別 APIキー管理（★要差し替え）
    repositories/
      subscription_repository_impl.dart  # CustomerInfo → SubscriptionStatus マッピング
```

#### 変更済みファイル

| ファイル | 変更内容 |
|---------|---------|
| `pubspec.yaml` | `purchases_flutter: ^9.12.0` 追加 |
| `main_stg.dart` | `RevenueCatService.initialize(isProduction: false)` 追加 |
| `main_prod.dart` | `RevenueCatService.initialize(isProduction: true)` 追加 |
| `banner_ad_widget.dart` | `build()` 先頭で `isPremiumProvider` をwatch、trueなら非表示 |
| `app_runner.dart` | `_preloadBannerAds()` にプレミアムガード追加 |
| `app_router.dart` | `_preloadAdsForTab()` にプレミアムガード追加 |

### 2.2 Provider 依存グラフ（実装済み部分）

```
RevenueCatService (singleton, main で initialize)
  → SubscriptionRepositoryImpl
    → subscriptionRepositoryProvider (keepAlive)
      → subscriptionStatusProvider (keepAlive, Stream<SubscriptionStatus>)
        → isPremiumProvider (keepAlive, 同期 bool, デフォルト false)

isPremiumProvider を watch:
  → BannerAdWidget       ... 広告表示/非表示
  → app_runner            ... 広告プリロード抑制
  → _ScaffoldWithNavBar   ... タブ切替時の広告プリロード抑制
```

### 2.3 広告削除の仕組み

`BannerAdWidget.build()` の先頭で `isPremiumProvider` をwatchし、プレミアムなら `SizedBox.shrink()` を返す。全13スロットのBannerAdWidgetが同じウィジェットなので、個別修正不要で全広告が消える。

加えて、広告のプリロード自体もスキップされる：
- `_AppState._preloadBannerAds()` — 起動時の初期タブプリロード
- `_ScaffoldWithNavBarState._preloadAdsForTab()` — タブ切替時のプリロード

---

## 3. 未実装（Phase 3〜5）

### Phase 3: ペイウォール UI（カスタム実装）

カスタム実装のペイウォール画面を作成。milu の primaryColor (`#E87086`) とアイコン (`milu_bear.png`) を使用したデザイン。

#### 3.1 実装済みファイル一覧

**新規ファイル:**

```
flutter/lib/src/features/subscription/presentation/
  pages/
    paywall_page.dart                    # メインページ（loading/error/content状態管理）
  viewmodels/
    paywall_state.dart                   # freezed state + PaywallUiEvent
    paywall_view_model.dart              # ViewModel (Riverpod codegen)
  widgets/
    paywall_header.dart                  # アイコン + タイトル + サブタイトル
    paywall_review_carousel.dart         # レビューカルーセル + ドットインジケーター
    paywall_plan_card.dart               # プラン選択カード（1枚分）
    paywall_plan_selector.dart           # 2枚のカードを横並び（月額・年額）
    paywall_footer.dart                  # 購入を復元 + 利用規約 + プライバシー

flutter/lib/src/features/menu/presentation/widgets/
  menu_premium_section.dart              # メニューのプレミアムセクション
```

**変更ファイル:**

| ファイル | 変更内容 |
|---------|---------|
| `app_router.dart` | `/paywall` ルート追加（fullscreenDialog モーダル遷移） |
| `menu_page.dart` | `MenuPremiumSection` を `MenuChildrenSection` の下に追加 |

#### 3.2 ペイウォール画面構成

```
Scaffold(backgroundColor: surfaceBackground)
  └── SafeArea
      └── Column
          ├── Align(topRight) → IconButton(close) → context.pop()
          └── Expanded
              └── SingleChildScrollView
                  ├── PaywallHeader（milu_bear + "milu プレミアム"）
                  ├── PaywallReviewCarousel（レビュー3枚スワイプ）
                  ├── PaywallPlanSelector（月額・年額の2カード）
                  ├── FilledButton("続ける") — 56px高、角丸16、primaryColor
                  └── PaywallFooter（復元・利用規約・プライバシー）
```

#### 3.3 エラーハンドリング

| シナリオ | 処理 |
|---------|------|
| Offerings取得失敗 | エラー画面 + 「再読み込み」ボタン |
| Package未発見 | カード無効化（タップ不可） |
| ユーザーキャンセル | 静かに無視（SnackBarなし） |
| 購入失敗 | SnackBar「購入に失敗しました」 |
| リストア該当なし | SnackBar「復元可能な購入が見つかりませんでした」 |
| 購入成功 | ページを閉じる（isPremiumProvider自動更新） |

---

### Phase 4: 並び替え機能

#### 4.1 navigation_order feature 構成

```
flutter/lib/src/features/navigation_order/
  domain/
    entities/
      bottom_nav_order.dart          # List<BottomNavItem> items（baby固定 + 4つ並び替え）
      tab_order.dart                 # List<String> tabIds
    repositories/
      navigation_order_repository.dart  # abstract: get/save各順番

  application/
    providers/
      navigation_order_providers.dart   # BottomNavOrderNotifier, BabyRecordTabOrderNotifier, MomRecordTabOrderNotifier

  infrastructure/
    storage/
      navigation_order_storage.dart  # SharedPreferencesラッパー（ThemeModeStorageと同パターン）
    repositories/
      navigation_order_repository_impl.dart

  presentation/
    pages/
      navigation_order_settings_page.dart     # 3つの並び替え設定のハブページ
      bottom_nav_order_settings_page.dart      # ボトムナビ並び替え（ReorderableListView）
      baby_record_tab_order_settings_page.dart # ベビー記録タブ並び替え
      mom_record_tab_order_settings_page.dart  # ママ記録タブ並び替え
```

#### 4.2 ボトムナビゲーション並び替えの技術的解決

`StatefulShellRoute.indexedStack` のブランチ順はコンパイル時固定。`NavigationBar` の表示順のみユーザー設定に従って並び替える。

```dart
// _ScaffoldWithNavBarState.build()
final navOrder = ref.watch(bottomNavOrderNotifierProvider);
final orderedItems = navOrder.items;

// ブランチインデックス → BottomNavItem の固定マッピング
const itemForBranch = [baby, vaccines, mom, calendar, menu];

// 現在のブランチ → ビジュアルインデックスに変換
final currentBranch = widget.navigationShell.currentIndex;
final currentItem = itemForBranch[currentBranch];
final selectedVisualIndex = orderedItems.indexOf(currentItem);

NavigationBar(
  selectedIndex: selectedVisualIndex,
  onDestinationSelected: (visualIndex) {
    final tappedItem = orderedItems[visualIndex];
    final branchIndex = itemForBranch.indexOf(tappedItem);
    _onDestinationSelected(branchIndex);
  },
  destinations: orderedItems.map(_destinationFor).toList(),
);
```

#### 4.3 タブ並び替え

タブ定義をマップ化し、順番を動的に適用：

```dart
// record_table_page.dart
static const _tabConfig = {
  'feeding': (label: '授乳表', widget: FeedingTableTab()),
  'babyFood': (label: '離乳食', widget: BabyFoodTab()),
  'growthChart': (label: '成長曲線', widget: GrowthChartTab()),
};

final tabOrder = ref.watch(babyRecordTabOrderNotifierProvider);
final orderedIds = tabOrder.tabIds;
```

ママの記録も同パターン（2タブ: `'momRecord'`, `'diary'`）。

#### 4.4 変更ファイル一覧

| ファイル | 変更内容 |
|---------|---------|
| `app_router.dart` | `_ScaffoldWithNavBar` にビジュアル/ブランチマッピング追加、設定ルート追加 |
| `record_table_page.dart` | タブ順を動的に適用 |
| `mom_record_page.dart` | タブ順を動的に適用 |
| `menu_settings_section.dart` | 「タブの並び替え」設定項目追加（ConsumerWidget化） |
| 新規: `navigation_order/` | feature 全体 |

---

### Phase 5: ストア連携・テスト

RevenueCat ダッシュボード、App Store Connect、Google Play Console の設定を行い、Sandbox / テストアカウントで E2E テストを実施する。詳細はセクション4〜6を参照。

---

## 4. RevenueCat ダッシュボード設定手順

### 4.1 アカウント・プロジェクト作成

1. https://www.revenuecat.com/ でアカウント作成（またはログイン）
2. **Create New Project** → プロジェクト名: `milu`

### 4.2 アプリ登録

**本番用:**

3. **Apps** → **+ New** → **Apple App Store**
   - App name: `milu (iOS)`
   - Bundle ID: `com.aphlo.babymomdiary`
4. **Apps** → **+ New** → **Google Play Store**
   - App name: `milu (Android)`
   - Package name: `com.aphlo.babymomdiary`
5. 各アプリの **Public API Key** を記録

**STG用（推奨）:**

6. 別プロジェクト `milu-stg` を作成するか、同プロジェクト内に STG 用アプリを追加
   - iOS Bundle ID: `com.aphlo.babymomdiary.stg`
   - Android Package name: `com.aphlo.babymomdiary.stg`
7. STG 用の API Key を記録

### 4.3 APIキーをコードに反映

`flutter/lib/src/features/subscription/infrastructure/services/revenuecat_config.dart` を更新:

```dart
static const stg = RevenueCatConfig(
  iosApiKey: 'appl_XXXXXXXX',    // ← STG用 iOS API Key
  androidApiKey: 'goog_XXXXXXXX', // ← STG用 Android API Key
);

static const prod = RevenueCatConfig(
  iosApiKey: 'appl_XXXXXXXX',    // ← 本番用 iOS API Key
  androidApiKey: 'goog_XXXXXXXX', // ← 本番用 Android API Key
);
```

> **注意:** このファイルはAPIキーを含むため、必要に応じて `.gitignore` に追加するか、環境変数経由で注入する方式に変更すること。RevenueCat の Public API Key はクライアント側で使用する前提のキーなので、リポジトリに含めても問題ない（Secretキーではない）。

### 4.4 Entitlement 作成

8. **Project Settings** → **Entitlements** → **+ New**
   - Identifier: `premium`
   - Description: `milu プレミアムプラン`

### 4.5 Products 登録

> Products は App Store Connect / Google Play Console で作成後に登録する。セクション5・6を先に完了すること。

9. **Project Settings** → **Products** → **+ New**

| Product ID | Store |
|------------|-------|
| `milu_premium_monthly` | Apple / Google |
| `milu_premium_yearly` | Apple / Google |

10. 各 Product を Entitlement `premium` に紐付け

### 4.6 Offering 作成

11. **Project Settings** → **Offerings**
    - デフォルトオファリング（`default`）に2つのパッケージを追加:

| Package | Product |
|---------|---------|
| `$rc_monthly` | `milu_premium_monthly` |
| `$rc_annual` | `milu_premium_yearly` |

> **Note:** ペイウォールUIはアプリ側でカスタム実装済み（Phase 3）。RevenueCat Paywalls は使用しない。

### 4.8 ストア認証情報の接続

次のセクション（5・6）で取得した認証情報を RevenueCat に設定する。

**Apple:**
- **Apps** → milu (iOS) → **App Store Connect API** → 下記のいずれか:
  - **App Store Connect API Key**（推奨）: Issuer ID, Key ID, .p8 ファイル
  - **App-Specific Shared Secret**: App Store Connect から取得

**Google:**
- **Apps** → milu (Android) → **Google Play Store** →
  - **Service Account credentials JSON** をアップロード

---

## 5. App Store Connect 設定手順（iOS）

### 5.1 サブスクリプショングループ作成

1. [App Store Connect](https://appstoreconnect.apple.com/) にログイン
2. アプリ `milu` を選択
3. サイドバー → **サブスクリプション** → **サブスクリプショングループ** → **＋**
4. グループ名: `milu Premium`

### 5.2 自動更新サブスクリプション作成

サブスクリプショングループ `milu Premium` 内に2つ作成:

**月額プラン:**
5. **＋** → 参照名: `milu Premium Monthly`, Product ID: `milu_premium_monthly`
6. サブスクリプション期間: **1ヶ月**
7. **サブスクリプション価格** → 価格を設定（例: ¥200）
8. **ローカライゼーション** → 日本語:
   - 表示名: `milu プレミアム（月額）`
   - 説明: `広告削除、タブの並び替えなどプレミアム機能が使えます`
9. **審査情報** → スクリーンショットを添付（ペイウォール画面のスクショ）
10. ステータスを **送信準備完了** にする

**年額プラン:**
11. 同様に作成。Product ID: `milu_premium_yearly`, 期間: **1年**, 価格: ¥2,000

### 5.3 App Store Connect API Key 作成（RevenueCat 連携用）

12. [App Store Connect](https://appstoreconnect.apple.com/) → **ユーザーとアクセス** → **統合** → **App Store Connect API**
13. **キー** タブ → **＋** → キー名: `RevenueCat`, アクセス: **Admin** または **Finance**
14. `.p8` ファイルをダウンロード（一度しかダウンロードできないので注意）
15. **Issuer ID** と **Key ID** を記録
16. RevenueCat ダッシュボードの Apple 接続設定にこの3つを入力

> **代替方法:** App用共有シークレットを使う場合
> - アプリ → App 内課金 → 右上 **App 用共有シークレット** → 生成
> - RevenueCat の Apple 設定に入力

### 5.4 Sandbox テスター作成

17. **ユーザーとアクセス** → **Sandbox** → **テスター** → **＋**
18. テスト用のメールアドレスと情報を入力
19. テスト端末の **設定** → **App Store** → **Sandboxアカウント** にこのアカウントでログイン

### 5.5 審査提出時の注意

- App 内課金は、アプリのバイナリと一緒に審査に提出する必要がある
- アプリの新バージョン提出時に、App 内課金の項目が「送信準備完了」になっていることを確認
- 審査情報にペイウォール画面のスクリーンショットを含める

---

## 6. Google Play Console 設定手順（Android）

### 6.1 定期購入作成

1. [Google Play Console](https://play.google.com/console/) にログイン
2. アプリ `milu` を選択
3. サイドバー → **収益化** → **商品** → **定期購入**

**月額プラン:**
4. **定期購入を作成** → Product ID: `milu_premium_monthly`
5. 名前: `milu プレミアム（月額）`
6. 説明: `広告削除、タブの並び替えなどプレミアム機能が使えます`
7. **基本プランを追加** → 請求対象期間: **1ヶ月**
8. **価格を設定** → 日本: ¥200
9. **有効化**

**年額プラン:**
10. 同様に作成。Product ID: `milu_premium_yearly`, 期間: **1年**, 価格: ¥2,000
11. **有効化**

### 6.2 サービスアカウント設定（RevenueCat 連携用）

12. [Google Cloud Console](https://console.cloud.google.com/) にアクセス
13. milu のプロジェクトを選択（Google Play と紐付いているプロジェクト）
14. **IAM と管理** → **サービスアカウント** → **サービスアカウントを作成**
    - 名前: `revenuecat-service-account`
    - ロール: なし（Google Play Console 側で権限付与）
15. 作成したサービスアカウントの **キー** → **鍵を追加** → **JSON** → ダウンロード
16. Google Play Console → **設定** → **APIアクセス** → **サービスアカウントをリンク**
    - 上記で作成したサービスアカウントのメールアドレスを入力
17. リンクしたサービスアカウントに **権限を付与**:
    - **財務データの表示、注文の管理** にチェック
18. RevenueCat ダッシュボードの Google Play 設定に JSON キーファイルをアップロード

### 6.3 ライセンステスト設定

19. Google Play Console → **設定** → **ライセンステスト**
20. テスト用 Google アカウントのメールアドレスを追加
21. ライセンスレスポンス: `RESPOND_NORMALLY`

### 6.4 内部テスト（任意）

22. **テスト** → **内部テスト** → テスタートラックを作成
23. テスターのメールリストを追加
24. APK/AAB をアップロード（課金機能を含むビルド）

> **注意:** Google Play の課金テストは、アプリが一度内部テスト以上のトラックにアップロードされている必要がある。ローカルビルドのみではテスト不可。

---

## 7. STG 環境での考慮事項

### iOS

- Sandbox テスターは Bundle ID に依存しないため、STG flavor (`com.aphlo.babymomdiary.stg`) でも同じ App Store Connect のプロダクトでテスト可能
- ただし、RevenueCat で STG 用の別アプリを登録し、別 API キーを使うのが望ましい（テストデータの分離）

### Android

- Google Play の課金テストにはストアにアップロードされたビルドが必要
- STG の Package name (`com.aphlo.babymomdiary.stg`) は別アプリ扱いなので、別途テストトラックの設定が必要
- 実質的にはPROD のパッケージ名でテストする方が効率的

### RevenueCat

- `isProduction: false` で初期化するとデバッグログが有効になる
- STG / PROD で異なる API キーを使用し、テストデータを分離

---

## 8. テスト・検証手順

### 8.1 広告削除の検証

1. Sandbox / テストアカウントで月額プランを購入
2. 全画面のバナー広告が非表示になることを確認
3. アプリを再起動しても広告が非表示のままであることを確認
4. Sandbox でサブスクリプションを期限切れにする
5. 広告が復帰することを確認

### 8.2 ペイウォールの検証（Phase 3 実装後）

1. メニュー → プレミアムセクションからペイウォールが表示されることを確認
2. 各プラン（月額・年額）の価格が正しく表示されることを確認
3. 購入フローが正常に完了することを確認
4. 「購入を復元」が正常に動作することを確認

### 8.3 並び替えの検証（Phase 4 実装後）

1. ボトムナビゲーションの並び替え → アプリ再起動 → 順番保持を確認
2. 並び替え後の各タブのルーティング（ページ遷移）が正常に動作することを確認
3. ベビーの記録タブ / ママの記録タブの並び替え → アプリ再起動 → 順番保持を確認
4. サブスク失効 → 並び替えがデフォルト順にリセットされることを確認

### 8.4 リストアの検証

1. 別端末でリストア → プレミアム状態が復帰することを確認
2. 広告非表示が復帰することを確認

### 8.5 既存機能の回帰テスト

```bash
cd flutter && fvm flutter test
```

全既存テストが通ることを確認。

---

## 9. 実装フェーズ全体像

| Phase | 内容 | 状態 |
|-------|------|------|
| **Phase 1** | RevenueCat 基盤（subscription feature, SDK初期化, isPremiumProvider） | **完了** |
| **Phase 2** | 広告削除（BannerAdWidget + プリロードガード） | **完了** |
| **Phase 3** | ペイウォール UI（カスタム実装, メニュー導線, リストア） | **完了** |
| **Phase 4** | 並び替え機能（navigation_order feature, ボトムナビ/タブ並び替え, 設定ページ） | 未実装 |
| **Phase 5** | ストア連携・テスト（セクション4〜6の手順実施, Sandbox テスト） | 未実装 |

### Phase 3 の前提条件

- 完了済み（カスタムUIで実装）

### Phase 5 の前提条件

- App Store Connect でのプロダクト作成（セクション5）
- Google Play Console でのプロダクト作成（セクション6）
- RevenueCat ダッシュボードでの Products / Offerings 紐付け（セクション4.5〜4.6）
- RevenueCat ダッシュボードでのストア認証情報接続（セクション4.8）

---

## 10. セキュリティ・注意事項

- RevenueCat の Public API Key はクライアントサイドで使用するキーであり、シークレットではない。リポジトリに含めて問題ない
- App Store Connect API Key (.p8) やサービスアカウント JSON キーはシークレット。RevenueCat ダッシュボードにのみアップロードし、リポジトリには含めない
- サブスクリプション状態は RevenueCat SDK が管理。Firestore への同期は行わないため、サーバー側での課金状態チェックは不可。将来必要になった場合は RevenueCat Webhooks + Cloud Functions で対応
- すべてのプランは自動更新サブスクリプション（月額・年額）のみ。買い切りプランは提供しない
