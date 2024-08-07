
variable "project" {
  description = "Project name"
  type        = string
  default     = "MY_GCP_PROJECT"
}

variable "region" {
  description = "Location"
  type        = string
  default     = "EU"
}

variable "location" {
  description = "Location"
  type        = string
  default     = "europe-southwest1"
}


variable "datasets" {
  description = "Datasets"
  type        = set(string)
  default     = ["example_dataset_raw", "example_dataset_staging", "example_dataset_mart"]
}
