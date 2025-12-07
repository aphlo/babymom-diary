variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "enable_cloud_functions" {
  description = "Enable Cloud Functions related APIs"
  type        = bool
  default     = false
}

variable "enable_firebase_appcheck" {
  description = "Enable Firebase App Check API"
  type        = bool
  default     = false
}

variable "enable_play_console" {
  description = "Enable Google Play Android Developer API"
  type        = bool
  default     = false
}
