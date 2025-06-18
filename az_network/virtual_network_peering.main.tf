resource "azurerm_virtual_network_peering" "virtual_network_peerings" {
  for_each = var.virtual_network_peerings

  name                         = coalesce(each.value.name,each.key)
  resource_group_name          = each.value.resource_group.name
  virtual_network_name         = each.value.virtual_network.name
  remote_virtual_network_id    = each.value.remote_virtual_network.id
  allow_virtual_network_access = each.value.allow_virtual_network_access
  allow_gateway_transit        = each.value.allow_gateway_transit
  allow_forwarded_traffic      = each.value.allow_forwarded_traffic
  use_remote_gateways          = each.value.use_remote_gateways
}