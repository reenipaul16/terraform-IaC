module "network" {
  source = "./Modules/network"

  project_id = var.project_id
  region     = var.region
}