
resource "google_bigquery_dataset" "dataset" {
  for_each = var.datasets
  project                    = var.project
  dataset_id                 = each.value
  location                   = "EU"
  delete_contents_on_destroy = true
}

# Create an Artifact Registry repository
resource "google_artifact_registry_repository" "docker_repo" {
  repository_id = "example-repository-dbt"
  format        = "DOCKER"
  location      = var.location
  project       = var.project
}

# Create a Cloud Run Job
resource "google_cloud_run_v2_job" "dbt_job" {
  name     = "cloudrun-job-dbt"
  location = var.location
  project  = var.project

  template {
    template {
      service_account = google_service_account.sa-dbt.email
      max_retries     = 1
      volumes {
        name = "a-volume"
        secret {
          secret       = google_secret_manager_secret.secret.secret_id
          default_mode = 0 # 0444
          items {
            version = "latest"
            path    = google_secret_manager_secret.secret.secret_id
            mode    = 0 # 0400
          }
        }
      }
      containers {
        image = "${google_artifact_registry_repository.docker_repo.location}-docker.pkg.dev/${var.project}/${google_artifact_registry_repository.docker_repo.name}/cloudrun-dbt-v2:latest"
        volume_mounts {
          name       = "a-volume"
          mount_path = "/secrets"
        }
      }
    }
  }
  depends_on = [
    google_secret_manager_secret_version.secret-version,
    google_secret_manager_secret_iam_member.secret-access,
  ]
}

resource "google_secret_manager_secret" "secret" {
  project   = var.project
  secret_id = "dbt-secret-auth"
  replication {
    auto {}
  }
}
resource "google_service_account_key" "example_key" {
  service_account_id = google_service_account.sa-dbt.id
}

resource "google_secret_manager_secret_version" "secret-version" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = base64decode(google_service_account_key.example_key.private_key)
}

resource "google_service_account" "sa-dbt" {
  project      = var.project
  account_id   = "dbt-sa"
  display_name = "Test Service Account for DBT"
}

resource "google_cloud_run_v2_job_iam_member" "job_invoker" {
  project  = var.project
  location = var.location
  name     = google_cloud_run_v2_job.dbt_job.name
  role     = "roles/run.invoker"
  member   = "serviceAccount:${google_service_account.sa-dbt.email}"
}

resource "google_project_iam_member" "data_editor" {
  project = var.project
  role    = "roles/bigquery.dataEditor"
  member  = "serviceAccount:${google_service_account.sa-dbt.email}"
}

resource "google_project_iam_member" "job_user" {
  project = var.project
  role    = "roles/bigquery.jobUser"
  member  = "serviceAccount:${google_service_account.sa-dbt.email}"
}

resource "google_secret_manager_secret_iam_member" "secret-access" {
  secret_id  = google_secret_manager_secret.secret.id
  role       = "roles/secretmanager.secretAccessor"
  member     = "serviceAccount:${google_service_account.sa-dbt.email}"
  depends_on = [google_secret_manager_secret.secret]
}

data "google_project" "project" {
  project_id = var.project
}