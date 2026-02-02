output "source_bucket_name" {
  description = "GCS bucket name for Cloud Functions source code"
  value       = module.source_bucket.bucket_name
}

output "service_account_email" {
  description = "Service account email for Cloud Functions"
  value       = module.service_account.email
}

output "accept_invitation_uri" {
  description = "URI of the acceptInvitation Cloud Function"
  value       = google_cloudfunctions2_function.accept_invitation.service_config[0].uri
}

output "remove_member_uri" {
  description = "URI of the removeMember Cloud Function"
  value       = google_cloudfunctions2_function.remove_member.service_config[0].uri
}

output "register_fcm_token_uri" {
  description = "URI of the registerFcmToken Cloud Function"
  value       = google_cloudfunctions2_function.register_fcm_token.service_config[0].uri
}

output "unregister_fcm_token_uri" {
  description = "URI of the unregisterFcmToken Cloud Function"
  value       = google_cloudfunctions2_function.unregister_fcm_token.service_config[0].uri
}
