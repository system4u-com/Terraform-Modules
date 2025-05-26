output "virtual_network_gateways" {
  value = {
    for k, value in azurerm_virtual_network_gateway.virtual_network_gateways : k => {
      id                        = value.id
      name                      = value.name
      resource_group_name       = value.resource_group_name
    }
  }
}