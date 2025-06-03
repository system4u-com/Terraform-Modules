resource "azurerm_virtual_network_gateway" "virtual_network_gateways" {
  for_each = var.virtual_network_gateways

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name
  type                = each.value.type
  sku                 = each.value.sku

  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name                          = ip_configuration.key
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      subnet_id                     = ip_configuration.value.subnet_id
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "virtual_network_gateways_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
      { for k, v in var.virtual_network_gateways : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) } :
      { for k, v in var.virtual_network_gateways : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) }
  ) : {}

  name               = "${each.key}-diagnostic-setting"
  target_resource_id = azurerm_virtual_network_gateway.virtual_network_gateways[each.key].id
  log_analytics_workspace_id = coalesce(each.value.monitoring.log_analytics_workspace_id, var.log_analytics_workspace_id)

  enabled_log {
    category = each.value.monitoring.log_category
    category_group = (
      each.value.monitoring.log_category == null || each.value.monitoring.log_category == "" ?
      coalesce(each.value.monitoring.log_category_group, "Audit") :
      null
    )
  }

  metric {
    category = coalesce(each.value.monitoring.metrics, "AllMetrics")
    enabled = each.value.monitoring.metrics_enabled
  }
}