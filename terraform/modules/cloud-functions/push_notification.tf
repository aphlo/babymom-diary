# ------------------------------------------------------------------------------
# Push Notification Functions
# ------------------------------------------------------------------------------

# ------------------------------------------------------------------------------
# Scheduled Functions - Pub/Sub Topics and Cloud Scheduler
# ------------------------------------------------------------------------------

# Pub/Sub Topic for sendVaccineReminder
resource "google_pubsub_topic" "send_vaccine_reminder" {
  name   = "send-vaccine-reminder"
  labels = var.labels
}

# Cloud Scheduler Job: vaccine reminder at 10:00 JST daily
resource "google_cloud_scheduler_job" "send_vaccine_reminder" {
  name        = "send-vaccine-reminder"
  description = "Daily vaccine reminder notification at 10:00 JST"
  schedule    = "0 10 * * *"
  time_zone   = "Asia/Tokyo"
  region      = var.region

  pubsub_target {
    topic_name = google_pubsub_topic.send_vaccine_reminder.id
    data       = base64encode("{}")
  }

  retry_config {
    retry_count          = 3
    min_backoff_duration = "5s"
    max_backoff_duration = "300s"
  }
}

# Cloud Function: sendVaccineReminder (Pub/Sub triggered)
resource "google_cloudfunctions2_function" "send_vaccine_reminder" {
  name        = "send-vaccine-reminder"
  location    = var.region
  description = "Send vaccine reminder notifications to users with upcoming reservations"

  build_config {
    runtime     = var.runtime
    entry_point = "sendVaccineReminder"
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
    available_memory      = "512M" # More memory for batch processing
    timeout_seconds       = 300    # 5 minutes for processing many notifications
    service_account_email = module.service_account.email
    environment_variables = var.environment_variables
  }

  event_trigger {
    trigger_region = var.region
    event_type     = "google.cloud.pubsub.topic.v1.messagePublished"
    pubsub_topic   = google_pubsub_topic.send_vaccine_reminder.id
    retry_policy   = "RETRY_POLICY_RETRY"
  }

  labels = var.labels
}

# ------------------------------------------------------------------------------
# HTTPS Callable Functions
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
