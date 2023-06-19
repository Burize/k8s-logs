terraform {
  backend "gcs" {
    bucket  = "k8s-logs-terraform"
    prefix  = "terraform-state/k8s-logs"
  }
}