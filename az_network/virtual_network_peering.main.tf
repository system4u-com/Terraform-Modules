resource "azurerm_virtual_network_peering" "virtual_network_peerings" {
  for_each = var.virtual_network_peerings

  name                         = coalesce(each.value.name,each.key)
  resource_group_name          = each.value.resource_group.name
  virtual_network_name         = each.value.virtual_network.name
  remote_virtual_network_id    = each.value.remote_virtual_network.id
  allow_virtual_network_access = each.value.allow_virtual_network_access
}