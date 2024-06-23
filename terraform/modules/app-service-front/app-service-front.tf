resource "azurerm_app_service_plan" "plan" {
  name                = var.front_app_svc_plan
  location            = var.location
  resource_group_name = var.resource_group

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}

resource "azurerm_app_service" "app_svc" {
  name                = var.front_app_svc
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    min_tls_version = var.tls_version
  }
  https_only = true
}