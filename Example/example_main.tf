#
# Copyright 2022 Emmanuel Bergerat
#

#--------------------------------------------------------------
#   Test Base module Main
#--------------------------------------------------------------
# Test naming cascade
module "base_cascade" {
  # Local use
  source = "../../terraform-azurerm-base"

  region_code = "cac"
  subsc_code  = "mcaps"
  env         = "dev"
  base_name   = "basemodule"
  # additional_name = ""
  iterator   = "01"
  owner      = "john.doe@internet.com"
  add_random = true
  rnd_length = 2
  additional_tags = {
    app_id  = "1"
    test_by = "emberger"
  }

  # Resource naming inputs
  resource_type_code = "rg"
  max_length         = 64
  no_dashes          = false
}

/*
# Test name override
module "base_override" {
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
#*/

# Test naming_values
module "base_naming_values" {
  # Local use
  source = "../../terraform-azurerm-base"

  naming_values = module.base_cascade.naming_values
  region_code   = "uscn"

  # Resource naming inputs
  resource_type_code = "test"
  max_length         = 64
  no_dashes          = false
}
#*/
