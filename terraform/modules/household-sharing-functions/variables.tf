variable "location" {
  description = "Location/region for the functions"
  type        = string
}

variable "runtime" {
  description = "Runtime for the functions (e.g., nodejs22)"
  type        = string
  default     = "nodejs22"
}

variable "source_bucket" {
  description = "GCS bucket containing source code"
  type        = string
}

variable "source_object" {
  description = "GCS object name for source code"
  type        = string
}

variable "service_account_email" {
  description = "Service account email for the functions"
  type        = string
}

variable "max_instance_count" {
  description = "Maximum number of instances"
  type        = number
  default     = 10
}

variable "min_instance_count" {
  description = "Minimum number of instances"
  type        = number
  default     = 0
}

variable "available_memory" {
  description = "Available memory for the functions"
  type        = string
  default     = "256M"
}

variable "timeout_seconds" {
  description = "Timeout in seconds"
  type        = number
  default     = 60
}

variable "environment_variables" {
  description = "Environment variables for the functions"
  type        = map(string)
  default     = {}
}

variable "labels" {
  description = "Labels to apply to the functions"
  type        = map(string)
  default     = {}
}
