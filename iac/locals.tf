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
  google_service_account = format(
    "%s-%s",
    var.gcp_project_id,
    "sa"
  )
  bq_dataset_id = format(
    "%s_%s",
    var.gcp_project_id
    , "dataset"
  )
  dataset_friendly_name = "Project Dataset"
  dataset_description   = "Dataset for loading data into BQ"
  cluster_name = format(
    "%s-%s"
    , var.gcp_project_id
    , "cluster"
  )
  optional_components = "Docker, Jupyter Notebook"
}