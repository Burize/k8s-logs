module "gc_logging" {
  source = "./modules/gcloud_logging"
  gc_project_id = var.gc_project_id
  topic_name = "topic_logs_to_datadog"
  sink_name = "sink_logs_to_datadog"
  subscription_name= "subscription_logs_to_datadog"
  datadog_api_key= var.datadog_api_key
  datadog_site= var.datadog_site
}


output "writer_sink_identity" {
  description = "The writer identity associated with this sink"
  value = module.gc_logging.writer_sink_identity
}