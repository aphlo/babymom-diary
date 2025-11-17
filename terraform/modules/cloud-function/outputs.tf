output "function_name" {
  description = "Name of the Cloud Function"
  value       = google_cloudfunctions2_function.function.name
}

output "function_uri" {
  description = "URI of the Cloud Function"
  value       = google_cloudfunctions2_function.function.service_config[0].uri
}

output "function_id" {
  description = "ID of the Cloud Function"
  value       = google_cloudfunctions2_function.function.id
}

output "service_config" {
  description = "Service configuration of the Cloud Function"
  value       = google_cloudfunctions2_function.function.service_config
}
