resource "google_storage_bucket" "example" {
    name = var.google_storage_bucket_name
    project = var.gcp_project_id
    location = var.bucket_location
    storage_class = var.storage_class
    force_destroy = var.force_destroy
    uniform_bucket_level_access = var.uniform_bucket_access

    lifecycle_rule {
      condition {
        age = var.lifecycle_age
      }
      action {
        type = var.action_type
      }
    }
  
}