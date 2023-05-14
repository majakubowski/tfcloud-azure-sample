resource "azurerm_resource_group" "this" {
  name     = "rg-${var.project_prefix}-${var.env}"
  location = var.location
}

resource "azurerm_user_assigned_identity" "this" {
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  name                = "id-${var.project_prefix}-${var.env}"
}

resource "azurerm_storage_account" "this" {
  name                            = "st${var.project_prefix}${var.env}"
  resource_group_name             = azurerm_resource_group.this.name
  location                        = var.location
  account_kind                    = "StorageV2"
  account_tier                    = "Standard"
  account_replication_type        = var.replicationtype
  enable_https_traffic_only       = true
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = false
  blob_properties {
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }
}

resource "azurerm_service_plan" "this" {
  name                = "asp-${var.project_prefix}-${var.env}"
  resource_group_name = azurerm_resource_group.this.name
  location            = var.location
  os_type             = "Windows"
  sku_name            = var.plan_sku
}

resource "azurerm_log_analytics_workspace" "this" {
  name                = "la-${var.project_prefix}-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
}

resource "azurerm_application_insights" "this" {
  name                = "appi-${var.project_prefix}-portalapi-${var.env}"
  location            = var.location
  resource_group_name = azurerm_resource_group.this.name
  workspace_id        = azurerm_log_analytics_workspace.this.id
  application_type    = "web"
}

resource "azurerm_windows_function_app" "this" {
  name                       = "func-${var.project_prefix}-${var.env}"
  resource_group_name        = azurerm_resource_group.this.name
  location                   = var.location
  https_only                 = true
  storage_account_name       = azurerm_storage_account.this.name
  storage_account_access_key = azurerm_storage_account.this.primary_access_key
  service_plan_id            = azurerm_service_plan.this.id
  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.this.id]
  }
  app_settings = {
    "WEBSITE_ENABLE_SYNC_UPDATE_SITE" = "true"
    FUNCTIONS_WORKER_RUNTIME          = "dotnet-isolated"
  }
  site_config {
    ftps_state                             = "FtpsOnly"
    application_insights_connection_string = azurerm_application_insights.this.connection_string
    application_insights_key               = azurerm_application_insights.this.instrumentation_key
  }
  lifecycle {
    ignore_changes = [
      auth_settings,
      tags,
      app_settings["WEBSITE_RUN_FROM_PACKAGE"]
    ]
  }
}
