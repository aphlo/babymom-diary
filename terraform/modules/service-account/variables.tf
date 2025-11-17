variable "project_id" {
  description = "GCP Project ID"
  type        = string
}

variable "account_id" {
  description = "Service account ID"
  type        = string
}

variable "display_name" {
  description = "Display name for the service account"
  type        = string
}

variable "description" {
  description = "Description of the service account"
  type        = string
  default     = ""
}

variable "roles" {
  description = "List of IAM roles to grant to the service account"
  type        = list(string)
  default     = []
}
