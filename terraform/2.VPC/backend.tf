terraform {
  backend "gcs" {
    bucket  = "terraform-state-b"
    prefix  = "terraform/tf-state/vpc"
  }
}