terraform {
  required_providers {
    datadog = {
      source = "DataDog/datadog"
    }
  }
  cloud {
    organization = "kufta"
    workspaces {
      name = "Hackday2023"
    }
  }
}

# CONFIGURE PROVIDER AND CREDENTIALS
provider "datadog" {
  api_key = var.DD_API_KEY
  app_key = var.DD_APP_KEY
}

variable "DD_API_KEY" {
  type        = string
  description = "Datadog API key"
}
variable "DD_APP_KEY" {
  type        = string
  description = "Datadog app key"
}