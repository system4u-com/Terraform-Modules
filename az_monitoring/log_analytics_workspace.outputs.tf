output "log_analytics_workspaces" {
  value = {
    for k, value in azurerm_log_analytics_workspace.log_analytics_workspaces : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}

output "log_analytics_workspaces_monitoring" {
  value = {
    for k, value in azurerm_monitor_diagnostic_setting.log_analytics_workspaces_monitoring : k => {
      id                        = value.id
      name                      = value.name
      target_resource_id        = value.target_resource_id
      monitoring_log_analytics_workspace_id = value.log_analytics_workspace_id
      logs                      = value.enabled_log
      metrics                   = value.metric
    }
  }
  
}