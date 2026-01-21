# RevenueCat iOS セットアップ手順

## 概要

このドキュメントでは、iOS向けのRevenueCat導入手順を説明する。

---

## 開発フロー

```
┌─────────────────┐
│  ローカル開発    │ → Test Store API Key (test_xxx)
│  rake run_stg   │    実ストア接続不要
└────────┬────────┘
         ↓
┌─────────────────┐
│  TestFlight     │ → 本番 API Key (appl_xxx)
│  (Sandbox)      │    Sandbox Apple IDで購入テスト
└────────┬────────┘
         ↓
┌─────────────────┐
│  App Store      │ → 本番 API Key (appl_xxx)
│  (Production)   │    実際の課金
└─────────────────┘
```

### 環境別設定

| 環境 | Bundle ID | API Key | 購入環境 |
|------|-----------|---------|----------|
| ローカル (`run_stg`) | `com.aphlo.babymomdiary.stg` | `test_xxx` | Test Store |
| TestFlight | `com.aphlo.babymomdiary` | `appl_xxx` | Sandbox |
| App Store | `com.aphlo.babymomdiary` | `appl_xxx` | 本番 |

### ポイント

- **STG Bundle IDをRevenueCatに追加する必要はない**
- ローカル開発ではRevenueCatのTest Storeを使用（実ストア接続不要）
- 購入フローの実テストは本番Bundle IDのTestFlight + Sandboxで実施
- RevenueCatプロジェクトは1つで本番アプリのみ登録

---

## 1. App Store Connect 設定

### 1.1 サブスクリプショングループの作成

