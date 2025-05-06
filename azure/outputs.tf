output "resource_groups" {
  value = {
    for k, rg in azurerm_resource_group.azure_resource_groups : k => {
      id = rg.id
      name = rg.name
    }
  }
}