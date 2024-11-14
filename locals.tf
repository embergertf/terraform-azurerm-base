#
# Copyright 2024 - Emmanuel Bergerat
#

# Region
locals {
  # -
  # - Generate the Azure Location name
  # -
  locations_map        = jsondecode(file("${path.module}/locations.json"))
  location_keys        = keys(local.locations_map)
  location_keys_string = join(", ", local.location_keys)
}

# Naming values logic
locals {
  # Naming values cascade
  region_code     = var.region_code != null ? var.region_code : var.naming_values == null ? null : var.naming_values["region_code"] != null ? var.naming_values["region_code"] : null
  subsc_code      = var.subsc_code != null ? var.subsc_code : var.naming_values == null ? null : var.naming_values["subsc_code"] != null ? var.naming_values["subsc_code"] : null
  env             = var.env != null ? var.env : var.naming_values == null ? null : var.naming_values["env"] != null ? var.naming_values["env"] : null
  base_name       = var.base_name != null ? var.base_name : var.naming_values == null ? null : var.naming_values["base_name"] != null ? var.naming_values["base_name"] : null
  additional_name = var.additional_name != null ? var.additional_name : var.naming_values == null ? null : var.naming_values["additional_name"] != null ? var.naming_values["additional_name"] : null
  iterator        = var.iterator != null ? var.iterator : var.naming_values == null ? null : var.naming_values["iterator"] != null ? var.naming_values["iterator"] : null
  owner           = var.owner != null ? var.owner : var.naming_values == null ? null : var.naming_values["owner"] != null ? var.naming_values["owner"] : null
  additional_tags = var.naming_values == null ? (var.additional_tags == null ? null : var.additional_tags) : var.naming_values["additional_tags"] != null ? merge(var.naming_values["additional_tags"], var.additional_tags) : null
}

# Resource Name
locals {
  # - Generate name separator (dash or no dash)
  separator = var.no_dashes == true ? "" : "-"

  ### - Resource name generation Cascade
  # Build mandatory prefix
  rn_with_regioncode = join(local.separator, [var.resource_type_code, local.region_code])

  # Add subscription, if any
  rn_with_sub = local.subsc_code != null && local.subsc_code != "" ? join(local.separator, [local.rn_with_regioncode, local.subsc_code]) : local.rn_with_regioncode

  # Add environment, if any
  rn_with_env = local.env != null && local.env != "" ? join(local.separator, [local.rn_with_sub, local.env]) : local.rn_with_sub

  # Add base name, if any
  rn_with_basename = local.base_name != null && local.base_name != "" ? join(local.separator, [local.rn_with_env, local.base_name]) : local.rn_with_env

  # Add additional name, if any
  rn_with_additionalname = local.additional_name != null && local.additional_name != "" ? join(local.separator, [local.rn_with_basename, local.additional_name]) : local.rn_with_basename

  # Add iterator, if any
  rn_with_iterator = local.iterator != null && local.iterator != "" ? join(local.separator, [local.rn_with_additionalname, local.iterator]) : local.rn_with_additionalname


  # If name_override was used, we replace
  rn_generated = var.name_override != null && var.name_override != "" ? join(local.separator, [var.resource_type_code, var.name_override]) : local.rn_with_iterator


  ### - Tune the name generated
  # Ensure remove dashes (some may come from within the variables' values)
  rn_dashes = var.no_dashes == true ? replace(local.rn_generated, "-", "") : local.rn_generated

  # Trim to max length and generate completed resource name
  rn_trimmed = length(local.rn_dashes) > var.max_length ? substr(local.rn_dashes, 0, var.max_length) : local.rn_dashes

  # If selected, add the random id at the end by replacing the var.rnd_length last characters of the name
  # - Generate Random suffix (Defaults: number type, 3 digits, 0 padding)
  random_suffix = var.add_random == true ? format("%0${var.rnd_length}s", substr(random_id.this[0].dec, 0, var.rnd_length)) : ""
  resource_name = var.add_random == true ? "${substr(local.rn_trimmed, 0, (var.max_length - (var.rnd_length + length(local.separator))))}${local.separator}${local.random_suffix}" : local.rn_trimmed
}

# Tags
locals {
  # Date tag(s)
  UTC_to_TZ      = var.UTC_to_TZ
  TZ_suffix      = var.TZ_suffix
  created_now    = time_static.this.rfc3339
  created_TZtime = timeadd(local.created_now, local.UTC_to_TZ)
  created_nowTZ  = "${formatdate("YYYY-MM-DD hh:mm", local.created_TZtime)} ${local.TZ_suffix}" # 2020-06-16 14:44 EST
  date_tags = {
    Created_on = local.created_nowTZ
  }

  # Generated tag(s)
  generated_tags = {
    Created_with = "terraform ~> 1.0"
    Environment  = local.env
    Owner        = local.owner
  }

  # Create base tags
  base_tags = merge(
    local.generated_tags,
    local.date_tags,
    local.additional_tags
  )
}
