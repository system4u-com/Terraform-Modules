resource "azurerm_virtual_network" "virtual_networks" {
  for_each = var.virtual_networks

  name                = coalesce(each.value.name, each.key)
  resource_group_name = each.value.resource_group.name
  location            = each.value.resource_group.location
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  tags                = each.value.tags
}

