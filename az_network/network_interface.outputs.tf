output "network_interfaces" {
  value = {
    for k, value in azurerm_network_interface.network_interfaces : k => {
      id                  = value.id
      name                = value.name
      location            = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

