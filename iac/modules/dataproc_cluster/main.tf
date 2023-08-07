resource "google_dataproc_cluster" "spark_cluster" {
    name = var.cluster_name
    region = var.region
    graceful_decommission_timeout = "300s"

    cluster_config {
      staging_bucket = var.cluster_staging_bucket

      master_config {
        num_instances = var.master_num 
        machine_type = var.master_machine_type
        disk_config {
          boot_disk_size_gb = var.master_disk_size
        }
      }

      worker_config {  # Updateable 
        num_instances = var.worker_num
      }

      preemptible_worker_config { # Updateable
        num_instances = var.preemptible_worker_num
      }

      software_config {
        optional_components = [
          var.optional_components
        ]
      }
    }


  
}