variable "gc_project_id" {
  description = "The project ID"
  type        = string
}

variable "gcs_bucket_name" {
  description = "Google cloud storage bucket name"
  type        = string
}

variable datadog_api_key {
  type = string
  description = "Datadog API key"
  sensitive= true
}

variable datadog_site {
  type = string
  description = "Datadog site. This service provides several regions"
  default = "us3.datadoghq.com"
}