terraform {
  source = "../modules//gcloud_logging"
}

include {
  path = find_in_parent_folders()
}

inputs = {
  gc_project_id = get_env("GOOGLE_PROJECT_ID")
  topic_id = "topic_logs_to_datadog"
  sink_name = "sink_logs_to_datadog"
  subscription_name= "subscription_logs_to_datadog"
  datadog_api_key= get_env("DATADOG_API_KEY")
}

