# Cloud Functions

Miluアプリのサーバーサイドロジック。世帯共有機能などのバックエンド処理を実装。

## 概要

このディレクトリには、Firebase Cloud Functions（2nd Generation）を使用したバックエンド機能が含まれます。

## 主要機能

### 世帯共有機能（実装予定）

複数のユーザーが赤ちゃんのケア記録を共有するための機能。

**実装される機能:**
- 招待コード生成（6桁の英数字）
- 招待コードの検証と世帯への参加
- 招待コードの有効期限管理（24時間）

詳細な設計は [../docs/household_sharing.md](../docs/household_sharing.md) を参照。

## セットアップ

### 必要なツール

- Node.js 20+
- npm or yarn
- Firebase CLI

### インストール

```bash
cd cloud-functions

# 依存関係のインストール
npm install

# TypeScriptのビルド
npm run build
```

## 開発

### ローカルエミュレーター

```bash
# プロジェクトルートから実行
firebase emulators:start

# 特定のエミュレーターのみ起動
firebase emulators:start --only functions,firestore
```

### TypeScriptコンパイル

```bash
# ビルド
npm run build

# 監視モード
npm run watch
```

### Lint & Format

```bash
# ESLint
npm run lint

# 自動修正
npm run lint -- --fix
```

## デプロイ

### Firebase CLIでデプロイ

```bash
# すべての関数をデプロイ
firebase deploy --only functions

# 特定の関数のみデプロイ
firebase deploy --only functions:generateInvitationCode
```

### Terraformでデプロイ

Terraformを使用したインフラ管理については [../terraform/README.md](../terraform/README.md) を参照。

```bash
cd ../terraform/environments/prod
terraform apply
```

## ディレクトリ構造（予定）

```
cloud-functions/
├── src/
│   ├── index.ts              # エントリーポイント
│   ├── invitations/          # 招待機能
│   │   ├── generateCode.ts
│   │   ├── joinHousehold.ts
│   │   └── utils.ts
│   └── shared/               # 共通ユーティリティ
├── package.json
├── tsconfig.json
├── .eslintrc.js
└── README.md
```

## テスト

```bash
# ユニットテストの実行
npm test

# カバレッジ付き
npm run test:coverage
```

## 環境変数

Cloud Functionsで使用する環境変数は、Firebase Configまたは`.env`ファイルで管理します。

```bash
# 環境変数の設定
firebase functions:config:set someservice.key="THE API KEY"

# 環境変数の確認
firebase functions:config:get
```

## モニタリング

### ログの確認

```bash
# リアルタイムログ
firebase functions:log

# 特定の関数のログ
firebase functions:log --only generateInvitationCode
```

### GCP Console

より詳細なモニタリングは [Google Cloud Console](https://console.cloud.google.com/) で確認できます。

- Cloud Functions → 関数一覧
- Logging → ログエクスプローラー
- Monitoring → ダッシュボード

## コスト管理

Cloud Functions（2nd Gen）の料金情報:
- 最初の200万回の呼び出し: 無料
- メモリ使用量: 256MB推奨
- タイムアウト: 60秒推奨

詳細は [../docs/household_sharing.md](../docs/household_sharing.md) の「コスト分析」セクションを参照。

## トラブルシューティング

### デプロイエラー

```bash
# Firebaseプロジェクトの確認
firebase projects:list

# プロジェクトの切り替え
firebase use <project-id>

# デプロイの詳細ログ
firebase deploy --only functions --debug
```

### エミュレーターのポート競合

```bash
# ポートを変更
firebase emulators:start --only functions --functions-port=5002
```

## 参考リンク

- [Firebase Functions Documentation](https://firebase.google.com/docs/functions)
- [Cloud Functions 2nd Gen](https://cloud.google.com/functions/docs/2nd-gen/overview)
- [TypeScript Style Guide](https://google.github.io/styleguide/tsguide.html)
