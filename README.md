# gcp-dbt-elt

## Overview

`gcp-dbt-elt` is a project designed to streamline and automate the ELT (Extract, Load, Transform) process using Google Cloud Platform (GCP) services and DBT (Data Build Tool). The project leverages Google Cloud Run to deploy a scalable and serverless environment for executing ELT jobs, while DBT is used to handle data transformation tasks in Bigquery.


## Features

- **BigQuery:** 
- **CloudRun:** 
- **DBT:**

## Prerequisites

- Python
- Docker
- GCP Account
- Google Cloud SDK
- Terraform

## Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/alfonsozamorac/gcp-dbt-elt.git
   cd gcp-dbt-elt
   ```

2. Export your GCP credentials:

   ```bash
   export GOOGLE_APPLICATION_CREDENTIALS="your_credentials_file.json"
   ```

3. Export your GCP project:

   ```bash
   export MY_GCP_PROJECT="your_project_name"
   ```

## Usage example players


1. Replace your project into the files:

   ```bash
   sed -i '' "s/MY_GCP_PROJECT/${MY_GCP_PROJECT}/g" sales_analysis/profiles.yml
   sed -i '' "s/MY_GCP_PROJECT/${MY_GCP_PROJECT}/g" ddl/create_raw.sql
   sed -i '' "s/MY_GCP_PROJECT/${MY_GCP_PROJECT}/g" sales_analysis/models/sources.yml
   sed -i '' "s/MY_GCP_PROJECT/${MY_GCP_PROJECT}/g" infra/variables.tf
   ```

2. Create artifact regitry repository:

   ```bash
   terraform -chdir="./infra" init
   terraform -chdir="./infra" apply --target google_artifact_registry_repository.docker_repo --auto-approve
   ```

3. Create and push Docker Image to GCP:

   ```bash
   cd ./sales_analysis
   docker buildx build --platform linux/amd64 -t cloudrun-dbt-v2:latest .
   docker tag cloudrun-dbt-v2:latest europe-southwest1-docker.pkg.dev/${MY_GCP_PROJECT}/example-repository-dbt/cloudrun-dbt-v2:latest
   docker push europe-southwest1-docker.pkg.dev/${MY_GCP_PROJECT}/example-repository-dbt/cloudrun-dbt-v2:latest
   ```

4. Create the rest of infrastructure:

   ```bash
   cd ..
   terraform -chdir="./infra" apply --auto-approve
   ```

5. Insert RAW Data:

   ```bash
   bq query --project_id=${MY_GCP_PROJECT} --use_legacy_sql=false < ./ddl/create_raw.sql
   ```

6. Execute Job:

   ```bash
   gcloud run jobs execute cloudrun-job-dbt --project=${MY_GCP_PROJECT} --region="europe-southwest1"
   ```


## Clear Resources


1. Command:

   ```bash
   terraform -chdir="./infra" destroy --auto-approve
   ```