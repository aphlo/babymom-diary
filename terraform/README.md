# Terraform

Miluアプリのインフラストラクチャをコードとして管理するTerraform設定。

## 概要

このディレクトリには、Google Cloud Platform（GCP）上のリソースをTerraformで管理するための設定が含まれます。

## 管理対象リソース

- Cloud Functions（2nd Generation）
- Cloud Storage バケット（関数のソースコード保管用）
- IAM ロールとサービスアカウント
- VPC Connector（必要に応じて）
- Secret Manager（環境変数管理）

## ディレクトリ構造（予定）

```
terraform/
├── environments/           # 環境別設定
│   ├── local/             # ローカル開発環境
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   └── prod/              # 本番環境
│       ├── main.tf
│       ├── variables.tf
│       ├── terraform.tfvars
│       └── backend.tf
├── modules/               # 再利用可能なモジュール
│   ├── cloud-function/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── storage/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── README.md
```

## セットアップ

### 必要なツール

- Terraform 1.5+
- Google Cloud SDK (`gcloud`)
- Firebase CLI

### 認証設定

```bash
# Google Cloudへの認証
gcloud auth application-default login

# プロジェクトの設定
gcloud config set project babymom-diary
```

### Terraform初期化

```bash
cd terraform/environments/prod

# 初期化
terraform init

# プランの確認
terraform plan

# 適用
terraform apply
```

## 環境管理

### Local環境

開発用の環境。Firebase Emulatorと連携して動作。

```bash
cd terraform/environments/local
terraform init
terraform plan
terraform apply
```

### Prod環境

本番環境。

```bash
cd terraform/environments/prod
terraform init
terraform plan
terraform apply
```

## ステートファイル管理

Terraformのステートファイルは重要な情報を含むため、以下の方法で管理します：

### リモートバックエンド（推奨）

```hcl
terraform {
  backend "gcs" {
    bucket = "babymom-diary-terraform-state"
    prefix = "terraform/state/prod"
  }
}
```

### ローカルバックエンド（開発時のみ）

```hcl
terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
```

**注意:** ステートファイルは `.gitignore` に含まれており、Gitにコミットされません。

## Cloud Functionsのデプロイフロー

1. **ソースコードのビルド**
   ```bash
   cd ../cloud-functions
   npm run build
   ```

2. **Terraformでインフラをデプロイ**
   ```bash
   cd ../terraform/environments/prod
   terraform apply
   ```

3. **関数の確認**
   ```bash
   gcloud functions list --gen2
   ```

## 変数管理

### variables.tf

共通の変数定義。

```hcl
variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP Region"
  type        = string
  default     = "asia-northeast1"
}
```

### terraform.tfvars

環境固有の変数値（gitignore推奨）。

```hcl
project_id = "babymom-diary"
region     = "asia-northeast1"
```

## モジュールの使用例

```hcl
module "invitation_function" {
  source = "../../modules/cloud-function"

  function_name = "generateInvitationCode"
  runtime       = "nodejs20"
  entry_point   = "generateInvitationCode"
  source_dir    = "../../../cloud-functions"

  environment_variables = {
    NODE_ENV = "production"
  }
}
```

## コマンド一覧

### 基本操作

```bash
# 初期化
terraform init

# フォーマット
terraform fmt

# バリデーション
terraform validate

# プラン確認
terraform plan

# 適用
terraform apply

# 特定のリソースのみ適用
terraform apply -target=module.invitation_function

# リソースの削除
terraform destroy
```

### 状態管理

```bash
# ステートの確認
terraform state list

# 特定リソースの詳細
terraform state show module.invitation_function.google_cloudfunctions2_function.function

# ステートのインポート
terraform import google_cloudfunctions2_function.function projects/PROJECT_ID/locations/REGION/functions/FUNCTION_NAME
```

## CI/CDとの統合

GitHub Actionsでの自動デプロイ例：

```yaml
name: Deploy Infrastructure

on:
  push:
    branches:
      - main
    paths:
      - 'terraform/**'
      - 'cloud-functions/**'

jobs:
  terraform:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Terraform
        uses: hashicorp/setup-terraform@v2
        with:
          terraform_version: 1.5.0

      - name: Terraform Init
        run: terraform init
        working-directory: terraform/environments/prod

      - name: Terraform Plan
        run: terraform plan
        working-directory: terraform/environments/prod

      - name: Terraform Apply
        if: github.ref == 'refs/heads/main'
        run: terraform apply -auto-approve
        working-directory: terraform/environments/prod
```

## セキュリティのベストプラクティス

1. **ステートファイルの保護**
   - リモートバックエンド（GCS）を使用
   - バケットへのアクセスを制限

2. **シークレット管理**
   - Secret Managerを使用
   - terraform.tfvarsはgitignore

3. **最小権限の原則**
   - サービスアカウントに必要最小限の権限を付与
   - IAMロールを適切に設定

4. **リソースのタグ付け**
   - 環境、プロジェクト、コストセンターなどのラベルを付与

## トラブルシューティング

### 認証エラー

```bash
# 認証情報の再設定
gcloud auth application-default login

# サービスアカウントキーの使用
export GOOGLE_APPLICATION_CREDENTIALS="/path/to/service-account-key.json"
```

### ステートロック

```bash
# ロックの強制解除（注意して使用）
terraform force-unlock LOCK_ID
```

### プロバイダーのバージョンエラー

```bash
# プロバイダーの再初期化
terraform init -upgrade
```

## コスト最適化

- Cloud Functionsのメモリ割り当てを最小限に
- 不要なリソースは削除
- タイムアウト設定を適切に

コスト見積もりは [../docs/household_sharing.md](../docs/household_sharing.md) を参照。

## 参考リンク

- [Terraform Google Provider](https://registry.terraform.io/providers/hashicorp/google/latest/docs)
- [GCP Cloud Functions Terraform](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/cloudfunctions2_function)
- [Terraform Best Practices](https://www.terraform.io/docs/cloud/guides/recommended-practices/index.html)
- [設計ドキュメント](../docs/terraform_setup.md)
