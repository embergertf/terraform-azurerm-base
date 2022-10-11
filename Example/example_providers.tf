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
      version = "~>3.0"
    }
  }
}