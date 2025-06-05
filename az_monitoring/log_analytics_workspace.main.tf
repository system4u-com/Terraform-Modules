resource "azurerm_log_analytics_workspace" "log_analytics_workspaces" {
  for_each = var.log_analytics_workspaces

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name
  sku                 = each.value.sku
  retention_in_days   = each.value.retention_in_days
  tags                = each.value.tags
}

resource "azurerm_sentinel_log_analytics_workspace_onboarding" "log_analytics_workspace_onboarding" {
  for_each = var.log_analytics_workspace_onboarding

  workspace_id                 = each.value.workspace_id
  customer_managed_key_enabled = each.value.customer_managed_key_enabled
}

resource "azurerm_monitor_diagnostic_setting" "log_analytics_workspaces_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
    { for k, v in var.log_analytics_workspaces : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) } :
    { for k, v in var.log_analytics_workspaces : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) }
  ) : {}

  name                       = "${each.key}-diagnostic-setting"
  target_resource_id         = azurerm_log_analytics_workspace.log_analytics_workspaces[each.key].id
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

  enabled_log {
    category = each.value.monitoring.log_category
    category_group = (
      each.value.monitoring.log_category == null || each.value.monitoring.log_category == "" ?
      coalesce(each.value.monitoring.log_category_group, "Audit") :
      null
    )
  }
  dynamic "metric" {
    for_each = each.value.monitoring.metrics != null ? each.value.monitoring.metrics : []
    content {
      category = metric.value
      enabled  = each.value.monitoring.metrics_enabled
    }
  }
  lifecycle {
    ignore_changes = [
      metric
    ]
  }
}
