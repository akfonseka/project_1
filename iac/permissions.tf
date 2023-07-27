data "google_service_account" "sa" {
    account_id = local.google_service_account
    project = var.gcp_project_id  
}

resource "google_service_account_iam_member" "user-account-iam" {
    service_account_id = data.google_service_account.sa.name
    role = "roles/iam.serviceAccountUser"
    member = local.user_email
}