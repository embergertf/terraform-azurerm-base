#
# Copyright 2022 Emmanuel Bergerat
#

#--------------------------------------------------------------
#   Test Base module by displaying the outputs
#--------------------------------------------------------------
# rg_cascade module instance outputs
output "rg_cascade_name" {
  value = module.rg_cascade.name
}
output "rg_cascade_location" {
  value = module.rg_cascade.location
}
output "rg_cascade_location_display_name" {
  value = module.rg_cascade.location_display_name
}
output "rg_cascade_tags" {
  value = module.rg_cascade.tags
}
output "rg_cascade_random_suffix" {
  value = module.rg_cascade.random_suffix
}

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
