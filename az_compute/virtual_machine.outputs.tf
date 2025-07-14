output "virtual_machines" {
  value = {
    for k, value in azurerm_virtual_machine.virtual_machines : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}