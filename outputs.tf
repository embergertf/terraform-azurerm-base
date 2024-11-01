#
# Copyright 2022 Emmanuel Bergerat
#

output "name" {
  value       = local.resource_name
  description = "The generated name of the resource by the module."
}
output "location" {
  # value       = local.location_name
  value       = local.locations_map[local.region_code].location
  description = "Location name compliant with `Azure Regions`' names. The list can be fetched with `az account list-locations --query '[].name'`."
}
output "location_display_name" {
  value       = local.locations_map[local.region_code].display_name
  description = "Location display name."
}
output "tags" {
  value       = local.base_tags
  description = "Set of Azure tags for the resource."
}

output "random_suffix" {
  value       = local.random_suffix == "" ? null : local.random_suffix
  description = "Randomized piece of the name, if used, for any name manipulation."
}

output "naming_values" {
  value = {
    region_code     = local.region_code
    subsc_code      = local.subsc_code
    env             = local.env
    base_name       = local.base_name
    additional_name = local.additional_name
    iterator        = local.iterator
    owner           = local.owner
    additional_tags = local.additional_tags
    # resource_name         = local.resource_name
    # location              = local.locations_map[var.region_code].location
    # location_display_name = local.locations_map[var.region_code].display_name
    # tags                  = local.base_tags
    # random_suffix         = local.random_suffix
  }
  description = "A terraform object with the naming values in 1 variable."
}
