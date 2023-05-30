resource "azurerm_storage_account" "stdatalake" {
  name                     = "st${replace(local.component, "-", "")}datalake001"
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.resource_tags
  account_kind             = "StorageV2"
  is_hns_enabled           = "true"
}

output "storage_account_connection_string_stdatalake" {
  value     = azurerm_storage_account.stdatalake.primary_connection_string
  sensitive = true
}