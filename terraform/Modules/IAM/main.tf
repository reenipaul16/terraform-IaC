resource "google_project_iam_binding" "project" {
  project = var.project-id
  role    = "roles/compute.admin"

  members = [
    "user:duttareshab1@gmail.com"
  ]
}

