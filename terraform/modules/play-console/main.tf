# Service account for Google Play Console (Android app deployment)
module "service_account" {
  source = "../service-account"

  project_id   = var.project_id
  account_id   = "play-console-sa"
  display_name = "Google Play Console Service Account"
  description  = "Service account for uploading Android app to Google Play Console"
}
