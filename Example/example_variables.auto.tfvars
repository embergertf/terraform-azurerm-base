#
# Copyright 2023 Emmanuel Bergerat
#

#--------------------------------------------------------------
#   Test Base module variables' values
#--------------------------------------------------------------
naming_values = {
  region_code     = "uswe2"
  subsc_code      = "714895"
  env             = "dev"
  base_name       = "embergertf"
  additional_name = "kv"
  iterator        = "01"
  owner           = "Emm"
  additional_tags = {
    GitHub_org = "gopher194/embergertf"
    Module     = "keyvault"
    Purpose    = "Terraform modules development"
    Test_by    = "Emm"
  }
}

add_random = true
rnd_length = 5

additional_tags_1 = {
  Added_by = "base_module_localtest"
}

