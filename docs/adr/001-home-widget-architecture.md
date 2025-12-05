# ADR-001: ホームウィジェットアーキテクチャ

## ステータス

実装中 (2025-12-04)

## コンテキスト

ユーザーがアプリを開かずにホーム画面から育児記録を確認・登録できるようにするため、iOS/Androidの両プラットフォームでホームウィジェット機能を実装する必要がある。

### 課題

1. ウィジェットはアプリプロセス外で動作するため、Firestoreに直接アクセスできない
2. iOS App GroupとAndroid SharedPreferencesでデータ共有方式が異なる
3. STG/PROD環境でApp Group IDやBundle Identifierを切り替える必要がある
4. ウィジェットUIはネイティブ（SwiftUI/XML）で実装が必要

## 決定

### 1. データ共有アーキテクチャ

`home_widget` パッケージを使用し、FlutterアプリとネイティブウィジェットでJSON形式のデータを共有する。

```
Flutter App → HomeWidget.saveWidgetData() → Shared Storage → Native Widget
                                              ↑
                                    iOS: App Group UserDefaults
                                    Android: SharedPreferences
```

### 2. Flavor対応のApp Group設計

環境ごとに異なるApp Group IDを使用し、STG/PROD環境のデータを分離する。

| 環境 | App Group ID | Bundle Identifier (Widget) |
|------|--------------|---------------------------|
| STG | `group.com.aphlo.babymomdiary.stg` | `com.aphlo.babymomdiary.stg.MiluWidget` |
| PROD | `group.com.aphlo.babymomdiary` | `com.aphlo.babymomdiary.MiluWidget` |

### 3. 初期化時のApp Group設定

`WidgetDataRepositoryImpl.initialize(isProduction: bool)` でApp Group IDを動的に設定する。

```dart
static Future<void> initialize({required bool isProduction}) async {
  final appGroupId = isProduction
      ? 'group.com.aphlo.babymomdiary'
      : 'group.com.aphlo.babymomdiary.stg';
  await HomeWidget.setAppGroupId(appGroupId);
}
```

- `main_stg.dart`: `initialize(isProduction: false)`
- `main_prod.dart`: `initialize(isProduction: true)`

### 4. Xcode Configuration別のEntitlements設定

Runner TargetとMiluWidget Targetの両方で、Build ConfigurationごとにEntitlementsファイルを切り替える。

**Runner Target:**
| Configuration | Entitlements File |
|---------------|-------------------|
| Debug-stg, Release-stg, Profile-stg | `Runner/Runner-stg.entitlements` |
| Debug-prod, Release-prod, Profile-prod | `Runner/Runner-prod.entitlements` |

**MiluWidget Target:**
| Configuration | Entitlements File | Bundle Identifier |
|---------------|-------------------|-------------------|
| Debug-stg, Release-stg, Profile-stg | `MiluWidget/MiluWidget-stg.entitlements` | `com.aphlo.babymomdiary.stg.MiluWidget` |
| Debug-prod, Release-prod, Profile-prod | `MiluWidget/MiluWidget-prod.entitlements` | `com.aphlo.babymomdiary.MiluWidget` |

### 5. Flutter側のレイヤー構造

DDD原則に従い、widget機能を以下のレイヤーに分離：

```
flutter/lib/src/features/widget/
├── domain/
│   ├── entities/
│   │   ├── widget_data.dart        # 共有データ構造
│   │   ├── widget_settings.dart    # ユーザー設定
│   │   ├── widget_child.dart       # 子供情報
│   │   └── widget_record.dart      # 記録情報
│   └── repositories/
│       └── widget_data_repository.dart  # インターフェース
├── application/
│   └── providers/
│       └── widget_providers.dart   # Riverpod Providers
├── infrastructure/
│   ├── repositories/
│   │   └── widget_data_repository_impl.dart  # 実装
│   └── services/
│       └── widget_data_sync_service.dart     # 同期サービス
└── presentation/
    └── (設定画面 - 未実装)
```

### 6. データ同期トリガー

