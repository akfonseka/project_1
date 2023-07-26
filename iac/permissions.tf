resource "google_service_account" "sa" {
    account_id = local.google_service_account
    display_name = "Project Service Account"  
}

resource "google_service_account_iam_binding" "storage-acccount-iam" {
    service_account_id = google_service_account.sa.email
    role = "roles/storage.admin"  
}

resource "google_service_account_iam_binding" "bigquery-account-iam" {
    service_account_id = google_service_account.sa.email
    role = "roles/bigquery.admin"   
}

resource "google_service_account_iam_binding" "user-account-iam" {
    service_account_id = google_service_account.sa.email
    role = "roles/iam.serviceAccountUser"

    members = [
        local.user_email
    ]
}