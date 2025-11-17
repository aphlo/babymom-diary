output "accept_invitation_url" {
  description = "URL for acceptInvitation Cloud Function"
  value       = module.accept_invitation_function.function_uri
}

output "create_invitation_url" {
  description = "URL for createInvitation Cloud Function"
  value       = module.create_invitation_function.function_uri
}

output "functions_source_bucket" {
  description = "GCS bucket for Cloud Functions source code"
  value       = module.functions_source_bucket.bucket_name
}

output "cloud_functions_service_account" {
  description = "Service account email for Cloud Functions"
  value       = module.cloud_functions_service_account.email
}
