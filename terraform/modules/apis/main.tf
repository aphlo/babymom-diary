# Enable required GCP APIs

resource "google_project_service" "cloudfunctions" {
  count              = var.enable_cloud_functions ? 1 : 0
  project            = var.project_id
  service            = "cloudfunctions.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "cloudbuild" {
  count              = var.enable_cloud_functions ? 1 : 0
  project            = var.project_id
  service            = "cloudbuild.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "run" {
  count              = var.enable_cloud_functions ? 1 : 0
  project            = var.project_id
  service            = "run.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "artifactregistry" {
  count              = var.enable_cloud_functions ? 1 : 0
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

# Get project number for service agent email
data "google_project" "project" {
  count      = var.enable_cloud_functions ? 1 : 0
  project_id = var.project_id
}


resource "google_project_service" "firebaseappcheck" {
  count              = var.enable_firebase_appcheck ? 1 : 0
  project            = var.project_id
  service            = "firebaseappcheck.googleapis.com"
  disable_on_destroy = false
}

resource "google_project_service" "androidpublisher" {
  count              = var.enable_play_console ? 1 : 0
  project            = var.project_id
  service            = "androidpublisher.googleapis.com"
  disable_on_destroy = false
}
