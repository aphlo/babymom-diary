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
resource "google_project_service" "cloudfunctions" {
  service            = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudbuild" {
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "run" {
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifactregistry" {
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "firebaseappcheck" {
  service            = "firebaseappcheck.googleapis.com"
  disable_on_destroy = false
}

# Storage bucket for Cloud Functions source code
module "functions_source_bucket" {
  source = "../../modules/storage"

  bucket_name        = "${var.project_id}-cloud-functions-source"
  location           = var.region
  force_destroy      = true
  versioning_enabled = true

  lifecycle_rules = [
    {
      condition = {
        num_newer_versions = 5
      }
      action = {
        type = "Delete"
      }
    }
  ]

  labels = {
    environment = "staging"
    purpose     = "cloud-functions-source"
  }
}

# Service account for Cloud Functions
module "cloud_functions_service_account" {
  source = "../../modules/service-account"

  project_id   = var.project_id
  account_id   = "cloud-functions-sa"
  display_name = "Cloud Functions Service Account"
  description  = "Service account for Cloud Functions to access Firestore"

  roles = [
    "roles/datastore.user",
    "roles/firebase.sdkAdminServiceAgent"
  ]
}

# Archive source code
data "archive_file" "functions_source" {
  type        = "zip"
  source_dir  = "${path.module}/../../../cloud-functions"
  output_path = "${path.module}/tmp/functions-source.zip"
  excludes    = ["node_modules", "lib", ".git", "coverage"]
}

# Upload source code to bucket
resource "google_storage_bucket_object" "functions_source" {
  name   = "functions-source-${data.archive_file.functions_source.output_md5}.zip"
  bucket = module.functions_source_bucket.bucket_name
  source = data.archive_file.functions_source.output_path
}

# Household sharing Cloud Functions (acceptInvitation, removeMember)
module "household_sharing_functions" {
  source = "../../modules/household-sharing-functions"

  location              = var.region
  source_bucket         = module.functions_source_bucket.bucket_name
  source_object         = google_storage_bucket_object.functions_source.name
  service_account_email = module.cloud_functions_service_account.email

  max_instance_count = 5
  min_instance_count = 0
  available_memory   = "256M"
  timeout_seconds    = 60

  environment_variables = {
    NODE_ENV = "staging"
  }

  labels = {
    environment = "staging"
    feature     = "household-sharing"
  }

  depends_on = [
    google_project_service.cloudfunctions,
    google_project_service.cloudbuild,
    google_project_service.run,
    google_project_service.artifactregistry,
  ]
}
