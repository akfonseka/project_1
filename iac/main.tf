# Storage bucket for raw data 
module "raw_storage_bucket" {
    source = "./modules/storage_bucket/"
    google_storage_bucket_name = local.raw_storage_bucket_name
    gcp_project_id = var.gcp_project_id
    bucket_location = var.gcp_region
    storage_class = var.storage_class 
    force_destroy = var.allow_data_deletion_on_tf_destroy
    uniform_bucket_access = var.uniform_bucket_access 
    lifecycle_age = var.lifecycle_age
    action_type = var.action_type
  
}


module "transformed_storage_bucket" {
    source = "./modules/storage_bucket/"
    google_storage_bucket_name = local.transformed_storage_bucket_name
    gcp_project_id = var.gcp_project_id
    bucket_location = var.gcp_region
    storage_class = var.storage_class 
    force_destroy = var.allow_data_deletion_on_tf_destroy
    uniform_bucket_access = var.uniform_bucket_access 
    lifecycle_age = var.lifecycle_age
    action_type = var.action_type
   
}