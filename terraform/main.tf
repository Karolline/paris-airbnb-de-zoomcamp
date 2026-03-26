provider "google" {
  project     = var.project_id
  region      = var.region

}

resource "google_storage_bucket" "paris_airbnb_datalake" {
  name          = var.gcs_bucket_name
  location      = "US-CENTRAL1"
  storage_class = "STANDARD"
  force_destroy = true # Only for development/testing, remove in production
}

resource "google_bigquery_dataset" "paris_airbnb_raw" {
  dataset_id = "raw"
  project    = var.project_id
  location   = var.region # Using region variable
}

resource "google_bigquery_dataset" "paris_airbnb_staging" {
  dataset_id = "staging"
  project    = var.project_id
  location   = var.region # Using region variable
}

resource "google_bigquery_dataset" "paris_airbnb_intermediate" {
  dataset_id = "intermediate"
  project    = var.project_id
  location   = var.region # Using region variable
}

resource "google_bigquery_dataset" "paris_airbnb_marts" {
  dataset_id = "marts"
  project    = var.project_id
  location   = var.region # Using region variable
}