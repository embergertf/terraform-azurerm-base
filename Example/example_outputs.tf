#
# Copyright 2024 Emmanuel Bergerat
#

#--------------------------------------------------------------
#   Test Base module by displaying the outputs
#--------------------------------------------------------------
# cascade module instance outputs
output "cascade_name" {
  value = module.cascade.name
}
output "cascade_location" {
  value = module.cascade.location
}
output "cascade_location_display_name" {
  value = module.cascade.location_display_name
}
output "cascade_tags" {
  value = module.cascade.tags
}
output "cascade_random_suffix" {
  value = module.cascade.random_suffix
}
output "cascade_naming_values" {
  value = module.cascade.naming_values
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

# naming_values module instance outputs
output "naming_values_name" {
  value = module.naming_values.name
}
output "naming_values_location" {
  value = module.naming_values.location
}
output "naming_values_location_display_name" {
  value = module.naming_values.location_display_name
}
output "naming_values_tags" {
  value = module.naming_values.tags
}
output "naming_values_random_suffix" {
  value = module.naming_values.random_suffix
}
output "naming_values_naming_values" {
  value = module.naming_values.naming_values
}
