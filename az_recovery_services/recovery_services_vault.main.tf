resource "azurerm_recovery_services_vault" "recovery_services_vaults" {
  for_each = var.recovery_services_vaults
  
  name                = coalesce(each.value.name, each.key)                               // Use the key as the name if not specified
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name

  sku               = each.value.sku
  storage_mode_type = each.value.storage_mode_type
  immutability      = each.value.immutability
  tags              = merge(var.default_tags, each.value.tags)
}

data "azurerm_monitor_diagnostic_categories" "recovery_services_vaults_diagnostic_categories" {
  for_each = var.recovery_services_vaults

  resource_id = azurerm_recovery_services_vault.recovery_services_vaults[each.key].id
}

resource "azurerm_monitor_diagnostic_setting" "recovery_services_vaults_diagnostic_settings" {
  for_each = var.default_diagnostic_setting_logs_enabled || var.default_diagnostic_setting_metrics_enabled ? var.recovery_services_vaults : {}

  name               = "Default-Diagnostic-Setting"
  target_resource_id = azurerm_recovery_services_vault.recovery_services_vaults[each.key].id
  log_analytics_workspace_id = var.default_diagnostic_setting_log_analytics_workspace_id

  dynamic "enabled_log" {
    for_each = var.default_diagnostic_setting_logs_enabled ? data.azurerm_monitor_diagnostic_categories.recovery_services_vaults_diagnostic_categories[each.key].log_category_types : []

    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = var.default_diagnostic_setting_metrics_enabled ? data.azurerm_monitor_diagnostic_categories.recovery_services_vaults_diagnostic_categories[each.key].metrics : []

    content {
      category = metric.value
    }
    
  }
}
