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

variable "raw_storage_bucket" {
    description = "Name of storage bucket for raw data"  
}

variable "storage_class" {
    description = "Class of Storage bucket"  
}

variable "uniform_bucket_access" {
    description = "Level of access to bucket"     
}

variable "allow_data_deletion_on_tf_destroy" {
    description = "Can resource be deleted using tf destroy and associated data"  
}

variable "lifecycle_age" {
    description = "Age (in days) of resource when action is carried out"
}

variable "action_type" {
    description = "Action to carry out when resource reaches end of lifecycle" 
}

