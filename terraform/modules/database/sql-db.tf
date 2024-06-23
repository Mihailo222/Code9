resource "azurerm_mssql_server" "server" {
  name                         = var.server_name
  resource_group_name          = var.resource_group
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.admin_login
  administrator_login_password = var.administrator_login_password
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "db" {
  name           = var.database
  server_id      = azurerm_mssql_server.server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 2
  sku_name       = var.sku_name

  lifecycle {
    prevent_destroy = true
  }
}

