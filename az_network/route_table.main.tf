resource "azurerm_route_table" "network_route_tables" {
  for_each = var.network_route_tables

  name                = each.key
  location            = each.value.resource_group.location
  resource_group_name = each.value.resource_group.name
  tags                = each.value.tags

  dynamic "route" {
    for_each = each.value.routes
    content {
      name = route.key
      address_prefix = route.value.address_prefix
      next_hop_type = route.value.next_hop_type
      next_hop_in_ip_address = route.value.next_hop_in_ip_address
    }
  }
}

resource "azurerm_subnet_route_table_association" "network_route_table_subnet_associations" {
  for_each = { for k, v in var.network_route_tables : k => v if v.subnet_association != null }

  subnet_id                 = each.value.subnet_association.id
  route_table_id = azurerm_route_table.network_route_tables[each.key].id
}