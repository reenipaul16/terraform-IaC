terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "7.32.0"
    }
  }
}

provider "google" {
  project =  "project-06cede75-fb8e-4bfb-984"
  #region  = var.region
  #zone    = var.zone
}