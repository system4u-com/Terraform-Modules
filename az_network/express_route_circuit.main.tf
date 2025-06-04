resource "azurerm_express_route_circuit" "express_route_circuits" {
  for_each = var.express_route_circuits

  name                     = coalesce(each.value.name, each.key)
  location                 = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name      = each.value.resource_group.name
  service_provider_name    = each.value.service_provider_name
  peering_location         = each.value.peering_location
  bandwidth_in_mbps        = each.value.bandwidth_in_mbps
  express_route_port_id    = each.value.express_route_port_id
  bandwidth_in_gbps        = each.value.bandwidth_in_gbps
  allow_classic_operations = each.value.allow_classic_operations

  sku {
    tier   = each.value.sku.tier
    family = each.value.sku.family
  }

  tags = each.value.tags
}

resource "azurerm_monitor_diagnostic_setting" "express_route_circuit_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
      { for k, v in var.express_route_circuits : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) } :
      { for k, v in var.express_route_circuits : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) }
  ) : {}

  name               = "${each.key}-diagnostic-setting"
  target_resource_id = azurerm_express_route_circuit.express_route_circuits[each.key].id
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

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