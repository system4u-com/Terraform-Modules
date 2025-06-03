output "virtual_networks" {
  value = {
    for k, value in azurerm_virtual_network.virtual_networks : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "virtual_networks_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.virtual_networks_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
      metrics                   = value.metric
    }
  }
}