# ------------------------------------------------------------------------------
# Push Notification Functions
# ------------------------------------------------------------------------------

# Cloud Function: registerFcmToken
resource "google_cloudfunctions2_function" "register_fcm_token" {
  name        = "register-fcm-token"
  location    = var.region
  description = "Register FCM token for push notifications"

  build_config {
    runtime     = var.runtime
    entry_point = "registerFcmToken"
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

resource "google_cloud_run_service_iam_member" "register_fcm_token_invoker" {
  location = var.region
  service  = google_cloudfunctions2_function.register_fcm_token.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Cloud Function: unregisterFcmToken
resource "google_cloudfunctions2_function" "unregister_fcm_token" {
  name        = "unregister-fcm-token"
  location    = var.region
  description = "Unregister FCM token for push notifications"

  build_config {
    runtime     = var.runtime
    entry_point = "unregisterFcmToken"
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

resource "google_cloud_run_service_iam_member" "unregister_fcm_token_invoker" {
  location = var.region
  service  = google_cloudfunctions2_function.unregister_fcm_token.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
