remote_state {
  backend = "gcs"

  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }

  config = {
    bucket  = get_env("GCS_BUCKET_NAME")
    project = get_env("GOOGLE_PROJECT_ID")
    prefix  = "terraform-state/${path_relative_to_include()}/"
    location  = get_env("GOOGLE_PROJECT_REGION", "us-east1")
  }
}