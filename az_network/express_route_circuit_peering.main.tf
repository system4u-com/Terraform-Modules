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
