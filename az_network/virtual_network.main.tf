resource "azurerm_virtual_network" "virtual_networks" {
  for_each = var.virtual_networks

  name                = each.key
  resource_group_name = each.value.resource_group.name
  location            = each.value.resource_group.location
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  tags                = each.value.tags
}

resource "azurerm_monitor_diagnostic_setting" "virtual_networks_monitoring" {
  for_each = { for k, v in var.virtual_networks : k => v if v.monitoring.enabled == true }

  name               = "${each.key}-diagnostic-setting"
  target_resource_id = azurerm_virtual_network.virtual_networks[each.key].id
  log_analytics_workspace_id = coalesce(each.value.monitoring.log_analytics_workspace_id, var.log_analytics_workspace_id)

  enabled_log {
    category = each.value.monitoring.log_category
    category_group = (
      each.value.monitoring.log_category == null || each.value.monitoring.log_category == "" ?
      coalesce(each.value.monitoring.log_category_group, "allLogs") :
      null
    )
  }

  metric {
    category = coalesce(each.value.monitoring.metrics, "AllMetrics")
    enabled = each.value.monitoring.metrics_enabled
  }
}