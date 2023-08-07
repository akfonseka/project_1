# Storage bucket for raw data 
module "raw_storage_bucket" {
  source                     = "./modules/storage_bucket/"
  google_storage_bucket_name = local.raw_storage_bucket_name
  gcp_project_id             = var.gcp_project_id
  bucket_location            = var.gcp_region
  storage_class              = var.storage_class
  force_destroy              = var.allow_data_deletion_on_tf_destroy
  uniform_bucket_access      = var.uniform_bucket_access
  lifecycle_age              = var.lifecycle_age
  action_type                = var.action_type

}


module "transformed_storage_bucket" {
  source                     = "./modules/storage_bucket/"
  google_storage_bucket_name = local.transformed_storage_bucket_name
  gcp_project_id             = var.gcp_project_id
  bucket_location            = var.gcp_region
  storage_class              = var.storage_class
  force_destroy              = var.allow_data_deletion_on_tf_destroy
  uniform_bucket_access      = var.uniform_bucket_access
  lifecycle_age              = var.lifecycle_age
  action_type                = var.action_type

}


module "cluster_staging_bucket" {
  source                     = "./modules/storage_bucket"
  google_storage_bucket_name = local.cluster_staging_bucket_name
  gcp_project_id             = var.gcp_project_id
  bucket_location            = var.gcp_region
  storage_class              = var.storage_class
  force_destroy              = var.allow_data_deletion_on_tf_destroy
  uniform_bucket_access      = var.uniform_bucket_access
  lifecycle_age              = var.lifecycle_age
  action_type                = var.action_type

}


module "bq_dataset" {
  source                = "./modules/bq_dataset"
  bq_dataset_id         = local.bq_dataset_id
  dataset_friendly_name = local.dataset_friendly_name
  dataset_description   = local.dataset_description
  dataset_location      = var.gcp_region

}


module "dataproc_cluster" {
  source                 = "./modules/dataproc_cluster"
  cluster_name           = local.cluster_name
  region                 = var.gcp_region
  cluster_staging_bucket = local.cluster_staging_bucket_name
  master_num             = 1
  master_machine_type    = "n1-standard-4"
  master_disk_size       = 50
  worker_num             = 2
  preemptible_worker_num = 0
  optional_components    = local.optional_components
}

