import os
from pathlib import Path
from kaggle.api.kaggle_api_extended import KaggleApi
from google.cloud import storage

# Configuration
KAGGLE_AUTH_FILE = "~/.kaggle/kaggle.json"
PROJECT_ID = os.getenv("TF_VAR_project_id")
BUCKET_NAME = os.environ.get("TF_VAR_gcs_bucket_name")
DATASET_NAME = "paris-airbnb-data"

RAW_DATA_DIR = Path("data")

def download_kaggle_dataset(dataset_name: str, path: Path):
    if path.exists():
        import shutil
        shutil.rmtree(path)
    path.mkdir(parents=True, exist_ok=True)
    api = KaggleApi()
    api.authenticate()
    api.dataset_download_files(dataset_name, path=path, unzip=True)
    print(f"Dataset {dataset_name} downloaded to {path}")

def upload_to_gcs(bucket_name: str, project_id: str, directory_path: Path):
    client = storage.Client(project=project_id)
    bucket = client.bucket(bucket_name)

    print(f"Uploading to bucket: {bucket_name}")

    for file_path in directory_path.rglob('*.csv'):
        print(f"Uploading {file_path.name}...")
        destination_blob_name = f"raw/{file_path.name}"
        blob = bucket.blob(destination_blob_name)
        if blob.exists():
            print(f"Deleting existing blob: {destination_blob_name}")
            blob.delete()

        blob.upload_from_filename(os.path.expanduser(file_path))
        print(f"File {file_path.name} uploaded to gs://{bucket_name}/{destination_blob_name}")

if __name__ == "__main__":
    # Ensure Kaggle authentication file exists
    if not os.path.exists(os.path.expanduser(KAGGLE_AUTH_FILE)):
        print(f"Error: Kaggle authentication file not found at {os.path.expanduser(KAGGLE_AUTH_FILE)}")
        print("Please ensure you have configured your Kaggle API credentials.")
    else:
        download_kaggle_dataset("mysarahmadbhat/airbnb-listings-reviews", RAW_DATA_DIR)
        upload_to_gcs(BUCKET_NAME, PROJECT_ID, RAW_DATA_DIR)
        print("success!")
