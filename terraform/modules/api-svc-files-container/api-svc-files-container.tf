resource "azurerm_storage_account" "storage_acc" {
  name                     = var.storage_account
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = var.acc_tier
  account_replication_type = var.acc_replication_type
  access_tier = var.access_tier
  public_network_access_enabled = true
}


resource "azurerm_storage_container" "container01" {
  name                  = var.container_name
  storage_account_name  = azurerm_storage_account.storage_acc.name
  container_access_type = var.container_access_type
}


