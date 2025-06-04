resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connections" {
  for_each = var.virtual_network_gateway_connections

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name
  tags                = merge(var.default_tags, each.value.tags)

  type                       = each.value.type
  virtual_network_gateway_id = each.value.virtual_network_gateway_id
  express_route_circuit_id   = each.value.express_route_circuit_id
}

resource "azurerm_monitor_diagnostic_setting" "virtual_network_gateway_connections_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
      { for k, v in var.virtual_network_gateway_connections : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) } :
      { for k, v in var.virtual_network_gateway_connections : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) }
  ) : {}

  name               = "${each.key}-diagnostic-setting"
  target_resource_id = azurerm_virtual_network_gateway_connection.virtual_network_gateway_connections[each.key].id
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

  metric {
    category = coalesce(each.value.monitoring.metrics, "AllMetrics")
    enabled = each.value.monitoring.metrics_enabled
  }
}