output "resource_groups" {
  value = {
    for k, value in azurerm_resource_group.azure_resource_groups : k => {
      id = value.id
      name = value.name
      location = value.location
    }
  }
}

output "virtual_networks" {
  value = {
    for k, value in azurerm_virtual_network.azure_virtual_networks : k => {
      id = value.id
      name = value.name
      location = value.location
      resource_group_name = value.resource_group_name
    }
  }
}