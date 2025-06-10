output "workspaces" {
  value = {
    for k, value in azurerm_virtual_desktop_workspace.avd_workspaces : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}

output "application_groups" {
  value = {
    for k, value in azurerm_virtual_desktop_application_group.avd_application_groups : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}

output "host_pools" {
  value = {
    for k, value in azurerm_virtual_desktop_host_pool.avd_host_pools : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}

output "network_interfaces" {
  value = {
    for k, value in azurerm_network_interface.avd_network_interfaces : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}

output "hosts" {
  value = {
    for k, value in azurerm_windows_virtual_machine.avd_hosts : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}