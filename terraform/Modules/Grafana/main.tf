resource "google_compute_instance" "vm" {
  name         = var.vm_name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = "cos-cloud/cos-stable"
    }
  }

  network_interface {
    network    = var.network_name
    subnetwork = var.subnet_name
    # No external IP
    network_ip = "172.24.10.50"
  }

  metadata_startup_script = {
    gce-container-declaration = <<EOT
      spec:
        containers:
         - name: grafana
           image: grafana/grafana:latest
           ports:
            - containerPort: 3000
              hostPort: 3000
     EOT
  }
}

# Unmanaged Instance Group
resource "google_compute_instance_group" "umg" {
  name        = "umg-backend"

  instances = [
    google_compute_instance.vm.id
  ]

  named_port {
    name = "http"
    port = "3000"
  }

  zone = var.zone
}