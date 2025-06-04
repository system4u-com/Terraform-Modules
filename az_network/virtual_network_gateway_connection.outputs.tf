output "virtual_network_gateway_connections" {
  value = {
    for k, value in azurerm_virtual_network_gateway_connection.virtual_network_gateway_connections : k => {
      id                        = value.id
      name                      = value.name
      resource_group_name       = value.resource_group_name
      type                      = value.type
      virtual_network_gateway_id = value.virtual_network_gateway_id
      express_route_circuit_id   = value.express_route_circuit_id
    }
  }
  
}