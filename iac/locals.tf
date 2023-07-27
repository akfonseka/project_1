locals {
  raw_storage_bucket_name = format("%s-%s", var.gcp_project_id, "data-bronze-bucket")
  transformed_storage_bucket_name = format("%s-%s", var.gcp_project_id, "data-silver-bucket")
  google_service_account = format("%s-%s", var.gcp_project_id, "sa")

}