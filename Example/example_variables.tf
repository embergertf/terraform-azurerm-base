#
# Copyright 2024 Emmanuel Bergerat
#

#--------------------------------------------------------------
#   Test Key vault module variables
#--------------------------------------------------------------
#   / Naming
variable "name_override" { default = null }
variable "region_code" { default = null }
variable "subsc_code" { default = null }
variable "env" { default = null }
variable "base_name" { default = null }
variable "additional_name" { default = null }
variable "iterator" { default = null }
variable "owner" { default = null }
variable "add_random" { default = null }
variable "rnd_length" { default = null }
variable "additional_tags" {
  description = "(Optional) Additional base tags."
  type        = map(string)
  default     = null
}
variable "naming_values" {
  type = object({
    region_code     = optional(string)
    subsc_code      = optional(string)
    env             = optional(string)
    base_name       = optional(string)
    additional_name = optional(string)
    iterator        = optional(string)
    owner           = optional(string)
    additional_tags = optional(map(string))
  })
  description = "(Optional) A terraform object with the naming values in 1 variable."
  default     = null
}
variable "additional_tags_1" { default = null }
