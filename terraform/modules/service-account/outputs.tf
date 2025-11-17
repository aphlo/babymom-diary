output "email" {
  description = "Service account email"
  value       = google_service_account.service_account.email
}

output "name" {
  description = "Service account name"
  value       = google_service_account.service_account.name
}

output "id" {
  description = "Service account ID"
  value       = google_service_account.service_account.id
}
