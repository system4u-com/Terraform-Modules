output "subnets" {
  value = {
    for k, value in azurerm_subnet.subnets : k => {
      id                   = value.id
      name                 = value.name
      resource_group_name  = value.resource_group_name
      virtual_network_name = value.virtual_network_name
    }
  }
}