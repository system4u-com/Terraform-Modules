output "windows_vms" {
  value = {
    for k, value in azurerm_windows_virtual_machine.windows_vms : k => {
      id                    = value.id
      name                  = value.name
      location              = value.location
      tags                  = value.tags
    }
  }
}
