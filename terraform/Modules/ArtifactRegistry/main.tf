resource "google_artifact_registry_repository" "app_repository" {
  location      = var.location
  repository_id = var.repository_id
  format        = "DOCKER"
}