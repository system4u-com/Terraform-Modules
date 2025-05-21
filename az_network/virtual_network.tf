resource "azurerm_virtual_network" "virtual_networks" {
  for_each = var.virtual_networks

  name                = each.key
  resource_group_name = each.value.resource_group.name
  location            = each.value.resource_group.location
  address_space       = each.value.address_space
  dns_servers         = each.value.dns_servers
  tags                = each.value.tags
}

resource "azurerm_virtual_network_peering" "peerings" {
  for_each = var.peerings

  name                         = coalesce(each.value.name,each.key)
  resource_group_name          = each.value.resource_group.name
  virtual_network_name         = each.value.virtual_network.name
  remote_virtual_network_id    = each.value.remote_virtual_network.id
  allow_virtual_network_access = each.value.allow_virtual_network_access
}