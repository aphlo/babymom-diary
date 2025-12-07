variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
}

variable "source_dir" {
  description = "Path to Cloud Functions source code directory"
  type        = string
}

variable "runtime" {
  description = "Runtime for the functions (e.g., nodejs22)"
  type        = string
  default     = "nodejs22"
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
  description = "Labels to apply to resources"
  type        = map(string)
  default     = {}
}
