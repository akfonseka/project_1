variable "google_storage_bucket_name" {
    description = "Name of the GCP Storage Bucket"     
}

variable "gcp_project_id" {
    description = "Project ID to create the resource in"
  
}

variable "bucket_location" {
    description = "Location of the Storage Bucket"  
}

variable "storage_class" {
    description = "Choose between REGIONAL etc." 
}

variable "force_destroy" {
    description = "Boolean value representing whether the resource will be deleted on with tf destroy" 
}

variable "uniform_bucket_access" {
    description = "Level of access granted to the bucket" 
}

variable "lifecycle_age" {
    description = "Age of object inside the bucket at the time of action"  
}

variable "action_type" {
    description = "Type of action to carry out on object at end of lifecycle age"  
}