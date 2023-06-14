variable gc_project_id {
  type = string
  description = "ID of a google cloud project"
}

variable topic_name {
  type = string
  description = "Pub/Sub topic name"
}

variable sink_name {
  type = string
  description = "Logging sink name"
}

variable subscription_name {
  type = string
  description = "Name of a subscription to subscribe to a Pub/Sub Topic"
}

variable datadog_api_key {
  type = string
  description = "Datadog API key"
}

variable datadog_site {
  type = string
  description = "Datadog site. This service provides several regions"
}