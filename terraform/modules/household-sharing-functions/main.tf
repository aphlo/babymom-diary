# Cloud Function: acceptInvitation
resource "google_cloudfunctions2_function" "accept_invitation" {
  name        = "accept-invitation"
  location    = var.location
  description = "Accept household invitation and add user as member"

  build_config {
    runtime     = var.runtime
    entry_point = "acceptInvitation"
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

  labels = var.labels
}

resource "google_cloud_run_service_iam_member" "accept_invitation_invoker" {
  location = var.location
  service  = google_cloudfunctions2_function.accept_invitation.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

# Cloud Function: removeMember
resource "google_cloudfunctions2_function" "remove_member" {
  name        = "remove-member"
  location    = var.location
  description = "Remove member from household and restore their original household"

  build_config {
    runtime     = var.runtime
    entry_point = "removeMember"
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

  labels = var.labels
}

resource "google_cloud_run_service_iam_member" "remove_member_invoker" {
  location = var.location
  service  = google_cloudfunctions2_function.remove_member.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
