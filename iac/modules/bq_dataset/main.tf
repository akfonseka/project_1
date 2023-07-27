resource "google_bigquery_dataset" "bq_dataset" {
    dataset_id = var.bq_dataset_id
    friendly_name = var.dataset_friendly_name
    description = var.dataset_description
    location = var.dataset_location  
}

