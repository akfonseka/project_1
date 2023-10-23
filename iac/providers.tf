terraform {
  backend "local" {}

  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.73.0"
    }
  }
}

provider "google" {
  credentials = local.credentials
  project     = var.gcp_project_id
  region      = var.gcp_region
}

