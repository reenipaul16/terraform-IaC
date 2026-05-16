resource "google_project_service" "project" {
  project = var.project-id
  service = var.services
  
}