output "accept_invitation_url" {
  description = "URL for acceptInvitation Cloud Function"
  value       = module.cloud_functions.accept_invitation_uri
}

output "remove_member_url" {
  description = "URL for removeMember Cloud Function"
  value       = module.cloud_functions.remove_member_uri
}

output "functions_source_bucket" {
  description = "GCS bucket for Cloud Functions source code"
  value       = module.cloud_functions.source_bucket_name
}

output "cloud_functions_service_account" {
  description = "Service account email for Cloud Functions"
  value       = module.cloud_functions.service_account_email
}

output "play_console_service_account_email" {
  description = "Service account email for Google Play Console"
  value       = module.play_console.service_account_email
}
