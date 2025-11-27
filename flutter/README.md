# milu - Flutter App

赤ちゃんのケア活動記録アプリ。

## 機能

- 予防接種記録と予定管理
- 身長・体重の成長記録とグラフ表示
- カレンダー機能
- 世帯共有機能
- 母親の健康記録

## 開発環境

### 必要なツール

- Flutter SDK (FVM管理)
- Xcode (iOS開発)
- Android Studio (Android開発)

### セットアップ

```bash
# FVMでFlutterバージョンをインストール
fvm use

# 依存関係インストール
fvm flutter pub get

# iOSの場合
cd ios
pod install
cd ..
```

### Firebase設定

Firebase設定ファイルは秘匿情報を含むためgitignoreされています。
以下のファイルを再生成する必要があります：

```bash
# 詳細な手順は以下を参照
# ../docs/firebase_config_regeneration.md

# 簡易手順
flutterfire configure --project=babymom-diary --out=lib/firebase_options_local.dart
flutterfire configure --project=babymom-diary --out=lib/firebase_options_prod.dart
```

必要なファイル:
- `lib/firebase_options_local.dart`
- `lib/firebase_options_prod.dart`
- `lib/firebase_options.dart`
- `android/app/src/local/google-services.json`
- `android/app/src/prod/google-services.json`
- `ios/Runner/GoogleService-Info-*.plist`
- `fastlane/.env.local`
- `fastlane/.env.prod`

## 実行

### Rake経由

```bash
# Local環境で実行
rake run_local

# Production環境で実行
rake run_prod

# テスト実行
rake test

# コードフォーマット
rake format

# 静的解析
rake lint
```

Rake経由で追加のFlutterフラグを渡す:
```bash
ARGS="--device-id emulator-5554" rake run_prod
ARGS="--dart-define=BABYMOM_FIREBASE_EMULATOR_HOST=10.0.2.2" rake run_local
```

### Flutter CLI直接

```bash
# Local flavor
fvm flutter run --flavor local -t lib/main_local.dart

# Prod flavor
fvm flutter run --flavor prod -t lib/main_prod.dart
```

## テスト

```bash
# すべてのテストを実行
fvm flutter test

# 特定のテストファイルを実行
fvm flutter test test/features/vaccines/domain/services/vaccination_schedule_policy_test.dart

# 特定のテスト名で実行
fvm flutter test --name "test name pattern"
```

## アーキテクチャ

DDD（Domain-Driven Design）+ MVVM パターンを採用。

### レイヤー構造

```
lib/src/features/{feature}/
  domain/           # ビジネスロジック（Flutter/Firebase依存なし）
    entities/       # イミュータブルなコアビジネスオブジェクト
    repositories/   # リポジトリインターフェース（抽象）
    services/       # ドメインサービス（複雑なビジネスルール）
    value_objects/  # 値オブジェクト（検証付きプリミティブ）
    errors/         # ドメイン固有のエラー

  application/      # ユースケースのオーケストレーション
    usecases/       # アプリケーション操作（コーディネーター層）
    mappers/        # アプリケーションレベルの変換

  infrastructure/   # データ永続化と外部システム
    repositories/   # リポジトリ実装
    sources/        # データソース（Firestore、アセット）
    models/         # シリアライゼーション用DTO/データモデル
    firestore/      # Firestore固有のコマンド/クエリ

  presentation/     # UI（MVVMパターン）
    pages/          # 画面ウィジェット
    widgets/        # 機能固有のUIコンポーネント
    viewmodels/     # 状態管理（Riverpod StateNotifier）
    models/         # UI固有のモデル
    mappers/        # ドメイン→UI変換
    controllers/    # UIコントローラー
    styles/         # UIスタイリング
```

### 主要な原則

1. **ドメインの独立性**: ドメイン層はFlutter、Firebase、インフラパッケージをインポートしてはいけない
2. **依存性の逆転**: ドメインがリポジトリインターフェースを定義し、インフラが実装する
3. **イミュータビリティ**: すべてのエンティティと値オブジェクトは`@immutable`アノテーションを使用
4. **マッパーパターン**: レイヤー間の変換は専用のマッパーで処理
5. **ユースケースのカプセル化**: 各ビジネス操作は専用のユースケースクラス

詳細は以下を参照：
- [../CLAUDE.md](../CLAUDE.md) - プロジェクト全体の指示
- [../AGENTS.md](../AGENTS.md) - MVVM/DDDガイドライン（日本語）

## 主要機能

### 1. Vaccines（予防接種）
最も複雑な機能。ドメインサービス、予約グループなどの高度な機能を含む。

### 2. Calendar（カレンダー）
イベント管理と予防接種スケジュールの統合。

### 3. Child Record（子供の記録）
日々の活動記録、成長記録、パーセンタイルチャート。

### 4. Children（子供管理）
世帯ごとの複数の子供の管理。

### 5. Mom Record（ママの記録）
母親の健康記録と日記。

### 6. Household（世帯）
匿名Firebase認証を使用したマルチユーザー世帯管理。

## Flavor（環境）

### local
- Firebase emulatorを使用
- デフォルトホスト: `localhost` (iOS), `10.0.2.2` (Android)
- エントリーポイント: `lib/main_local.dart`

### prod
- 本番Firebase
- エントリーポイント: `lib/main_prod.dart`

## トラブルシューティング

### FVMが動作しない

```bash
# .fvmrcの確認
cat .fvmrc

# FVMの再設定
fvm use
```

### Firebase設定エラー

```bash
# 設定ファイルが存在するか確認
ls -l lib/firebase_options*.dart
ls -l android/app/src/*/google-services.json
ls -l ios/Runner/GoogleService-Info*.plist

# 存在しない場合は再生成
# 詳細: ../docs/firebase_config_regeneration.md
```

### ビルドエラー

```bash
# クリーンビルド
fvm flutter clean
fvm flutter pub get

# iOS Podのクリーン
cd ios
rm -rf Pods Podfile.lock
pod install
cd ..
```

## ライセンス

[LICENSE](../LICENSE)
