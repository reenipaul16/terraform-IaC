resource "google_compute_network" "vpc" {
  name                    = var.network_name
  project                 = var.project_id
  auto_create_subnetworks = false
}

resource "google_compute_subnetwork" "subnet" {
  name          = var.subnet_name
  project       = var.project_id
  region        = var.region
  network       = google_compute_network.vpc.id
  ip_cidr_range = "172.24.10.0/24"

  secondary_ip_range {
    range_name    = "pods"
    ip_cidr_range = "172.25.0.0/16"
  }
  secondary_ip_range {
    range_name    = "services"
    ip_cidr_range = "172.26.0.0/20"
  }
}
