resource "google_project_service" "project" {
project=var.project
  service = var.services

}