resource "azurerm_storage_account" "storigin" {
  name                     = "st${replace(local.component, "-", "")}origin"
  resource_group_name      = data.azurerm_resource_group.main.name
  location                 = data.azurerm_resource_group.main.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  tags                     = local.resource_tags
}

resource "azurerm_storage_container" "container" {
  name                  = "container1"
  storage_account_name  = azurerm_storage_account.storigin.name
  container_access_type = "private"
}

data "azurerm_storage_account_blob_container_sas" "example" {
  connection_string = azurerm_storage_account.storigin.primary_connection_string
  container_name    = azurerm_storage_container.container.name
  https_only        = true


  start  = "2023-05-30"
  expiry = "2024-03-21"

  permissions {
    read   = true
    add    = true
    create = false
    write  = false
    delete = true
    list   = true
  }

  cache_control       = "max-age=5"
  content_disposition = "inline"
  content_encoding    = "deflate"
  content_language    = "en-US"
  content_type        = "application/json"
}


resource "azurerm_storage_management_policy" "example" {
  storage_account_id ="${azurerm_storage_account.storigin.id}"
  rule {
    name    = "rule1"
    enabled = true
    filters {
      prefix_match = ["container1/prefix1"]
      blob_types   = ["blockBlob"]
      match_blob_index_tag {
        name      = "tag1"
        operation = "=="
        value     = "val1"
      }
    }
    actions {
      base_blob {
        tier_to_cool_after_days_since_modification_greater_than    = 10
        tier_to_archive_after_days_since_modification_greater_than = 50
        delete_after_days_since_modification_greater_than          = 100
      }
    }
  }
}

output "storage_account_connection_string_storigin" {
  value     = azurerm_storage_account.storigin.primary_connection_string
  sensitive = true
}

output "sas_url_query_string" {
  value = data.azurerm_storage_account_blob_container_sas.example.sas
  sensitive = true
}