variable "bucket_name" {
  description = "Name of the GCS bucket"
  type        = string
}

variable "location" {
  description = "Location for the bucket"
  type        = string
}

variable "force_destroy" {
  description = "Allow bucket to be destroyed even if not empty"
  type        = bool
  default     = false
}

variable "versioning_enabled" {
  description = "Enable versioning for the bucket"
  type        = bool
  default     = true
}

variable "lifecycle_rules" {
  description = "Lifecycle rules for the bucket"
  type = list(object({
    condition = object({
      age                = optional(number)
      num_newer_versions = optional(number)
      with_state         = optional(string)
    })
    action = object({
      type          = string
      storage_class = optional(string)
    })
  }))
  default = []
}

variable "labels" {
  description = "Labels to apply to the bucket"
  type        = map(string)
  default     = {}
}
