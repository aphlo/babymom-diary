output "cloud_functions_apis_enabled" {
  description = "Whether Cloud Functions APIs are enabled"
  value       = var.enable_cloud_functions
}

output "play_console_api_enabled" {
  description = "Whether Google Play Android Developer API is enabled"
  value       = var.enable_play_console
}
