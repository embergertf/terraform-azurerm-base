#
# Copyright 2022 Emmanuel Bergerat
#

# -
# - Required Terraform providers & versions
# -
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">=3.1.0"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.7.2"
    }
  }
}
