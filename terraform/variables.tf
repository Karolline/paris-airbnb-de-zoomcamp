variable "project_id" {
  description = "The GCP project ID"
  type        = string

}

variable "gcs_bucket_name" {
  description = "The GCS bucket name"
  type        = string
}

variable "bq_dataset_id" {
  description = "The BigQuery dataset id"
  type        = string
}

variable "region" {
  description = "GCP region for resources"
  type        = string
  default     = "us-central1"
}
