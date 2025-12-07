terraform {
  cloud {

    organization = "aphlo"

    workspaces {
      name = "babymom-diary-stg"
    }
  }

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.0"
    }
    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

# Enable required APIs
module "apis" {
  source = "../../modules/apis"

  project_id               = var.project_id
  enable_cloud_functions   = true
  enable_firebase_appcheck = true
  enable_play_console      = false
}

# Cloud Functions
module "cloud_functions" {
  source = "../../modules/cloud-functions"

  project_id = var.project_id
  region     = var.region
  source_dir = "${path.module}/../../../cloud-functions"

  max_instance_count = 5
  min_instance_count = 0
  available_memory   = "256M"
  timeout_seconds    = 60

  environment_variables = {
    NODE_ENV = "staging"
  }

  labels = {
    environment = "staging"
  }

  depends_on = [module.apis]
}
