#
# Copyright 2022 Emmanuel Bergerat
#

#--------------------------------------------------------------
#   Provider to Test Subscription
#--------------------------------------------------------------
provider "azurerm" {
  # Reference: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs#argument-reference
  alias = "testSubscription" # Comment/Remove this alias as it may not be needed

  environment = "public"
  partner_id  = "adb8eac6-989a-5354-8580-19055546ec74"

  tenant_id       = "<Put testSubscription tenant_id value>"
  subscription_id = "<Put testSubscription subscription_id value>"
  client_id       = "<Put testSubscription client_id value>"
  client_secret   = "<Put testSubscription client_secret value>"

  features {}
}