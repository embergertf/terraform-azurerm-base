<!-- BEGIN_TF_DOCS -->
# Base module

## Overview

This Base module provides the following features:

- From a given allowed `region_code`, the module gives the Azure `location name` to use in resource's creation,
- From the inputs (subsc\_code, env, base\_name, etc.) and an Azure resource abbreviation ([Recommended abbreviations for Azure resource types](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)), the module generates the resource name, according to the Naming Standard:
  - [`resource_type_code`]`-`[`region_code`]`-`[`subsc_code`]`-`[`env`]`-`[`base_name`][(optional)`-additional_name`][(optional)`-iterator`][(optional - see below)`-random_number`]
- To ease specific cases, it is possible to override the name generation by setting a value for the `name_override` variable,
- Some resources require their **name to be globally unique**:
  - To support that case, the option to set `add_random = true` is available. When activated, a `random_number`, padding 0, is added to the resource name generated. The length of the numbers added is set by the variable `rnd_length`.
- Some resources require a **maximum name length** ([Naming rules and restrictions for Azure resources](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)):
  - To accommodate this need, the option `max_length` is available to set the maximum length of the generated name. It trims the name keeping its left portion. If a random number is required, it will replace the last characters of the name with the random number.
- Some resources require to be **named with characters only**:
  - To accommodate this requirement, the option `no_dashes = true` is available. When activated, dashes are removed from the generated name, even if some dashes were provided in the variables' values.

From the inputs provided to the Base module, the following `tags` are automatically generated:

- `environment = ""`
- `owner = ""`
- `created_on = ""`
- `created_with = ""`

The generated `tags` are completed with the tags eventually provided in the variable `additional_tags`,

The 3 main outputs to use in the resource(s) to create are:

- `name`
- `location`
- `tags`

## Notes

The management of the `created_on` tag is done with the help of the `time` Terraform provider. It captures the **FIRST time** the Base module was used to generate the name and stores the date in both the tag value and the module state.

## Example

This module is used within another module to generate the resource(s) name(s) through naming convention, when relevant for the resource(s).
To use it:

1. The module is called to generate a resource outputs (name, tags, location),
2. The module's outputs are used to create the resources.

### 1. Call the Base module

```yaml
module "rg_name" {
  # Local use
  #source = "../../terraform-azurerm-base"

  # Terraform Cloud/Enterprise use
  source  = "app.terraform.io/embergertf/base/azurerm"
  version = ">=1.0.0"

  region_code     = "usnc"
  subsc_code      = "azint"
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

```

### 2. Use the module's outputs in a resource

```yaml
# Test by creating a Resource Group with the module's outputs
resource "azurerm_resource_group" "this" {
  name      = module.rg_name.name
  location  = module.rg_name.location

  tags      = module.rg_name.tags
}
```

## Documentation
<!-- markdownlint-disable MD033 -->

### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.6 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.12 |

### Modules

No modules.

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_resource_type_code"></a> [resource\_type\_code](#input\_resource\_type\_code) | (Required) Azure resource type abbreviation. Example: `rg`, `vnet`, `st`, etc. More information: [Azure resource abbreviations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) | `string` | n/a | yes |
| <a name="input_TZ_suffix"></a> [TZ\_suffix](#input\_TZ\_suffix) | (Optional) Timezone suffix code. | `string` | `"EST"` | no |
| <a name="input_UTC_to_TZ"></a> [UTC\_to\_TZ](#input\_UTC\_to\_TZ) | (Optional) Timezone difference with UTC time. | `string` | `"-5h"` | no |
| <a name="input_add_random"></a> [add\_random](#input\_add\_random) | (Optional) When set to `true`, it will add a `rnd_length`'s long `random_number` at the name's end. | `bool` | `false` | no |
| <a name="input_additional_name"></a> [additional\_name](#input\_additional\_name) | (Optional) Additional suffix to create resource uniqueness. It will be separated by a `'-'` from the "name's generated" suffix. Example: `lan1`. | `string` | `null` | no |
| <a name="input_additional_tags"></a> [additional\_tags](#input\_additional\_tags) | (Optional) Additional base tags. | `map(string)` | `null` | no |
| <a name="input_base_name"></a> [base\_name](#input\_base\_name) | (Optional) Resource "base" name. Example: `aks`. | `string` | `null` | no |
| <a name="input_env"></a> [env](#input\_env) | (Optional) Environment code. Example: `test`. <br></br>&#8226; Value of `env` examples can be: `[nonprod,prod,core,int,uat,stage,dev,test]`. | `string` | `null` | no |
| <a name="input_iterator"></a> [iterator](#input\_iterator) | (Optional) Iterator to create resource uniqueness. It will be separated by a `'-'` from the "name's generated + additional\_name" concatenation. Example: `001`. | `string` | `null` | no |
| <a name="input_max_length"></a> [max\_length](#input\_max\_length) | (Optional) Set the maximum length of the generated name. If over, the name will be trimmed to the `max_length`, considering the eventual `random_number` suffix. See this link for reference: [Resource name rules](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules) | `number` | `63` | no |
| <a name="input_name_override"></a> [name\_override](#input\_name\_override) | (Optional) Full name to override all the name generation, except resource type code. Example: 'biglittletest' will generate the resource name "'<resource\_type\_code>-biglittletest'". | `string` | `null` | no |
| <a name="input_naming_values"></a> [naming\_values](#input\_naming\_values) | (Optional) A terraform object with the naming values in 1 variable. | <pre>object({<br>    region_code     = optional(string)<br>    subsc_code      = optional(string)<br>    env             = optional(string)<br>    base_name       = optional(string)<br>    additional_name = optional(string)<br>    iterator        = optional(string)<br>    owner           = optional(string)<br>    additional_tags = optional(map(string))<br>  })</pre> | `null` | no |
| <a name="input_no_dashes"></a> [no\_dashes](#input\_no\_dashes) | (Optional) When set to `true`, it will remove all `'-'` separators from the generated name. | `bool` | `false` | no |
| <a name="input_owner"></a> [owner](#input\_owner) | (Optional) Deployed resources owner. | `string` | `null` | no |
| <a name="input_region_code"></a> [region\_code](#input\_region\_code) | (Optional) Resource region code.<br></br>&#8226; Value of `region_code` must be one of: `[ cac, cae, uscn, use, use2, usnc, ussc, uswc, uswe, uswe2, uswe3 ]`. | `string` | `null` | no |
| <a name="input_rnd_length"></a> [rnd\_length](#input\_rnd\_length) | (Optional) Set the length of the `random_number` generated. | `number` | `2` | no |
| <a name="input_subsc_code"></a> [subsc\_code](#input\_subsc\_code) | (Optional) Subscription code or abbreviation. Example: `azint`. | `string` | `null` | no |

### Resources

| Name | Type |
|------|------|
| [random_id.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) | resource |
| [time_static.this](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_location"></a> [location](#output\_location) | Location name compliant with `Azure Regions`' names. The list can be fetched with `az account list-locations --query '[].name'`. |
| <a name="output_location_display_name"></a> [location\_display\_name](#output\_location\_display\_name) | Location display name. |
| <a name="output_name"></a> [name](#output\_name) | The generated name of the resource by the module. |
| <a name="output_naming_values"></a> [naming\_values](#output\_naming\_values) | A terraform object with the naming values in 1 variable. |
| <a name="output_random_suffix"></a> [random\_suffix](#output\_random\_suffix) | Randomized piece of the name, if used, for any name manipulation. |
| <a name="output_tags"></a> [tags](#output\_tags) | Set of Azure tags for the resource. |

<!-- END_TF_DOCS -->