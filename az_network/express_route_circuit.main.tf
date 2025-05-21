resource "azurerm_express_route_circuit" "express_route_circuits" {
  for_each = var.express_route_circuits

  name                     = coalesce(each.value.name, each.key)
  location                 = coalesce(each.value.location, each.value.resource_group.location) // Use the location from the resource group if not specified
  resource_group_name      = each.value.resource_group.name
  service_provider_name    = each.value.service_provider_name
  peering_location         = each.value.peering_location
  bandwidth_in_mbps        = each.value.bandwidth_in_mbps
  express_route_port_id    = each.value.express_route_port_id
  bandwidth_in_gbps        = each.value.bandwidth_in_gbps
  allow_classic_operations = each.value.allow_classic_operations

  sku {
    tier   = each.value.sku.tier
    family = each.value.sku.family
  }

  tags = each.value.tags
}