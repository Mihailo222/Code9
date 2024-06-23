resource "azurerm_app_service_plan" "plan" {
  name                = var.api_app_svc_plan
  location            = var.location
  resource_group_name = var.resource_group

  sku {
    tier = var.sku_tier
    size = var.sku_size
  }
}

resource "azurerm_app_service" "app_svc_api" {
  name                = var.api_app_svc
  location            = var.location
  resource_group_name = var.resource_group
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    dotnet_framework_version = var.dot_net_framework_version
    min_tls_version = var.tls_version
  }
  https_only = true

}