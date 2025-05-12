output "linux_vms" {
  value = {
    for k, value in azurerm_linux_virtual_machine.linux_vms : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}

output "windows_vms" {
  value = {
    for k, value in azurerm_windows_virtual_machine.windows_vms : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}