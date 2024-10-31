#
# Copyright 2022 Emmanuel Bergerat
#

# -
# - Required Terraform providers & versions
# -
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = ">=3.6"
    }
    time = {
      source  = "hashicorp/time"
      version = ">=0.12"
    }
  }
}
