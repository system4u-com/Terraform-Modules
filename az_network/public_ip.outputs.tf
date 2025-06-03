output "public_ips" {
  value = {
    for k, value in azurerm_public_ip.public_ips : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "public_ips_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.public_ips_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
      metrics                   = value.metric
    }
  }
}