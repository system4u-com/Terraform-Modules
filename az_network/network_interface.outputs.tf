output "network_interfaces" {
  value = {
    for k, value in azurerm_network_interface.network_interfaces : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "network_interfaces_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.network_interfaces_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      monitoring_log_analytics_workspace_id = value.log_analytics_workspace_id
      metrics                   = value.metric
    }
  }
  
}