resource "azurerm_virtual_network_gateway_connection" "virtual_network_gateway_connections" {
  for_each = var.virtual_network_gateway_connections

  name                = coalesce(each.value.name, each.key)
  location            = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name = each.value.resource_group.name
  tags                = merge(var.default_tags, each.value.tags)

  type                       = each.value.type
  virtual_network_gateway_id = each.value.virtual_network_gateway_id
  express_route_circuit_id   = each.value.express_route_circuit_id
}

