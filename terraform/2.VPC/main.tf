module "network" {
  source = "../Modules/network"

  project_id = var.project-id
  region     = var.region
}