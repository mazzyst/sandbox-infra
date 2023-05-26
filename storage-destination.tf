resource "azurerm_storage_account" "stdestination" {
  name                     = "st${replace(local.component, "-", "")}destination"
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.resource_tags
}

output "storage_account_connection_string_stdestination" {
  value     = azurerm_storage_account.stdestination.primary_connection_string
  sensitive = true
}