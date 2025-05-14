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

resource "azurerm_express_route_circuit_peering" "express_route_circuit_peerings" {
  for_each = var.express_route_circuit_peerings

  peering_type                  = each.value.peering_type
  express_route_circuit_name    = each.value.express_route_circuit.name
  resource_group_name           = each.value.resource_group.name
  peer_asn                      = each.value.peer_asn
  primary_peer_address_prefix   = each.value.primary_peer_address_prefix
  secondary_peer_address_prefix = each.value.secondary_peer_address_prefix
  ipv4_enabled                  = each.value.ipv4_enabled
  vlan_id                       = each.value.vlan_id
  shared_key                    = each.value.shared_key
}
