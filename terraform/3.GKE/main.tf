module "gke" {
  source = "../Modules/GKE"

  project_id = var.project_id
  region     = var.region
  zone       = var.zone
  network_name    = var.network_name
  subnet_name = var.subnet_name

  cluster_name = var.cluster_name
  node_count = var.node_count
  machine_type = var.machine_type

}