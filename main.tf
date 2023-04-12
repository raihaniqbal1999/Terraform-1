resource "azurerm_storage_account" "testsa" {
  name                     = "${var.project_name}${lower(var.environment)}testsa"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_kind             = "StorageV2"
  account_replication_type = "GRS"
  is_hns_enabled           = true
  sftp_enabled             = true

  blob_properties {
    delete_retention_policy {
      days = 365
    }
    container_delete_retention_policy {
      days = 365
    }
  }
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "${var.project_name}${lower(var.environment)}container"
  storage_account_name  = azurerm_storage_account.testsa.name
  container_access_type = "private"
}