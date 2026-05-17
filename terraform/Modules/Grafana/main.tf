resource "google_compute_instance" "grafana_vm" {
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

   metadata = {
  gce-container-declaration = <<EOT
spec:
  containers:
    - name: grafana
      image: grafana/grafana:latest
      ports:
        - containerPort: 3000
          hostPort: 3000
  restartPolicy: Always
EOT
}
}

# Unmanaged Instance Group
resource "google_compute_instance_group" "umg" {
  name        = "umg-backend"

  instances = [
    google_compute_instance.grafana_vm.id
  ]

  named_port {
    name = "http"
    port = "3000"
  }

  zone = var.zone
}

# Health Check
resource "google_compute_health_check" "grafana_hc" {
  name = "grafana-health-check"

  timeout_sec        = 5
  check_interval_sec = 10

  http_health_check {
    port         = 3000
    request_path = "/login"
  }
}

# Backend Service
resource "google_compute_backend_service" "grafana_backend" {
  name                  = "grafana-backend-service"
  protocol              = "HTTP"
  port_name             = "http"
  timeout_sec           = 30
  load_balancing_scheme = "EXTERNAL"

  health_checks = [
    google_compute_health_check.grafana_hc.id
  ]

  backend {
    group = google_compute_instance_group.umg.id
  }
}

# URL Map
resource "google_compute_url_map" "grafana_urlmap" {
  name            = "grafana-url-map"
  default_service = google_compute_backend_service.grafana_backend.id
}

# Target HTTP Proxy
resource "google_compute_target_http_proxy" "grafana_proxy" {
  name    = "grafana-http-proxy"
  url_map = google_compute_url_map.grafana_urlmap.id
}

# Forwarding Rule
resource "google_compute_global_forwarding_rule" "grafana_forwarding_rule" {
  name                  = "grafana-forwarding-rule"
  target                = google_compute_target_http_proxy.grafana_proxy.id
  port_range            = "80"
  load_balancing_scheme = "EXTERNAL"
  # ip_address            = google_compute_global_address.lb_ip.address
}

# output "grafana_url" {
#   value = "http://${google_compute_global_address.lb_ip.address}"
# }