以下のタイミングでウィジェットデータを同期：

| イベント | 同期内容 |
|---------|---------|
| アプリ起動時 | 全データ同期 |
| Record追加/更新/削除時 | 該当childのrecentRecordsを更新 |
| 子供追加/更新/削除時 | childrenリストを更新 |
| 選択中の子供変更時 | selectedChildIdを更新 |
| ウィジェット設定変更時 | WidgetSettingsを更新 |

## 実装詳細

### ファイル構成

#### Flutter側

| ファイル | 説明 |
|---------|------|
| `lib/src/features/widget/domain/entities/widget_data.dart` | ウィジェット共有データエンティティ |
| `lib/src/features/widget/domain/entities/widget_settings.dart` | ウィジェット設定エンティティ |
| `lib/src/features/widget/domain/entities/widget_child.dart` | 子供情報エンティティ |
| `lib/src/features/widget/domain/entities/widget_record.dart` | 記録情報エンティティ |
| `lib/src/features/widget/domain/repositories/widget_data_repository.dart` | リポジトリインターフェース |
| `lib/src/features/widget/infrastructure/repositories/widget_data_repository_impl.dart` | リポジトリ実装 |
| `lib/src/features/widget/infrastructure/services/widget_data_sync_service.dart` | 同期サービス |
| `lib/src/features/widget/application/providers/widget_providers.dart` | Riverpod Providers |

#### iOS側

| ファイル | 説明 |
|---------|------|
| `ios/MiluWidget/MiluWidget.swift` | WidgetKit実装（SwiftUI） |
| `ios/MiluWidget/MiluWidget-stg.entitlements` | STG用App Group設定 |
| `ios/MiluWidget/MiluWidget-prod.entitlements` | PROD用App Group設定 |
| `ios/Runner/Runner-stg.entitlements` | Runner STG用App Group設定 |
| `ios/Runner/Runner-prod.entitlements` | Runner PROD用App Group設定 |

#### Android側

| ファイル | 説明 |
|---------|------|
| `android/app/src/main/kotlin/.../widget/MiluWidgetProvider.kt` | AppWidgetProvider実装 |
| `android/app/src/main/res/layout/milu_widget_medium.xml` | Mediumウィジェットレイアウト |
| `android/app/src/main/res/xml/milu_widget_info.xml` | ウィジェットメタデータ |
| `android/app/src/main/res/drawable/widget_card_background.xml` | 背景drawable |

### 共有データ構造

```json
{
  "lastUpdated": "2025-12-02T14:30:00.000Z",
  "selectedChildId": "child_abc123",
  "children": [
    {
      "id": "child_abc123",
      "name": "たろう",
      "birthday": "2024-09-20"
    }
  ],
  "recentRecords": {
    "child_abc123": [
      {
        "id": "record_xxx",
        "type": "formula",
        "at": "2025-12-02T14:30:00.000Z",
        "amount": 120,
        "note": null
      }
    ]
  }
}
```

## 代替案

### 代替案1: Firebase Cloud Functions + Push通知

ウィジェット更新をサーバー側からトリガーする方式。

**却下理由:**
- リアルタイム性が低下
- Cloud Functionsのコスト増加
- オフライン時に機能しない

### 代替案2: 単一App Group ID（環境共通）

STG/PROD環境で同じApp Group IDを使用する方式。

**却下理由:**
- 開発中にSTGデータが本番ウィジェットに表示されるリスク
- デバッグが困難になる

### 代替案3: ウィジェットからFirestore直接アクセス

ウィジェット内でFirebase SDKを使用する方式。

**却下理由:**
- Widget Extensionはバックグラウンド制限が厳しい
- Firebase初期化のオーバーヘッド
- 認証状態の管理が複雑

## 結果

- ウィジェットとアプリ間でデータを確実に共有できる
- STG/PROD環境を完全に分離できる
- オフライン時も最後に同期されたデータを表示可能
- DDD原則に従った保守性の高い実装

## 関連ドキュメント

- [ホームウィジェット設計書](../spec/home_widget_spec.md)
