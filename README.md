# babymom-diary

赤ちゃんのケア活動を記録するFlutterアプリケーション「Milu」のリポジトリ。

## プロジェクト構成

このリポジトリは以下の3つのサブプロジェクトで構成されています：

```
babymom-diary/
├── flutter/           # Flutterアプリケーション
├── cloud-functions/   # Cloud Functions（世帯共有など）
└── terraform/         # インフラコード（IaC）
```

## 各サブプロジェクト

### [Flutter App](./flutter/README.md)

モバイルアプリケーション本体。予防接種記録、成長記録、カレンダーなどの機能を提供。

- **技術スタック**: Flutter, Riverpod, Firebase
- **詳細**: [flutter/README.md](./flutter/README.md)

### [Cloud Functions](./cloud-functions/README.md)

サーバーサイドロジック。世帯共有機能などのバックエンド処理を実装。

- **技術スタック**: Node.js, TypeScript, Firebase Functions
- **詳細**: [cloud-functions/README.md](./cloud-functions/README.md)

### [Terraform](./terraform/README.md)

インフラストラクチャのコード管理。Cloud Functionsのデプロイやリソース管理。

- **技術スタック**: Terraform, GCP
- **詳細**: [terraform/README.md](./terraform/README.md)

## 開発環境セットアップ

### 必要なツール

- Flutter SDK (via FVM)
- Node.js 20+
- Terraform 1.5+
- Firebase CLI
- Google Cloud SDK

### クイックスタート

```bash
# Flutterアプリの起動
cd flutter
fvm flutter pub get
rake run_local

# Cloud Functionsのエミュレーター起動
firebase emulators:start

# Terraformの初期化
cd terraform/environments/local
terraform init
```

## Firebase設定

- **Firestore Rules**: `firestore.rules`
- **Firestore Indexes**: `firestore.indexes.json`
- **Firebase設定**: `firebase.json` (gitignored - 秘匿情報を含む)

## ドキュメント

- [世帯共有機能の設計](./docs/household_sharing.md)
- [Terraform導入ガイド](./docs/terraform_setup.md)
- [モノレポ移行ガイド](./docs/monorepo_migration.md)
- [Firebase設定ファイル再生成手順](./docs/firebase_config_regeneration.md)

## ライセンス

[LICENSE](./LICENSE)
