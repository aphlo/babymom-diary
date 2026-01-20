# babymom-diary
[![Lint](https://github.com/aphlo/babymom-diary/actions/workflows/ci.yml/badge.svg)](https://github.com/aphlo/babymom-diary/actions/workflows/ci.yml)
[![iOS](https://github.com/aphlo/babymom-diary/actions/workflows/deliver-ios.yml/badge.svg)](https://github.com/aphlo/babymom-diary/actions/workflows/deliver-ios.yml)
[![Android](https://github.com/aphlo/babymom-diary/actions/workflows/deliver-android.yml/badge.svg)](https://github.com/aphlo/babymom-diary/actions/workflows/deliver-android.yml)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

<p align="center">
  <img src="public/assets/images/app_icon.png" width="128" alt="milu Logo" />
</p>

<p align="center">
  <a href="https://apps.apple.com/jp/app/%E8%82%B2%E5%85%90%E8%A8%98%E9%8C%B2-%E4%BA%88%E9%98%B2%E6%8E%A5%E7%A8%AE%E7%AE%A1%E7%90%86-milu/id6754955821">
    <img src="public/assets/images/Download_on_the_App_Store_Badge_JP_RGB_blk_100317.svg" height="40" alt="Download on the App Store">
  </a>
  <a href="https://play.google.com/store/apps/details?id=com.aphlo.babymomdiary">
    <img src="public/assets/images/GetItOnGooglePlay_Badge_Web_color_Japanese.svg" height="40" alt="Get it on Google Play">
  </a>
</p>

<p align="center">
  <a href="https://babymom-diary.web.app/">
    <strong>公式サイトはこちら</strong>
  </a>
</p>
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

