resource "google_project_service" "project" {
 for_each = toset([
  "iam.googleapis.com", 
  "compute.googleapis.com", 
  "storage.googleapis.com", 
  "gkehub.googleapis.com", 
  "container.googleapis.com", 
  # "loadbalancer.googleapis.com",
  "logging.googleapis.com",
  "monitoring.googleapis.com"
 ])

  project= "project-06cede75-fb8e-4bfb-984"
  service    = each.key
}