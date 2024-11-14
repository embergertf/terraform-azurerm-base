#
# Copyright 2024 Emmanuel Bergerat
#

# Created  on: Oct. 11th, 2022
# Created  by: Emmanuel
# Modified on: 
# Modified by: 
# Overview:
#   This module:
#   - Enforces naming conventions for resources in Azure,
#   - Maps region codes to Azure locations,
#   - Generates a set of pre-defined tags for the Azure resource.
#
#   It is designed to be used by other resources modules, like the Resource Group or the Storage Account ones.

# -
# - Generate randomization (if asked)
# -
resource "random_id" "this" {
  count       = var.add_random == true ? 1 : 0
  byte_length = 3
}

# -
# - Generate Timestamp for the date created_on
# -
resource "time_static" "this" {}
