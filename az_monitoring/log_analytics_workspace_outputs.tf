output "log_analytics_workspaces" {
  value = {
    for k, value in azurerm_log_analytics_workspace.log_analytics_workspaces : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}