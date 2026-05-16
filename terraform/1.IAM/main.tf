resource "google_project_iam_binding" "project" {
  project = var.project-id
  role    = "roles/owner"

  members = [
    "user:duttareshab1@gmail.com"
  ]
}