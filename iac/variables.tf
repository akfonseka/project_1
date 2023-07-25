variable "gcp_project_id"   {
    description = "GCP Project ID"
    }

variable "gcp_region"       {
    description = "Region associated with GCP project"
    default = "europe-west2" 
    }

variable "python_runtime"   {
    default = "python310"
    }