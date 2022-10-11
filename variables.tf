#
# Copyright 2022 Emmanuel Bergerat
#

# -
# Required Variables
# -
variable "resource_type_code" {
  type        = string
  description = "(Required) Azure resource type abbreviation. Example: `rg`, `vnet`, `st`, etc. More information: [Azure resource abbreviations](https://docs.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations)"
}

# -
# Optional Variables
# -
variable "name_override" {
  type        = string
  description = "(Optional) Full name to override all the name generation, except resource type code. Example: 'biglittletest' will generate the resource name \"'<resource_type_code>-biglittletest'\"."
  default     = null
}

variable "region_code" {
  type        = string
  description = "(Optional) Resource region code.<br></br>&#8226; Value of `region_code` must be one of: `[usnc,ussc]`."
  validation {
    condition     = contains(["usnc", "ussc"], var.region_code)
    error_message = "Value of \"region_code\" must be one of: [usnc,ussc]."
  }
  default = "usnc"
}
variable "subsc_code" {
  type        = string
  description = "(Optional) Subscription code or abbreviation. Example: `azint`."
  default     = "azint"
}
variable "env" {
  type        = string
  description = "(Optional) Environment code. Example: `test`. <br></br>&#8226; Value of `env` examples can be: `[nonprod,prod,core,int,uat,stage,dev,test]`."
  default     = "test"
}
variable "base_name" {
  type        = string
  description = "(Optional) Resource \"base\" name. Example: `aks`."
  default     = null
}
variable "additional_name" {
  type        = string
  description = "(Optional) Additional suffix to create resource uniqueness. It will be separated by a `'-'` from the \"name's generated\" suffix. Example: `lan1`."
  default     = null
}
variable "iterator" {
  type        = string
  description = "(Optional) Iterator to create resource uniqueness. It will be separated by a `'-'` from the \"name's generated + additional_name\" concatenation. Example: `001`."
  default     = null
}
variable "owner" {
  type        = string
  description = "(Optional) Deployed resources owner."
  default     = "emberger"
}
variable "additional_tags" {
  description = "(Optional) Additional base tags."
  type        = map(string)
  default     = null
}

# -
# - Optional tuning switches & defaults
# -
variable "no_dashes" {
  type        = bool
  description = "(Optional) When set to `true`, it will remove all `'-'` separators from the generated name."
  default     = false
}
variable "add_random" {
  type        = bool
  description = "(Optional) When set to `true`, it will add a `rnd_length`'s long `random_number` at the name's end."
  default     = false
}
variable "max_length" {
  type        = number
  description = "(Optional) Set the maximum length of the generated name. If over, the name will be trimmed to the `max_length`, considering the eventual `random_number` suffix. See this link for reference: [Resource name rules](https://docs.microsoft.com/en-us/azure/azure-resource-manager/management/resource-name-rules)"
  default     = 63 # arbitrary default number chosen by browsing the list of major resources.
}
variable "rnd_length" {
  type        = number
  description = "(Optional) Set the length of the `random_number` generated."
  default     = 2
}