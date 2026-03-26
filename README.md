# paris-airbnb-de-zoomcamp

## Description
🇫🇷 Paris Airbnb Data Analysis: Enclos-St-Laurent
This project is part of the Data Engineering Zoomcamp, focusing on building an end-to-end data pipeline to analyze Airbnb listing and review data in the Enclos-St-Laurent (10th Arrondissement) area of Paris.

📊 Key Visualizations & Analytics
The objective of this analysis is to provide insights into the local accommodation market and the impact of global events on tourism through the following visualizations:

1. Distribution of Room Types
Format: Pie Chart

Description: A breakdown of Airbnb accommodations near Enclos-St-Laurent by room type (e.g., Entire home/apt, Private room, Hotel room, Shared room).

Insight: This chart identifies the dominant type of rental inventory in this high-traffic transit hub.

2. Comparative Monthly Review Trends (2019 vs. 2020)
Format: Stacked Bar Chart (Time-series)

Description: Monthly review counts for the most-reviewed specific hotel/listing in the area.

[Airbnb - Sweet & cosy room next to Canal Saint Martin](https://www.airbnb.co.kr/rooms/17222007)

Data Strategy: The chart stacks 2019 and 2020 data to highlight seasonal trends and the significant impact of the COVID-19 pandemic on travel activity.

Engineering Focus: This involves complex data aggregation using BigQuery and dbt to align disparate yearly data into a single temporal view.


## Data Source
[Kaggle - Airbnb Listings & Reviews](https://www.kaggle.com/datasets/mysarahmadbhat/airbnb-listings-reviews)

## Skills
- GCP
- terraform
- dbt
- Cline + Google AI Stduio Gemini 2.5 Pro


## 📊 Data Flow & Conventions

This project follows a structured data pipeline that ingests raw data from local storage to Google Cloud Storage (GCS). All resources are managed using a strict **Naming Convention** for consistency and scalability.

### 1. Resource Details

| Component | Path / Name |
| :--- | :--- |
| **Local Data Path** | `data/Airbnb Data` |
| **GCP Project ID** | `paris-airbnb-de-zoomcamp` |
| **GCS Bucket Name** | `datalake-paris-airbnb-de-zoomcamp` |
| **GCS Data Path** | `raw` |
| **BigQuery Dataset Name for External Table** | `raw` |
| **BigQuery Dataset Name for Staging Table** | `staging` |

---

### 2. Naming Conventions

To ensure global uniqueness and maintainable infrastructure, the following conventions are applied:

> #### 🪣 Bucket Naming Convention
> * **Format:** `paris-airbnb-datalake-${project_id}`
> * **Description:** We append the `project_id` as a suffix to ensure the GCS bucket name is globally unique.
> * **Result:** `paris-airbnb-datalake-`**paris-airbnb-de-zoomcamp**

> #### 📂 Data Path Convention
> * **Format:** `${bucket_name}/raw`
> * **Description:** Raw data is stored in a dedicated `raw` directory within the bucket to preserve the original state (Immutable Data Lake).
> * **Result:** `paris-airbnb-datalake-paris-airbnb-de-zoomcamp/raw`

---

### 3. Pipeline Steps
1. **Extract**: Download raw CSV files into the `data/Airbnb Data` directory using the Kaggle API.
2. **Load**: Upload local files to the GCS bucket under the `/raw` path using the `ingest.py` Python script.
3. **Transform (Upcoming)**: Process the raw data into analytical models using **dbt** and **BigQuery**.

## Prerequisites
1. Kaggle key file
2. gcp key file

## Getting Started
1. Google Cloud Authentication

   To authenticate your Google Cloud environment, set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable to the path of your GCP key file:

   1. Add the environment variable to your `.bashrc` file by running the following command:
      ```bash
      echo 'export GOOGLE_APPLICATION_CREDENTIALS="/path/to/your/gcp-key.json"' >> ~/.bashrc
      echo 'export TF_VAR_project_id="your-gcp-project-id"' >> ~/.bashrc
      echo 'export TF_VAR_gcs_bucket_name="datalake-${TF_VAR_project_id}"' >> ~/.bashrc
      echo 'export TF_VAR_bq_dataset_id="staging"' >> ~/.bashrc
      ```
   2. Apply the changes by sourcing your `.bashrc` file:
      ```bash
      source ~/.bashrc
      ```

2. kaggle
- Configured your Kaggle API credentials (kaggle.json in ~/.kaggle/).


3. Install Requirements

4. Run Terraform


```bash
terraform -chdir=terraform init
terraform -chdir=terraform plan
terraform -chdir=terraform apply
```

5. Run Python script to ingest data
```bash
python scripts/ingest.py
```

6. dbt
```bash
dbt init paris_airbnb_dbt
dbt compile --project-dir paris_airbnb_dbt
dbt run-operation stage_external_sources --project-dir paris_airbnb_dbt
dbt run --project-dir paris_airbnb_dbt
```
