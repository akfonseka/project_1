# Storage bucket for raw data 
module "storage_bucket" {
    source = "./modules/storage/"
    google_storage_bucket_name = var.raw_storage_bucket
    bucket_location = var.gcp_region
    storage_class = var.storage_class 
    force_destroy = var.allow_data_deletion_on_tf_destroy
    bucket_access = var.uniform_bucket_access 
    lifecycle_age = var.lifecycle_age
    action_type = var.action_type
  
}