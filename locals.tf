#
# Copyright 2022 Emmanuel Bergerat
#

# Region
locals {
  # -
  # - Generate the Azure Location name
  # -
  location_name = lookup({
    "usnc" = "northcentralus",
    "ussc" = "southcentralus",
    "use"  = "eastus",
    "use2" = "eastus2",
    "cac"  = "canadacentral",
    "cae"  = "canadaeast",
    },
    lower(var.region_code), "Not found")
  
  location_display_name = lookup({
    "usnc" = "US North Central",
    "ussc" = "US South Central",
    "use"  = "US East",
    "use2" = "US East 2",
    "cac"  = "Canada Central",
    "cae"  = "Canada East",
    },
    lower(var.region_code), "Not found")
}

# Resource Name
locals {
  # - Generate name separator (dash or no dash)
  separator = var.no_dashes == true ? "" : "-"

  ### - Resource name generation Cascade
  # Build mandatory prefix
  rn_with_regioncode = join(local.separator, [var.resource_type_code, var.region_code])

  # Add subscription, if any
  rn_with_sub = var.subsc_code != null && var.subsc_code != "" ? join(local.separator, [local.rn_with_regioncode, var.subsc_code]) : local.rn_with_regioncode

  # Add environment, if any
  rn_with_env = var.env != null && var.env != "" ? join(local.separator, [local.rn_with_sub, var.env]) : local.rn_with_sub

  # Add base name, if any
  rn_with_basename = var.base_name != null && var.base_name != "" ? join(local.separator, [local.rn_with_env, var.base_name]) : local.rn_with_env

  # Add additional name, if any
  rn_with_additionalname = var.additional_name != null && var.additional_name != "" ? join(local.separator, [local.rn_with_basename, var.additional_name]) : local.rn_with_basename

  # Add iterator, if any
  rn_with_iterator = var.iterator != null && var.iterator != "" ? join(local.separator, [local.rn_with_additionalname, var.iterator]) : local.rn_with_additionalname


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
  UTC_to_TZ      = "-5h"
  TZ_suffix      = "EST"
  created_now    = time_static.this.rfc3339
  created_TZtime = timeadd(local.created_now, local.UTC_to_TZ)
  created_nowTZ  = "${formatdate("YYYY-MM-DD hh:mm", local.created_TZtime)} ${local.TZ_suffix}"      # 2020-06-16 14:44 EST
  date_tags = {
    Created_on   = local.created_nowTZ
  }

  # Generated tag(s)
  generated_tags = {
    Created_with = "terraform >=1.0.0"
    Environment  = var.env
    Owner        = var.owner
  }

  # Add additional_tags
  base_tags = merge(local.generated_tags, local.date_tags, var.additional_tags)
}
