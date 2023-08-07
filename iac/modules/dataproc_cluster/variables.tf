variable "cluster_name" {
    type = string  
}

variable "region" {
    type = string  
}

variable "cluster_staging_bucket" {
    type = string  
}

variable "master_num" {
    type = number  
}

variable "master_machine_type" {
    type = string  
}

variable "master_disk_size" {
    type = number
    default = 50  
}

variable "worker_num" {
    type = number  
}

variable "preemptible_worker_num" {
    type = number
}

variable "optional_components" {
    type = string
  
}