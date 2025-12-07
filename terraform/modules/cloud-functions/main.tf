# Storage bucket for Cloud Functions source code
module "source_bucket" {
  source = "../storage"

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

  labels = merge(var.labels, {
    purpose = "cloud-functions-source"
  })
}

# Service account for Cloud Functions
module "service_account" {
  source = "../service-account"

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
data "archive_file" "source" {
  type        = "zip"
  source_dir  = var.source_dir
  output_path = "${path.module}/tmp/functions-source.zip"
  excludes    = ["node_modules", "lib", ".git", "coverage"]
}

# Upload source code to bucket
resource "google_storage_bucket_object" "source" {
  name   = "functions-source-${data.archive_file.source.output_md5}.zip"
  bucket = module.source_bucket.bucket_name
  source = data.archive_file.source.output_path
}

# ------------------------------------------------------------------------------
# Household Sharing Functions
# ------------------------------------------------------------------------------

# Cloud Function: acceptInvitation
resource "google_cloudfunctions2_function" "accept_invitation" {
  name        = "accept-invitation"
  location    = var.region
  description = "Accept household invitation and add user as member"

  build_config {
    runtime     = var.runtime
    entry_point = "acceptInvitation"
    source {
      storage_source {
        bucket = module.source_bucket.bucket_name
        object = google_storage_bucket_object.source.name
      }
    }
  }

  service_config {
    max_instance_count    = var.max_instance_count
    min_instance_count    = var.min_instance_count
    available_memory      = var.available_memory
    timeout_seconds       = var.timeout_seconds
    service_account_email = module.service_account.email
    environment_variables = var.environment_variables
  }

  labels = var.labels
}

resource "google_cloud_run_service_iam_member" "accept_invitation_invoker" {
  location = var.region
  service  = google_cloudfunctions2_function.accept_invitation.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Cloud Function: removeMember
resource "google_cloudfunctions2_function" "remove_member" {
  name        = "remove-member"
  location    = var.region
  description = "Remove member from household and restore their original household"

  build_config {
    runtime     = var.runtime
    entry_point = "removeMember"
    source {
      storage_source {
        bucket = module.source_bucket.bucket_name
        object = google_storage_bucket_object.source.name
      }
    }
  }

  service_config {
    max_instance_count    = var.max_instance_count
    min_instance_count    = var.min_instance_count
    available_memory      = var.available_memory
    timeout_seconds       = var.timeout_seconds
    service_account_email = module.service_account.email
    environment_variables = var.environment_variables
  }

  labels = var.labels
}

resource "google_cloud_run_service_iam_member" "remove_member_invoker" {
  location = var.region
  service  = google_cloudfunctions2_function.remove_member.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
