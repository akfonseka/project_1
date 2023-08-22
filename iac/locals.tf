locals {
  raw_storage_bucket_name = format(
    "%s-%s"
    , var.gcp_project_id
  , "data-bronze-bucket")
  transformed_storage_bucket_name = format(
    "%s-%s",
    var.gcp_project_id,
    "data-silver-bucket"
  )
  cluster_staging_bucket_name = format(
    "%s-%s"
    , var.gcp_project_id
    , "cluster-stg-bucket"
  )
  cluster_temp_bucket_name = format(
    "%s-%s"
    , var.gcp_project_id
    , "cluster-tmp-bucket"
  )
  code_bucket_name = format(
    "%s-%s"
    , var.gcp_project_id
    , "code-bucket"
  )
  google_service_account = format(
    "%s-%s",
    var.gcp_project_id,
    "sa"
  )
  spark_dataset_id = format(
    "%s_%s",
    var.gcp_project_id
    , "spark"
  )
  spark_friendly_name = "Spark Dataset"
  spk_dataset_desc   = "Dataset for loading data into BQ with Spark"
  cluster_name = format(
    "%s-%s"
    , var.gcp_project_id
    , "cluster"
  )
  models_dataset_id = format(
    "%s_%s"
    ,var.gcp_project_id
    ,"models"
  )
  models_friendly_name = "Models Dataset"
  models_dataset_desc = "Dataset for dbt modlels"
  prod_dataset_id = format(
    "%s_%s"
    ,var.gcp_project_id
    ,"production"    
  )
  prod_friendly_name = "Production Dataset"
  prod_dataset_desc = "Dataset for dbt production"
  stg_dataset_id = format(
    "%s_%s"
    ,var.gcp_project_id
    ,"staging"
  )
  stg_friendly_name = "Staging Dataset"
  stg_dataset_desc = "Dataset for dbt staging"
  optional_component_1 = "DOCKER"
  optional_component_2 = "JUPYTER"
}