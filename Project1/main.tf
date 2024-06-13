terraform {

  backend "azurerm" {
  resource_group_name  = "Code9-12"
  storage_account_name = "stacctfcode912"
  container_name       = "tfstate"
  key                  = "terraform.tfstate"
  }





  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.104.0"
    }
  }
}

provider "azurerm" {
features {}
subscription_id = "8cc22353-a906-4a10-80f7-2f15e3792a10"
}


resource "azurerm_app_service_plan" "web-app-react-code9-12-plan" {
  name                = "code912reactplan"
  location            = "westeurope"
  resource_group_name = "Code9-12"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "web-app-react-code9-12" {
  name                = "code912reactwebapp"
  location            = "westeurope"
  resource_group_name = "Code9-12"
  app_service_plan_id = azurerm_app_service_plan.web-app-react-code9-12-plan.id

  site_config {
    min_tls_version = "1.2"
  }
  https_only = true
 # connection_string {
 #   name  = "Database"
 #   type  = "SQLServer"
 #   value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
 # }
}

resource "azurerm_app_service_plan" "web-app-api-code9-12-plan" {
  name                = "code912backendplan"
  location            = "westeurope"
  resource_group_name = "Code9-12"

  sku {
    tier = "Basic"
    size = "B1"
  }
}

resource "azurerm_app_service" "web-app-api-code9-12" {
  name                = "code912backendwebapp"
  location            = "westeurope"
  resource_group_name = "Code9-12"
  app_service_plan_id = azurerm_app_service_plan.web-app-api-code9-12-plan.id

  site_config {
    dotnet_framework_version = "v6.0"
    min_tls_version = "1.2"
  }
  https_only = true

 # connection_string {
 #   name  = "Database"
 #   type  = "SQLServer"
 #   value = "Server=some-server.mydomain.com;Integrated Security=SSPI"
 # }
}



resource "azurerm_mssql_server" "code912dbserver" {
  name                         = "code912dbserver"
  resource_group_name          = "Code9-12"
  location                     = "westeurope"
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "veryStrongPass123"
  minimum_tls_version          = "1.2"
}

resource "azurerm_mssql_database" "code912db" {
  name           = "code912db"
  server_id      = azurerm_mssql_server.code912dbserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb    = 2
  sku_name       = "Basic"

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_storage_account" "code912stacc" {
  name                     = "code9fullstacksa"
  resource_group_name      = "Code9-12"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier = "Hot"
  public_network_access_enabled = true
}


resource "azurerm_storage_container" "stcode9container01" {
  name                  = "code9apifiles"
  storage_account_name  = azurerm_storage_account.code912stacc.name
  container_access_type = "private"
}



resource "azurerm_storage_account" "code912tfacc" {
  name                     = "code9tfacc"
  resource_group_name      = "Code9-12"
  location                 = "westeurope"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  access_tier = "Hot"
  public_network_access_enabled = true
}


resource "azurerm_storage_container" "code912tfstate" {
  name                  = "code912tfstate"
  storage_account_name  = azurerm_storage_account.code912tfacc.name
  container_access_type = "private"
}


resource "azurerm_key_vault" "code9-12-key-vault" {
  name                        = "keyvaultcode912"
  location                    = "westeurope"
  resource_group_name         = "Code9-12"
  enabled_for_disk_encryption = true
  tenant_id                   = "40758481-7365-442c-ae94-563ed1606218"
  soft_delete_retention_days  = 7
  purge_protection_enabled    = false

  sku_name = "standard"
  enable_rbac_authorization = true
}