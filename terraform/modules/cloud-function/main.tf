resource "google_cloudfunctions2_function" "function" {
  name        = var.function_name
  location    = var.location
  description = var.description

  build_config {
    runtime     = var.runtime
    entry_point = var.entry_point
    source {
      storage_source {
        bucket = var.source_bucket
        object = var.source_object
      }
    }
  }

  service_config {
    max_instance_count    = var.max_instance_count
    min_instance_count    = var.min_instance_count
    available_memory      = var.available_memory
    timeout_seconds       = var.timeout_seconds
    service_account_email = var.service_account_email
    environment_variables = var.environment_variables
  }

  dynamic "event_trigger" {
    for_each = var.event_trigger != null ? [var.event_trigger] : []
    content {
      trigger_region = event_trigger.value.trigger_region
      event_type     = event_trigger.value.event_type
      pubsub_topic   = event_trigger.value.pubsub_topic
      retry_policy   = event_trigger.value.retry_policy
    }
  }

  labels = var.labels
}

# Allow unauthenticated invocations if specified
resource "google_cloud_run_service_iam_member" "invoker" {
  count = var.allow_unauthenticated ? 1 : 0

  location = var.location
  service  = google_cloudfunctions2_function.function.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
