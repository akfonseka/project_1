variable "google_storage_bucket_name" {
    description = "Name of the GCP Storage Bucket"     
}

variable "bucket_location" {
    description = "Location of the Storage Bucket"  
}

variable "storage_class" {
    description = "Choose between REGIONAL etc." 
}

variable "bucket_access" {
    description = "Level of access granted to the bucket" 
}

variable "lifecycle_age" {
    description = "Age of object inside the bucket at the time of action"  
}

variable "action_type" {
  
}