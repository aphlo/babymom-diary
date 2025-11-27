output "accept_invitation_url" {
  description = "URL for acceptInvitation Cloud Function"
  value       = module.household_sharing_functions.accept_invitation_uri
}

output "remove_member_url" {
  description = "URL for removeMember Cloud Function"
  value       = module.household_sharing_functions.remove_member_uri
}

output "functions_source_bucket" {
  description = "GCS bucket for Cloud Functions source code"
  value       = module.functions_source_bucket.bucket_name
}

output "cloud_functions_service_account" {
  description = "Service account email for Cloud Functions"
  value       = module.cloud_functions_service_account.email
}
