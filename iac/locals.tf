locals {
  raw_storage_bucket_name = format("%s-%s", var.gcp_project_id, "data-bronze-bucket")
}