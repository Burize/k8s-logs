provider "google" {
  project = var.gc_project_id
}

resource "google_pubsub_topic" "logs_topic" {
  name = var.topic_id
}

resource "google_project_iam_member" "roles" {
  project = var.gc_project_id
  role = "roles/pubsub.publisher"
  member = "serviceAccount:cloud-logs@system.gserviceaccount.com"
}

resource "google_logging_project_sink" "logs_sink" {
  name = var.sink_name
  destination = "pubsub.googleapis.com/projects/${var.gc_project_id}/topics/${var.topic_id}"
  filter = "resource.type = k8s_container AND resource.labels.container_name != agent AND resource.labels.container_name != konnectivity-agent AND resource.labels.container_name != process-agent AND resource.labels.container_name != trace-agent AND resource.labels.container_name != cluster-agent AND resource.labels.container_name != fluentbit-gke"

  depends_on = [
    google_pubsub_topic.logs_topic
 ]
}

resource "google_pubsub_subscription" "logs_subscription" {
  topic = var.topic_id
  name = var.subscription_name

  push_config {
    push_endpoint = "https://gcp-intake.logs.us3.datadoghq.com/api/v2/logs?dd-api-key=${var.datadog_api_key}&dd-protocol=gcp"
  }

  depends_on = [
    google_pubsub_topic.logs_topic
 ]
}