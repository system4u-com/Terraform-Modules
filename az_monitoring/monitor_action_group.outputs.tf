output "monitor_action_groups" {
  value = {
    for k, value in azurerm_monitor_action_group.monitor_action_groups : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}