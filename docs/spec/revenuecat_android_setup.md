# RevenueCat Android セットアップ手順

## 概要

このドキュメントでは、Android向けのRevenueCat導入手順を説明する。

> **Note**: iOS実装完了後に、このドキュメントに従ってAndroid対応を行う。

---

## 1. Google Play Console 設定

### 1.1 アプリ内アイテムの有効化

1. [Google Play Console](https://play.google.com/console) にログイン
2. 対象のアプリを選択
3. **「収益化」** → **「アプリ内アイテム」**
4. アプリ内アイテムを有効化（初回のみ）

### 1.2 定期購入の作成

#### 月額サブスクリプション

1. **「定期購入」** タブ → **「定期購入を作成」**
2. 設定:

| 項目 | 値 |
|------|-----|
| 商品ID | `ad_free_monthly` |
| 名前 | 広告非表示（月額） |
| 説明 | アプリ内の広告を非表示にします |

3. **「基本プランを追加」**:

| 項目 | 値 |
|------|-----|
| 基本プランID | `monthly-plan` |
| 請求期間 | 1か月ごと |
| 更新タイプ | 自動更新 |

4. **「価格を設定」**:
   - 日本: ¥480
   - 他の地域: 自動変換または個別設定

#### 年額サブスクリプション

1. **「定期購入」** タブ → **「定期購入を作成」**
2. 設定:

| 項目 | 値 |
|------|-----|
| 商品ID | `ad_free_yearly` |
| 名前 | 広告非表示（年額） |
| 説明 | アプリ内の広告を非表示にします（年間プランで約34%お得） |

3. **「基本プランを追加」**:

| 項目 | 値 |
|------|-----|
| 基本プランID | `yearly-plan` |
| 請求期間 | 1年ごと |
| 更新タイプ | 自動更新 |

4. **「価格を設定」**:
   - 日本: ¥3,800
   - 他の地域: 自動変換または個別設定

### 1.3 サービスアカウントの作成

RevenueCatとの連携用:

1. **「設定」** → **「APIアクセス」**
2. **「サービスアカウントを作成」** をクリック
3. Google Cloud Console に遷移:
   - **「サービスアカウントを作成」**
   - 名前: `revenuecat-integration`
   - 役割: なし（後で設定）
4. キーを作成:
   - **「キー」** タブ → **「キーを追加」** → **「新しいキーを作成」**
   - JSON形式を選択
   - JSONファイルをダウンロード

5. Google Play Consoleに戻る:
   - **「設定」** → **「APIアクセス」**
   - 作成したサービスアカウントに権限を付与:
     - **「財務データの閲覧、注文と定期購入の管理」** にチェック

---

## 2. RevenueCat Dashboard 設定

### 2.1 Androidアプリの追加

#### 本番用アプリ（PROD）

1. **「Apps」** → **「+ New」**
2. プラットフォーム: **Android**
3. 設定:

| 項目 | 値 |
|------|-----|
| App Name | milu Android (PROD) |
| Package Name | `com.aphlo.babymomdiary` |

#### STG用アプリ

1. **「Apps」** → **「+ New」**
2. プラットフォーム: **Android**
3. 設定:

| 項目 | 値 |
|------|-----|
| App Name | milu Android (STG) |
| Package Name | `com.aphlo.babymomdiary.stg` |

### 2.2 Google Play サービスアカウントの登録

各アプリに対して:

1. アプリ設定ページを開く
2. **「Google Play Store」** セクション
3. ダウンロードしたJSONファイルの内容を貼り付け

### 2.3 Products の作成（Android用）

> **Note**: iOSで作成済みのProductsにAndroid Store Product IDを追加する。

1. **「Products」** で既存の商品を編集

#### 月額商品

| 項目 | 値 |
|------|-----|
| Google Play Product ID | `ad_free_monthly` |
| Google Play Base Plan ID | `monthly-plan` |

#### 年額商品

| 項目 | 値 |
|------|-----|
| Google Play Product ID | `ad_free_yearly` |
| Google Play Base Plan ID | `yearly-plan` |

### 2.4 Android用APIキーの取得

1. **「API Keys」** タブを開く
2. Androidアプリ用の **Public API Key** をコピー

---

## 3. Android 設定

### 3.1 AndroidManifest.xml の更新

`android/app/src/main/AndroidManifest.xml` に BILLING 権限を追加:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- 追加 -->
    <uses-permission android:name="com.android.vending.BILLING" />

    <application
        ...
    </application>
</manifest>
```

### 3.2 build.gradle の確認

`android/app/build.gradle`:

```gradle
android {
    compileSdkVersion 34

    defaultConfig {
        minSdkVersion 24  // RevenueCat は API 21以上、推奨は24以上
        // ...
    }
}
```

### 3.3 Flavor別の設定

`android/app/build.gradle`:

```gradle
android {
    // ...

    flavorDimensions "environment"
    productFlavors {
        stg {
            dimension "environment"
            applicationId "com.aphlo.babymomdiary.stg"
            // ...
        }
        prod {
            dimension "environment"
            applicationId "com.aphlo.babymomdiary"
            // ...
        }
    }
}
```

---

## 4. テスト設定

### 4.1 ライセンステスターの追加

1. Google Play Console → **「設定」** → **「ライセンステスト」**
2. テストに使用するGoogleアカウントのメールアドレスを追加
3. ライセンス応答: **「LICENSED」** を選択

### 4.2 内部テストトラックでのテスト

1. **「テスト」** → **「内部テスト」** → **「テスターを管理」**
2. テスターリストを作成してテスターを追加
3. 内部テスト用のリリースを作成・公開
4. テストリンクをテスターに共有

### 4.3 テスト時の注意事項

- テスト購入は実際に課金されない
- サブスクリプションの更新サイクルは短縮される（1日→5分など）
- 実機でのみテスト可能（エミュレータ不可）

---

## 5. プラットフォーム共通のコード変更

### 5.1 APIキーの管理

`lib/src/core/config/revenue_cat_config.dart`:

```dart
import 'dart:io';

class RevenueCatConfig {
  static String get apiKey {
    // dart-defineで注入されたキーを使用
    const key = String.fromEnvironment('REVENUECAT_API_KEY');
    if (key.isNotEmpty) return key;

    // フォールバック（開発用）
    if (Platform.isIOS) {
      return const String.fromEnvironment(
        'REVENUECAT_IOS_API_KEY',
        defaultValue: '',
      );
    } else {
      return const String.fromEnvironment(
        'REVENUECAT_ANDROID_API_KEY',
        defaultValue: '',
      );
    }
  }
}
```

### 5.2 ビルドコマンド

```bash
# Android STG
flutter run --flavor stg -t lib/main_stg.dart \
  --dart-define=REVENUECAT_API_KEY=<android_stg_api_key>

# Android PROD
flutter run --flavor prod -t lib/main_prod.dart \
  --dart-define=REVENUECAT_API_KEY=<android_prod_api_key>
```

---

## 6. トラブルシューティング

### 商品が表示されない

1. Google Play Consoleで定期購入が **「有効」** になっているか確認
2. 基本プランが正しく設定されているか確認
3. RevenueCat DashboardでProduct IDとBase Plan IDが正しいか確認
4. サービスアカウントの権限を確認
5. アプリが内部テストトラック以上に公開されているか確認

### 購入が失敗する

1. テスターとして登録されているか確認
2. Google Playアプリが最新か確認
3. テスト用のアプリバージョンがインストールされているか確認

### RevenueCat Dashboard に購入が反映されない

1. サービスアカウントのJSON設定を確認
2. RevenueCat SDK のログを確認:
   ```dart
   await Purchases.setLogLevel(LogLevel.debug);
   ```

---

## 7. チェックリスト

### Google Play Console

- [ ] アプリ内アイテムを有効化
- [ ] 月額定期購入を作成（商品ID、基本プラン、価格）
- [ ] 年額定期購入を作成（商品ID、基本プラン、価格）
- [ ] サービスアカウントを作成しJSONキーを取得
- [ ] サービスアカウントに権限を付与
- [ ] ライセンステスターを追加
- [ ] 内部テストトラックにリリース

### RevenueCat Dashboard

- [ ] PROD用Androidアプリを追加
- [ ] STG用Androidアプリを追加
- [ ] サービスアカウントJSONを登録
- [ ] Productsに Google Play Product ID を追加
- [ ] Productsに Google Play Base Plan ID を追加
- [ ] Android用APIキーを取得

### Android

- [ ] AndroidManifest.xmlにBILLING権限を追加
- [ ] minSdkVersionを確認（24以上推奨）
- [ ] Flavor設定を確認

### Flutter

- [ ] プラットフォーム別のAPIキー管理を実装
- [ ] 動作確認（PROD/STG両方）

---

## 8. iOS実装完了後のマージ

Android対応は別ブランチで実施:

```bash
# iOS実装完了後
git checkout main
git pull origin main
git checkout -b feat/android_revenue_cat

# Android対応を実装
# ...

# マージ
git checkout main
git merge feat/android_revenue_cat
```
