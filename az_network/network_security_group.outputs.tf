output "network_security_groups" {
  value = {
    for k, value in azurerm_network_security_group.network_security_groups : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "network_security_rules" {
  value = {
    for k, value in local.network_security_rules_flattened : k => {
      name                        = value.name
      network_security_group_name = value.network_security_group_name
      resource_group_name         = value.resource_group_name
    }
  }
}

output "network_security_groups_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.network_security_group_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      monitoring_log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
    }
  }
}