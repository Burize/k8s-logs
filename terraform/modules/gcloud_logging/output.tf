output "writer_sink_identity" {
  description = "The writer identity associated with this sink"
  value = google_logging_project_sink.logs_sink.writer_identity
}