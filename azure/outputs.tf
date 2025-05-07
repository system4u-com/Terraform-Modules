output "resource_groups" {
  value = {
    for k, value in azurerm_resource_group.resource_groups : k => {
      id = value.id
      name = value.name
      location = value.location
    }
  }
}

output "virtual_networks" {
  value = {
    for k, value in azurerm_virtual_network.virtual_networks : k => {
      id = value.id
      name = value.name
      location = value.location
      resource_group_name = value.resource_group_name
    }
  }
}

output "subnets" {
  value = {
    for k, value in azurerm_subnet.subnets : k => {
      id = value.id
      name = value.name
      resource_group_name = value.resource_group_name
    }
  }
}