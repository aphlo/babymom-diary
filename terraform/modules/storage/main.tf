resource "google_storage_bucket" "bucket" {
  name                        = var.bucket_name
  location                    = var.location
  uniform_bucket_level_access = true
  force_destroy               = var.force_destroy

  versioning {
    enabled = var.versioning_enabled
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rules
    content {
      condition {
        age                = lifecycle_rule.value.condition.age
        num_newer_versions = lifecycle_rule.value.condition.num_newer_versions
        with_state         = lifecycle_rule.value.condition.with_state
      }
      action {
        type          = lifecycle_rule.value.action.type
        storage_class = lifecycle_rule.value.action.storage_class
      }
    }
  }

  labels = var.labels
}
