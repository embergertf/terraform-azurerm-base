#
# Copyright 2022 Emmanuel Bergerat
#

#--------------------------------------------------------------
#   Test Base module by displaying the outputs
#--------------------------------------------------------------
# base_cascade module instance outputs
output "base_cascade_name" {
  value = module.base_cascade.name
}
output "base_cascade_location" {
  value = module.base_cascade.location
}
output "base_cascade_location_display_name" {
  value = module.base_cascade.location_display_name
}
output "base_cascade_tags" {
  value = module.base_cascade.tags
}
output "base_cascade_random_suffix" {
  value = module.base_cascade.random_suffix
}
output "base_cascade_naming_values" {
  value = module.base_cascade.naming_values
}

/*
# rg_override module instance outputs
output "rg_override_name" {
  value = module.rg_override.name
}
output "rg_override_location" {
  value = module.rg_override.location
}
output "rg_override_location_display_name" {
  value = module.rg_override.location_display_name
}
output "rg_override_tags" {
  value = module.rg_override.tags
}
output "rg_override_random_suffix" {
  value = module.rg_override.random_suffix
}
#*/

# base_naming_values module instance outputs
output "base_naming_values_name" {
  value = module.base_naming_values.name
}
output "base_naming_values_location" {
  value = module.base_naming_values.location
}
output "base_naming_values_location_display_name" {
  value = module.base_naming_values.location_display_name
}
output "base_naming_values_tags" {
  value = module.base_naming_values.tags
}
output "base_naming_values_random_suffix" {
  value = module.base_naming_values.random_suffix
}
output "base_naming_values_naming_values" {
  value = module.base_naming_values.naming_values
}
