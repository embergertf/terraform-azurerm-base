#
# Copyright 2022 Emmanuel Bergerat
#

#--------------------------------------------------------------
#   Test Base module Main
#--------------------------------------------------------------
# Test naming cascade
module "rg_cascade" {
  # Local use
  source = "../../terraform-azurerm-base"

  region_code     = "cac"
  subsc_code      = "mcaps"
  env             = "dev"
  base_name       = "basemodule"
  additional_name = ""
  iterator        = "01"
  owner           = "john.doe@internet.com"
  additional_tags = {
    app_id  = "1"
    test_by = "emberger"
  }

  # Resource naming inputs
  resource_type_code = "rg"
  max_length         = 64
  no_dashes          = false
  add_random         = true
  rnd_length         = 2
}

# # Test the base module outputs by creating a Resource Group
# resource "azurerm_resource_group" "this" {
#   name     = module.rg_cascade.name
#   location = module.rg_cascade.location

#   tags = merge(module.rg_cascade.tags, {
#     random_suffix = module.rg_cascade.random_suffix
#   })
# }

# Test name override
module "rg_override" {
  # Local use
  source = "../../terraform-azurerm-base"

  name_override = "biglittleoverride"
  additional_tags = {
    app_id  = "4"
    test_by = "github"
  }

  # Resource naming inputs
  resource_type_code = "rg"
  max_length         = 64
  no_dashes          = false
  add_random         = true
  rnd_length         = 2
}

# # Test the base module outputs by creating a Resource Group
# resource "azurerm_resource_group" "or" {
#   name     = module.rg_override.name
#   location = module.rg_override.location

#   tags = merge(module.rg_override.tags, {
#     random_suffix = module.rg_cascade.random_suffix
#   })
# }
