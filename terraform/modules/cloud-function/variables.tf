variable "function_name" {
  description = "Name of the Cloud Function"
  type        = string
}

variable "location" {
  description = "Location/region for the function"
  type        = string
}

variable "description" {
  description = "Description of the function"
  type        = string
  default     = ""
}

variable "runtime" {
  description = "Runtime for the function (e.g., nodejs22)"
  type        = string
  default     = "nodejs22"
}

variable "entry_point" {
  description = "Entry point function name"
  type        = string
}

variable "source_bucket" {
  description = "GCS bucket containing source code"
  type        = string
}

variable "source_object" {
  description = "GCS object name for source code"
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
  description = "Available memory for the function"
  type        = string
  default     = "256M"
}

variable "timeout_seconds" {
  description = "Timeout in seconds"
  type        = number
  default     = 60
}

variable "service_account_email" {
  description = "Service account email for the function"
  type        = string
}

variable "environment_variables" {
  description = "Environment variables for the function"
  type        = map(string)
  default     = {}
}

variable "event_trigger" {
  description = "Event trigger configuration (for Pub/Sub triggered functions)"
  type = object({
    trigger_region = string
    event_type     = string
    pubsub_topic   = string
    retry_policy   = string
  })
  default = null
}

variable "allow_unauthenticated" {
  description = "Allow unauthenticated invocations"
  type        = bool
  default     = false
}

variable "labels" {
  description = "Labels to apply to the function"
  type        = map(string)
  default     = {}
}
