resource "azurerm_storage_account" "storigin" {
  name                     = "st${replace(local.component, "-", "")}origin"
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.resource_tags
}

output "storage_account_connection_string_storigin" {
  value     = azurerm_storage_account.storigin.primary_connection_string
  sensitive = true
}