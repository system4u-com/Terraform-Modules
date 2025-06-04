resource "azurerm_network_interface" "network_interfaces" {
  for_each = var.network_interfaces

  name                  = coalesce(each.value.name, each.key)
  location              = each.value.resource_group.location
  resource_group_name   = each.value.resource_group.name
  ip_forwarding_enabled = each.value.ip_forwarding_enabled
  dynamic "ip_configuration" {
    for_each = each.value.ip_configurations

    content {
      name                          = ip_configuration.key
      subnet_id                     = ip_configuration.value.subnet_id
      private_ip_address            = ip_configuration.value.private_ip_address
      private_ip_address_version    = ip_configuration.value.private_ip_address_version
      private_ip_address_allocation = ip_configuration.value.private_ip_address_allocation
      public_ip_address_id          = ip_configuration.value.public_ip_address_id
    }
  }
  
  tags = each.value.tags
}

resource "azurerm_monitor_diagnostic_setting" "network_interface_monitoring" {
  for_each = var.monitoring_enabled ? (
    length(var.monitoring_included_resources) > 0 ?
      { for k, v in var.network_interfaces : k => v if contains(var.monitoring_included_resources, coalesce(v.name, k)) } :
      { for k, v in var.network_interfaces : k => v if !contains(var.monitoring_excluded_resources, coalesce(v.name, k)) }
  ) : {}

  name               = "${each.key}-diagnostic-setting"
  target_resource_id = azurerm_network_interface.network_interfaces[each.key].id
  log_analytics_workspace_id = coalesce(each.value.monitoring.monitoring_log_analytics_workspace_id, var.monitoring_log_analytics_workspace_id)

  metric {
    category = coalesce(each.value.monitoring.metrics, "AllMetrics")
    enabled = each.value.monitoring.metrics_enabled
  }
}