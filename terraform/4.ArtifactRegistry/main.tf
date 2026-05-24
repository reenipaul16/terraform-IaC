module "ar" {
  source = "../Modules/ArtifactRegistry"

  project_id = var.project_id
  location = var.location
  repository_id = var.repository_id

}