1. [App Store Connect](https://appstoreconnect.apple.com) にログイン
2. 対象のアプリを選択
3. **「サブスクリプション」** タブを選択
4. **「サブスクリプショングループ」** を作成
   - グループ名: `milu Pro`
   - 参照名: `milu Pro Subscriptions`

### 1.2 サブスクリプション商品の作成

各商品を作成:

#### 月額サブスクリプション

| 項目 | 値 |
|------|-----|
| 参照名 | Monthly |
| 製品ID | `monthly` |
| サブスクリプション期間 | 1ヶ月 |
| 価格 | 自動更新（例: ¥480/月） |

#### 年額サブスクリプション

| 項目 | 値 |
|------|-----|
| 参照名 | Yearly |
| 製品ID | `yearly` |
| サブスクリプション期間 | 1年 |
| 価格 | 自動更新（例: ¥3,800/年 ≒ ¥317/月） |

### 1.3 ローカライズ設定

各商品に日本語のローカライズを追加:

| 項目 | 月額 | 年額 |
|------|------|------|
| 表示名 | milu Pro（月額） | milu Pro（年額） |
| 説明 | 広告を非表示にします | 広告を非表示にします（年間プランでお得） |

### 1.4 App Store Connect APIキーの作成

RevenueCatとの連携用:

1. **「ユーザとアクセス」** → **「統合」** → **「App Store Connect API」**
2. **「+」** をクリックして新規キーを作成
   - 名前: `RevenueCat Integration`
   - アクセス: `Admin` または `App Manager`
3. キーをダウンロード（.p8ファイル）
4. 以下の情報をメモ:
   - Key ID
   - Issuer ID

---

## 2. RevenueCat Dashboard 設定

### 2.1 プロジェクト作成

1. [RevenueCat Dashboard](https://app.revenuecat.com) にログイン
2. **「Create New Project」** をクリック
3. プロジェクト名: `milu`

### 2.2 iOSアプリの追加（本番のみ）

1. **「Apps」** → **「New app configuration」** → **Apple** を選択
2. 設定:

| 項目 | 値 |
|------|-----|
| App Name | milu |
| Bundle ID | `com.aphlo.babymomdiary` |

> **Note**: STG用アプリの追加は不要。ローカル開発ではTest Storeを使用する。

### 2.3 App Store Connect APIキーの登録

1. アプリ設定ページを開く
2. **「App Store Connect API」** セクション
3. App Store Connectからダウンロードした情報を入力:
   - Issuer ID
   - Key ID
   - .p8ファイルをアップロード

### 2.4 Entitlement の作成

1. **「Entitlements」** → **「+ New」**
2. 設定:

| 項目 | 値 |
|------|-----|
| Identifier | `milu Pro` |
| Description | milu Proプレミアム権限（広告非表示） |

### 2.5 Products の作成

1. **「Products」** → **「+ New」**

#### 月額商品

| 項目 | 値 |
|------|-----|
| Identifier | `monthly` |
| App Store Product ID | `monthly` |
| Entitlements | `milu Pro` にチェック |

#### 年額商品

| 項目 | 値 |
|------|-----|
| Identifier | `yearly` |
| App Store Product ID | `yearly` |
| Entitlements | `milu Pro` にチェック |

### 2.6 Offerings の設定

1. **「Offerings」** → **「+ New」**
2. Default Offering を作成:

| 項目 | 値 |
|------|-----|
| Identifier | `default` |
| Description | デフォルトオファリング |

3. Packages を追加:
   - **Monthly**: `monthly` を選択
   - **Annual**: `yearly` を選択

### 2.7 APIキーの取得

1. **「API Keys」** タブを開く
2. 以下の2つのキーを取得:

| キータイプ | 用途 | 形式 |
|-----------|------|------|
| Test API Key | ローカル開発（Test Store） | `test_xxx` |
| Public API Key | TestFlight/本番 | `appl_xxx` |

---

## 3. Xcode 設定

### 3.1 In-App Purchase Capability の追加

1. Xcodeでプロジェクトを開く
2. **Runner** ターゲットを選択
3. **「Signing & Capabilities」** タブ
4. **「+ Capability」** をクリック
5. **「In-App Purchase」** を追加

### 3.2 Entitlements ファイルの確認

`Runner-prod.entitlements` と `Runner-stg.entitlements` に In-App Purchase が含まれていることを確認。

### 3.3 iOS Deployment Target の確認

`ios/Podfile` で最低バージョンを確認:

```ruby
platform :ios, '13.0'
```

RevenueCat SDK は iOS 13.0 以上が必要。

---

## 4. Flutter 設定

### 4.1 API Keyの設定

API Keyは `.env.local` ファイルで管理し、`--dart-define` 経由でアプリに渡す。

#### 環境ファイルのセットアップ

1. `.env.example` を `.env.local` にコピー:
   ```bash
   cp .env.example .env.local
   ```

2. `.env.local` にAPI Keyを設定:
   ```
   REVENUECAT_API_KEY=test_xxxxx
   ```

> **Note**: `.env.local` は `.gitignore` に含まれており、コミットされない。

#### ローカル開発 (`main_stg.dart`)

```dart
// RevenueCat API Key
// .env.local から --dart-define 経由で渡される
const revenueCatApiKey = String.fromEnvironment('REVENUECAT_API_KEY');
await runBabymomDiaryApp(
  appTitle: 'milu (STG)',
  revenueCatApiKey: revenueCatApiKey,
);
```

#### 本番ビルド (`main_prod.dart`)

```dart
// 本番API Key は CI/CD で --dart-define 経由で渡す
const revenueCatApiKey = String.fromEnvironment('REVENUECAT_API_KEY');
await runBabymomDiaryApp(
  appTitle: 'milu',
  enableAnalytics: true,
  revenueCatApiKey: revenueCatApiKey,
);
```

#### Rakefileの動作

`rake run_local` を実行すると:
1. `.env.local` が読み込まれる
2. `REVENUECAT_API_KEY` が `--dart-define` でアプリに渡される

### 4.2 Entitlement ID

`lib/src/features/subscription/domain/value_objects/entitlement_id.dart`:

```dart
class EntitlementId {
  EntitlementId._();
  static const String miluPro = 'milu Pro';
}

class ProductId {
  ProductId._();
  static const String monthly = 'monthly';
  static const String yearly = 'yearly';
}
```

---

## 5. テスト

### 5.1 ローカル開発（Test Store）

1. `rake run_stg` でアプリを起動
2. Test Store API Key（`test_xxx`）が使用される
3. 実際のApp Store接続なしで購入フローをテスト可能

### 5.2 TestFlight（Sandbox）

1. 本番Bundle ID（`com.aphlo.babymomdiary`）でビルド
2. 本番API Key（`appl_xxx`）を使用
3. Sandbox Apple IDで購入テスト

#### Sandbox Apple ID の作成

1. [App Store Connect](https://appstoreconnect.apple.com) にログイン
2. **「ユーザとアクセス」** → **「Sandbox」** → **「テスター」**
3. **「+」** をクリックして新規テスターを作成:

| 項目 | 値 |
|------|-----|
| 名 | Test |
| 姓 | User |
| メールアドレス | 任意（実在しなくてOK） |
| パスワード | 任意 |
| 地域 | 日本 |

#### 実機でのテスト手順

1. 実機の **「設定」** → **「App Store」**
2. **「サンドボックスアカウント」** でテストアカウントにサインイン
3. TestFlightからアプリをインストール
4. 購入フローをテスト

---

## 6. トラブルシューティング

### Wrong API Key エラー

- Test Store用キー（`test_xxx`）と本番用キー（`appl_xxx`）を確認
- ローカル開発ではTest Store用キーを使用する
- TestFlight/本番では本番用キーを使用する

### 商品が表示されない

1. App Store Connectで商品が **「Ready to Submit」** になっているか確認
2. RevenueCat DashboardでProduct IDが正しいか確認
3. Bundle IDが一致しているか確認
4. App Store Connect APIキーが正しく設定されているか確認

### 購入が失敗する

1. Sandboxアカウントでサインインしているか確認
2. 実機の場合、本番アカウントでサインアウトしているか確認
3. ネットワーク接続を確認

---

## 7. チェックリスト

### App Store Connect

- [ ] サブスクリプショングループを作成（`milu Pro`）
- [ ] 月額商品を作成（`monthly`）
- [ ] 年額商品を作成（`yearly`）
- [ ] ローカライズ設定
- [ ] App Store Connect APIキーを作成
- [ ] Sandbox テスターを作成

### RevenueCat Dashboard

- [ ] プロジェクトを作成（`milu`）
- [ ] iOSアプリを追加（本番Bundle IDのみ）
- [ ] App Store Connect APIキーを登録
- [ ] `milu Pro` Entitlementを作成
- [ ] `monthly` Productを作成
- [ ] `yearly` Productを作成
- [ ] Default Offeringを設定
- [ ] Test API Key を取得
- [ ] Public API Key を取得

### Xcode

- [ ] In-App Purchase Capabilityを追加
- [ ] iOS Deployment Targetを確認（13.0以上）

### Flutter

- [ ] `purchases_flutter` パッケージを追加
- [ ] `purchases_ui_flutter` パッケージを追加
- [ ] `main_stg.dart` にTest API Keyを設定
- [ ] `main_prod.dart` に本番API Keyを設定
- [ ] 購入画面を実装
- [ ] 広告連携を実装
