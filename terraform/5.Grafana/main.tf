module "vm" {
  source = "../Modules/Grafana"

  project_id = var.project_id
  vm_name = var.vm_name
  zone       = var.zone
  machine_type = var.machine_type
  network_name = var.network_name
  subnet_name = var.subnet_name

}
