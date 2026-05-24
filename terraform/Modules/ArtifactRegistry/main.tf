resource "google_artifact_registry_repository" "app_repository" {
  location      = var.location
  repository_id = var.repository_id
  format        = "DOCKER"
}

locals {
  artifact_registry_import_id = "projects/${var.project_id}/locations/${var.location}/repositories/${var.repository_id}"
}

import {
  to = google_artifact_registry_repository.repo_app
  id = local.artifact_registry_import_id
}