# babymom-diary

赤ちゃんのケア活動を記録するFlutterアプリケーション「milu」のリポジトリ。

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

## Firebase設定

- **Firestore Rules**: `firestore.rules`
- **Firestore Indexes**: `firestore.indexes.json`
- **Firebase設定**: `firebase.json`

