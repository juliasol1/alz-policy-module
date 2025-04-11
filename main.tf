# Include the additional policies and override archetypes
provider "alz" {
  library_references = [
    {
      path = "platform/alz",
      # should i keep this string empty, or do versioning?
      ref  = ""
    },
    {
      custom_url = "${path.root}/lib"
    }
  ]
}

# This allows us to get the tenant id
data "azurerm_client_config" "current" {}

# The provider shouldn't have any unknown values passed in, or it will mark
# all resources as needing replacement.
locals {
  location                              = "swedencentral"
  architecture_name                     = "custom"
  enable_telemetry                      = false
}

module "avm-ptn-alz" {
  source  = "Azure/avm-ptn-alz/azurerm"
  version = "0.11.1"
  architecture_name  = local.architecture_name
  parent_resource_id = data.azurerm_client_config.current.tenant_id
  location           = local.location
  enable_telemetry   = local.enable_telemetry
}

