output "accept_invitation_name" {
  description = "Name of the acceptInvitation Cloud Function"
  value       = google_cloudfunctions2_function.accept_invitation.name
}

output "accept_invitation_uri" {
  description = "URI of the acceptInvitation Cloud Function"
  value       = google_cloudfunctions2_function.accept_invitation.service_config[0].uri
}

output "remove_member_name" {
  description = "Name of the removeMember Cloud Function"
  value       = google_cloudfunctions2_function.remove_member.name
}

output "remove_member_uri" {
  description = "URI of the removeMember Cloud Function"
  value       = google_cloudfunctions2_function.remove_member.service_config[0].uri
}
