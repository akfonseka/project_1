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

# Storage bucket for transformed data
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

# Code storage bucket
module "code_bucket" {
  source                     = "./modules/storage_bucket"
  google_storage_bucket_name = local.code_bucket_name
  gcp_project_id             = var.gcp_project_id
  bucket_location            = var.gcp_region
  storage_class              = var.storage_class
  force_destroy              = var.allow_data_deletion_on_tf_destroy
  uniform_bucket_access      = var.uniform_bucket_access
  lifecycle_age              = var.lifecycle_age
  action_type                = var.action_type
}

# BQ Dataset for Spark Data
module "bq_dataset" {
  source                = "./modules/bq_dataset"
  bq_dataset_id         = local.spark_dataset_id
  dataset_friendly_name = local.spark_friendly_name
  dataset_description   = local.spk_dataset_desc
  dataset_location      = var.gcp_region  
}


# DBT BQ resources
module "dbt_models_dataset" {
  source = "./modules/bq_dataset"
  bq_dataset_id         = local.models_dataset_id
  dataset_friendly_name = local.models_friendly_name
  dataset_description   = local.models_dataset_desc
  dataset_location      = var.gcp_region  
}

module "dbt_prod_dataset" {
  source = "./modules/bq_dataset"
  bq_dataset_id         = local.prod_dataset_id
  dataset_friendly_name = local.prod_friendly_name
  dataset_description   = local.prod_dataset_desc
  dataset_location      = var.gcp_region    
}

module "dbt_stage_dataset" {
  source = "./modules/bq_dataset"
  bq_dataset_id         = local.stg_dataset_id
  dataset_friendly_name = local.stg_friendly_name
  dataset_description   = local.stg_dataset_desc
  dataset_location      = var.gcp_region    
}


# Dataproc Cluster Resources
# module "dataproc_cluster" {
#   source                 = "./modules/dataproc_cluster"
#   cluster_name           = local.cluster_name
#   region                 = var.gcp_region
#   cluster_staging_bucket = local.cluster_staging_bucket_name
#   cluster_temp_bucket    = local.cluster_temp_bucket_name
#   master_num             = 1
#   master_machine_type    = "n1-standard-4"
#   master_disk_size       = 50
#   worker_num             = 2
#   preemptible_worker_num = 0
#   optional_components    = local.optional_component_1
#   initialisation_script  = var.initialisation_script
# }

# module "cluster_staging_bucket" {
#   source                     = "./modules/storage_bucket"
#   google_storage_bucket_name = local.cluster_staging_bucket_name
#   gcp_project_id             = var.gcp_project_id
#   bucket_location            = var.gcp_region
#   storage_class              = var.storage_class
#   force_destroy              = var.allow_data_deletion_on_tf_destroy
#   uniform_bucket_access      = var.uniform_bucket_access
#   lifecycle_age              = var.lifecycle_age
#   action_type                = var.action_type
# }


# module "cluster_temp_bucket" {
#   source                     = "./modules/storage_bucket"
#   google_storage_bucket_name = local.cluster_temp_bucket_name
#   gcp_project_id             = var.gcp_project_id
#   bucket_location            = var.gcp_region
#   storage_class              = var.storage_class
#   force_destroy              = var.allow_data_deletion_on_tf_destroy
#   uniform_bucket_access      = var.uniform_bucket_access
#   lifecycle_age              = var.lifecycle_age
#   action_type                = var.action_type
# }
