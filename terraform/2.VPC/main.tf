module "network" {
  source = "../Modules/VPC"

  project_id = var.project-id
  region     = var.region
  network_name= var.network_name
  subnet_name = var.subnet_name

}