data "azurerm_resource_group" "main" {
  name     = "rg-inf-${local.component}"
}