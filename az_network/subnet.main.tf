resource "azurerm_subnet" "subnets" {
  for_each = var.subnets

<<<<<<< Updated upstream
  name                 = coalesce(each.value.name, each.key) // Use the key as the name if name not specified
  resource_group_name  = each.value.virtual_network.resource_group_name
  virtual_network_name = each.value.virtual_network.name
  address_prefixes     = each.value.address_prefixes
  service_endpoints    = each.value.service_endpoints
  
}
=======
  name                              = coalesce(each.value.name, each.key) // Use the key as the name if name not specified
  resource_group_name               = each.value.virtual_network.resource_group_name
  virtual_network_name              = each.value.virtual_network.name
  address_prefixes                  = each.value.address_prefixes
  service_endpoints                 = each.value.service_endpoints
  private_endpoint_network_policies = each.value.private_endpoint_network_policies
}
>>>>>>> Stashed changes
