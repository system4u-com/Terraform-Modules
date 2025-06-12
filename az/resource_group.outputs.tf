output "resource_groups" {
  value = {
    for k, value in azurerm_resource_group.resource_groups : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}

output "unmanaged_resource_groups" {
  value = {
    for k, value in data.azurerm_resource_group.unmanaged_resource_groups : k => {
      id       = value.id
      name     = value.name
      location = value.location
    }
  }
}