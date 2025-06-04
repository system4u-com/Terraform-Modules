output "virtual_network_gateways" {
  value = {
    for k, value in azurerm_virtual_network_gateway.virtual_network_gateways : k => {
      id                        = value.id
      name                      = value.name
      resource_group_name       = value.resource_group_name
    }
  }
}

output "virtual_network_gateways_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.virtual_networks_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      monitoring_log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
      metrics                   = value.metric
    }
  }
  
}