################################################## Configuration ########################################################################

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
subscription_id = ""
}
################################################## Configuring infrastructure ########################################################################

module "react-app-service" {
  source = "../modules/app-service-front"
}

module "dot-net-api" {
  source = "../modules/app-service-api"
}

module "sql-db" {
  source = "../modules/database"
}

module "api-container" {
  source = "../modules/api-svc-files-container"
}

module "tf-container" {
  source = "../modules/terraform-state-file-container"
}

module "key_vault" {
  source = "../modules/key-vault"
}